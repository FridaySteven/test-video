import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../../../core/cache/video_cache_service.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/video_entity.dart';

class VideoPlayerManager extends ChangeNotifier {
  VideoPlayerManager({required VideoCacheService videoCacheService})
    : _videoCacheService = videoCacheService;

  final VideoCacheService _videoCacheService;
  final Map<int, Player> _players = {};
  final Map<int, VideoController> _controllers = {};
  final Map<int, Future<void>> _preparing = {};
  final Map<int, String> _errors = {};
  final Set<int> _readyVideoIds = {};
  final Set<int> _firstFrameRenderedVideoIds = {};
  final Set<int> _disposingVideoIds = {};
  int? _activeVideoId;
  bool _isUserPaused = false;
  bool _isDisposed = false;
  int _playRequestId = 0;
  static const bool _logVideoLifecycle = false;

  Player? getPlayer(int videoId) => _players[videoId];

  VideoController? getController(int videoId) => _controllers[videoId];

  bool isReady(int videoId) => _readyVideoIds.contains(videoId);

  bool isPlaying(int videoId) => _players[videoId]?.state.playing ?? false;

  bool hasFirstFrameRendered(int videoId) {
    return _firstFrameRenderedVideoIds.contains(videoId);
  }

  String? getError(int videoId) => _errors[videoId];

  int get playerCount => _players.length;

  int get readyCount => _readyVideoIds.length;

  bool get isUserPaused => _isUserPaused;

  bool shouldShowPauseOverlay(int videoId) {
    return _activeVideoId == videoId && _isUserPaused;
  }

  void cacheVideos(
    Iterable<VideoEntity> videos, {
    Iterable<int> priorityIds = const [],
  }) {
    _videoCacheService.prefetchWindow(videos, priorityIds: priorityIds);
  }

  void cancelCachedVideoDownloadsExcept(Set<int> keepIds) {
    _videoCacheService.cancelExcept(keepIds);
  }

  void cancelAllCachedVideoDownloads() {
    _videoCacheService.cancelAll();
  }

  Future<void> prepare(VideoEntity video) async {
    final preparing = _preparing[video.id];
    if (preparing != null) {
      await preparing;
      return;
    }

    if (_players.containsKey(video.id)) return;

    final player = Player();
    final controller = VideoController(player);

    _players[video.id] = player;
    _controllers[video.id] = controller;
    _errors.remove(video.id);
    _firstFrameRenderedVideoIds.remove(video.id);

    final prepareFuture = _preparePlayer(video, player);
    _preparing[video.id] = prepareFuture;

    try {
      await prepareFuture;
      if (_disposingVideoIds.contains(video.id)) return;
      if (_players[video.id] != player) return;
      _readyVideoIds.add(video.id);
      _emitChanged();
    } catch (_) {
      if (_players[video.id] == player) {
        _players.remove(video.id);
        _controllers.remove(video.id);
      }
      _readyVideoIds.remove(video.id);
      _firstFrameRenderedVideoIds.remove(video.id);
      _errors[video.id] = 'Video failed to load';
      await player.dispose();
      _emitChanged();
      rethrow;
    } finally {
      _preparing.remove(video.id);
    }
  }

  Future<void> _preparePlayer(VideoEntity video, Player player) async {
    final stopwatch = Stopwatch()..start();
    final source = await _videoCacheService.sourceFor(video);
    await player.open(Media(source), play: false);
    await player.setVolume(100.0);
    await player.setPlaylistMode(PlaylistMode.loop);
    stopwatch.stop();
    if (kDebugMode && _logVideoLifecycle) {
      talker.info(
        'Prepared video ${video.id} in ${stopwatch.elapsedMilliseconds}ms '
        '(${video.width}x${video.height}, ${video.duration}s)',
      );
    }
  }

  Future<void> play(int videoId) async {
    _playRequestId++;
    final player = _players[videoId];
    if (player == null) return;

    _activeVideoId = videoId;
    _isUserPaused = false;
    await player.play();
    if (kDebugMode && _logVideoLifecycle) talker.info('Playing video $videoId');
    _emitChanged();
  }

  void markFirstFrameRendered(int videoId) {
    if (_firstFrameRenderedVideoIds.add(videoId)) {
      _emitChanged();
    }
  }

