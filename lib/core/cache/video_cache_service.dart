import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/video_feed/domain/entities/video_entity.dart';
import '../utils/logger.dart';

class VideoCacheService {
  VideoCacheService(this._dio);

  static const int _maxCacheBytes = 1024 * 1024 * 1024;
  static const int _maxConcurrentDownloads = 2;
  static const Duration _maxCacheAge = Duration(hours: 24);

  final Dio _dio;
  final Map<int, Future<File?>> _downloads = {};
  final Map<int, CancelToken> _cancelTokens = {};
  final Map<int, _PendingVideo> _pendingVideos = {};
  int _activeDownloads = 0;
  int _queueRevision = 0;

  Future<String> sourceFor(VideoEntity video) async {
    final cachedFile = await _cachedFile(video);
    if (cachedFile != null) {
      unawaited(cachedFile.setLastModified(DateTime.now()));
      return cachedFile.path;
    }

    return video.videoUrl;
  }

  void prefetchAll(Iterable<VideoEntity> videos) {
    prefetchWindow(videos, priorityIds: videos.map((video) => video.id));
  }

  Future<File?> prefetch(VideoEntity video) {
    final existing = _downloads[video.id];
    if (existing != null) return existing;
    final cached = _cachedFile(video);
    unawaited(
      cached.then((file) {
        if (file != null) return;
        _pendingVideos[video.id] = _PendingVideo(
          video: video,
          priority: 0,
          revision: ++_queueRevision,
        );
        _pumpQueue();
      }),
    );
    return existing ?? Future.value(null);
  }

  void prefetchWindow(
    Iterable<VideoEntity> videos, {
    required Iterable<int> priorityIds,
  }) {
    final priority = <int, int>{
      for (final entry in priorityIds.indexed) entry.$2: entry.$1,
    };
    final revision = ++_queueRevision;

    for (final video in videos) {
      if (_downloads.containsKey(video.id)) continue;
      _pendingVideos[video.id] = _PendingVideo(
        video: video,
        priority: priority[video.id] ?? 1 << 20,
        revision: revision,
      );
    }

    _pumpQueue();
  }

  void _pumpQueue() {
    while (_activeDownloads < _maxConcurrentDownloads &&
        _pendingVideos.isNotEmpty) {
      final next = _nextPendingVideo();
      if (next == null) return;
      _pendingVideos.remove(next.video.id);
      _startDownload(next.video);
    }
  }

  _PendingVideo? _nextPendingVideo() {
    final pending = _pendingVideos.values.toList()
      ..sort((a, b) {
        final priorityCompare = a.priority.compareTo(b.priority);
        if (priorityCompare != 0) return priorityCompare;
        return b.revision.compareTo(a.revision);
      });
    return pending.firstOrNull;
  }

  Future<File?> _startDownload(VideoEntity video) {
    _activeDownloads++;
    final cancelToken = CancelToken();
    _cancelTokens[video.id] = cancelToken;
    final download = _prefetch(video, cancelToken);
    _downloads[video.id] = download;
    return download.whenComplete(() {
      _downloads.remove(video.id);
      _cancelTokens.remove(video.id);
      _activeDownloads--;
      _pumpQueue();
    });
  }

  void cancelExcept(Set<int> keepIds) {
    _pendingVideos.removeWhere((id, _) => !keepIds.contains(id));
    for (final entry in List.of(_cancelTokens.entries)) {
      if (keepIds.contains(entry.key)) continue;
      entry.value.cancel('Video moved outside cache window');
    }
  }

  void cancelAll() {
    _pendingVideos.clear();
    for (final cancelToken in List.of(_cancelTokens.values)) {
      cancelToken.cancel('Video cache disposed');
    }
  }

  Future<File?> _prefetch(VideoEntity video, CancelToken cancelToken) async {
    final cachedFile = await _cachedFile(video);
    if (cachedFile != null) return cachedFile;

    final file = await _fileFor(video.id);
    final partialFile = File('${file.path}.part');

    try {
      await partialFile.parent.create(recursive: true);
      if (await partialFile.exists()) {
        await partialFile.delete();
      }

      await _dio.download(
        video.videoUrl,
        partialFile.path,
        cancelToken: cancelToken,
        options: Options(
          followRedirects: true,
          receiveTimeout: const Duration(minutes: 2),
        ),
      );

      if (await file.exists()) {
        await file.delete();
      }
      await partialFile.rename(file.path);
      unawaited(_evictIfNeeded());

      if (kDebugMode) {
        talker.info('Cached video ${video.id}');
      }

      return file;
    } catch (error) {
      if (await partialFile.exists()) {
        await partialFile.delete();
      }
      if (kDebugMode && error is! DioException) {
        talker.warning('Video cache failed for ${video.id}: $error');
      }
      return null;
    }
  }

  Future<File?> _cachedFile(VideoEntity video) async {
    final file = await _fileFor(video.id);
    if (!await file.exists()) return null;
    if (await file.length() == 0) return null;
    return file;
  }

  Future<File> _fileFor(int videoId) async {
    final directory = await _cacheDirectory();
    return File('${directory.path}${Platform.pathSeparator}$videoId.mp4');
  }

  Future<Directory> _cacheDirectory() async {
    final temporaryDirectory = await getTemporaryDirectory();
    return Directory(
      '${temporaryDirectory.path}${Platform.pathSeparator}video-feed-cache',
    );
  }

  Future<void> _evictIfNeeded() async {
    final directory = await _cacheDirectory();
    if (!await directory.exists()) return;

    final files = await directory
        .list()
        .where((entity) => entity is File && entity.path.endsWith('.mp4'))
        .cast<File>()
        .toList();

    var totalBytes = 0;
    final entries = <_CacheEntry>[];
    final cutoff = DateTime.now().subtract(_maxCacheAge);
    for (final file in files) {
      final stat = await file.stat();
      if (stat.modified.isBefore(cutoff)) {
        await file.delete();
        continue;
      }

      totalBytes += stat.size;
      entries.add(
        _CacheEntry(file: file, size: stat.size, touched: stat.modified),
      );
    }

    if (totalBytes <= _maxCacheBytes) return;

    entries.sort((a, b) => a.touched.compareTo(b.touched));
    for (final entry in entries) {
      if (totalBytes <= _maxCacheBytes) break;
      try {
        await entry.file.delete();
        totalBytes -= entry.size;
      } catch (_) {
        // Cache eviction is best effort.
      }
    }
  }
}

class _CacheEntry {
  final File file;
  final int size;
  final DateTime touched;

  const _CacheEntry({
    required this.file,
    required this.size,
    required this.touched,
  });
}

class _PendingVideo {
  final VideoEntity video;
  final int priority;
  final int revision;

  const _PendingVideo({
    required this.video,
    required this.priority,
    required this.revision,
  });
}