  Future<void> playOnly(int videoId, {bool force = false}) async {
    final requestId = ++_playRequestId;
    _activeVideoId = videoId;

    final entries = List.of(_players.entries);
    for (final entry in entries) {
      if (entry.key == videoId) continue;
      if (_players[entry.key] != entry.value) continue;
      await entry.value.pause();
    }

    if (requestId != _playRequestId) return;

    if (_isUserPaused && !force) {
      await _players[videoId]?.pause();
      _emitChanged();
      return;
    }

    final player = _players[videoId];
    if (player == null) return;

    _activeVideoId = videoId;
    _isUserPaused = false;
    await player.play();
    if (kDebugMode && _logVideoLifecycle) {
      talker.info('Playing only video $videoId');
    }
    _emitChanged();
  }

  Future<void> pause(int videoId) async {
    _playRequestId++;
    final player = _players[videoId];
    if (player == null) return;

    if (_activeVideoId == videoId) {
      _activeVideoId = null;
    }
    await player.pause();
    _emitChanged();
  }

  Future<void> pauseActive() async {
    final activeVideoId = _activeVideoId;
    if (activeVideoId == null) return;

    _isUserPaused = true;
    await pause(activeVideoId);
  }

  Future<void> togglePlayPause(int videoId) async {
    _playRequestId++;
    final player = _players[videoId];
    if (player == null) return;

    if (player.state.playing) {
      _activeVideoId = videoId;
      _isUserPaused = true;
      await player.pause();
    } else {
      _isUserPaused = false;
      _activeVideoId = videoId;
      final entries = List.of(_players.entries);
      for (final entry in entries) {
        if (entry.key == videoId) continue;
        if (_players[entry.key] != entry.value) continue;
        await entry.value.pause();
      }
      await player.play();
    }

    _emitChanged();
  }

  Future<void> disposeVideo(int videoId) async {
    final preparing = _preparing[videoId];
    if (preparing != null) {
      _disposingVideoIds.add(videoId);
      await preparing.catchError((Object error, StackTrace stackTrace) {});
    }

    final player = _players.remove(videoId);
    _controllers.remove(videoId);
    _readyVideoIds.remove(videoId);
    _firstFrameRenderedVideoIds.remove(videoId);
    _errors.remove(videoId);
    if (_activeVideoId == videoId) {
      _activeVideoId = null;
    }

    await player?.dispose();
    _disposingVideoIds.remove(videoId);
    _emitChanged();
  }

  Future<void> disposeExcept(Set<int> keepIds) async {
    final idsToDispose = _players.keys
        .where((id) => !keepIds.contains(id))
        .toList();

    for (final id in idsToDispose) {
      await disposeVideo(id);
    }
  }

  Future<void> retainOnly({
    required Set<int> keepIds,
    required List<int> priorityIds,
    required int maxPlayers,
  }) async {
    await disposeExcept(keepIds);
    await trimToMax(
      keepIds: keepIds,
      priorityIds: priorityIds,
      maxPlayers: maxPlayers,
    );
  }

  Future<void> trimToMax({
    required Set<int> keepIds,
    required List<int> priorityIds,
    required int maxPlayers,
  }) async {
    if (_players.length <= maxPlayers) return;

    final priority = <int, int>{
      for (var i = 0; i < priorityIds.length; i++) priorityIds[i]: i,
    };
    final overflowIds =
        _players.keys.where((id) => !keepIds.contains(id)).toList()
          ..sort((a, b) {
            final aPriority = priority[a] ?? 1 << 20;
            final bPriority = priority[b] ?? 1 << 20;
            return bPriority.compareTo(aPriority);
          });

    for (final id in overflowIds) {
      if (_players.length <= maxPlayers) break;
      await disposeVideo(id);
    }
  }

  Future<void> disposeAll() async {
    _disposingVideoIds.addAll(_players.keys);
    await Future.wait(
      _preparing.values.map(
        (future) => future.catchError((Object error, StackTrace stackTrace) {}),
      ),
    );

    for (final player in _players.values) {
      await player.dispose();
    }

    _players.clear();
    _controllers.clear();
    _readyVideoIds.clear();
    _firstFrameRenderedVideoIds.clear();
    _disposingVideoIds.clear();
    _preparing.clear();
    _activeVideoId = null;
    _isUserPaused = false;
    _emitChanged();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _emitChanged() {
    if (_isDisposed) return;
    notifyListeners();
  }
}
