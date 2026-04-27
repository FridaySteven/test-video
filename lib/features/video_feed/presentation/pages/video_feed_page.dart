import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/cache/video_cache_service.dart';
import '../bloc/video_feed_bloc.dart';
import '../bloc/video_feed_event.dart';
import '../bloc/video_feed_state.dart';
import '../widgets/tiktok_page_scroll_physics.dart';
import '../widgets/tiktok_loading_indicator.dart';
import '../widgets/video_player_item.dart';
import '../widgets/video_player_manager.dart';
import '../../domain/entities/video_entity.dart';

class VideoFeedPage extends StatefulWidget {
  /// Whether this feed is the currently visible tab/page.
  ///
  /// Video playback is paused when the feed is hidden so audio does not keep
  /// playing behind other screens.
  final bool isActive;

  const VideoFeedPage({super.key, this.isActive = true});

  @override
  State<VideoFeedPage> createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage>
    with WidgetsBindingObserver {
  /// Owns all prepared video players and keeps only one video playing at once.
  late VideoPlayerManager videoPlayerManager;

  /// Drives the vertical TikTok-style page feed.
  late PageController _pageController;

  /// Notifies each video item which page is active without rebuilding the whole
  /// feed on every page change.
  late ValueNotifier<int> _activeIndexNotifier;

  /// Prevents rapid scroll updates from preparing/playing several videos at
  /// nearly the same time.
  late final Debouncer _videoSyncDebouncer;

  /// Delays player cleanup so quick back-and-forth scrolling can reuse players.
  late final Debouncer _disposeDebouncer;

  /// Latest play request captured while the user is still dragging the feed.
  _VideoSyncRequest? _pendingVideoSync;

  /// Latest preload request captured while the user is still dragging the feed.
  _PreloadWindowRequest? _pendingPreloadWindow;

  /// Monotonic token used to cancel stale async prepare/play work.
  int _videoWindowRequest = 0;

  /// Forces the first loaded video, and refreshed replacement feeds, to start.
  bool _hasStartedInitialVideo = false;

  /// True while the page view is being actively scrolled.
  bool _isPageScrolling = false;

  /// Number of previous videos to keep prepared around the current item.
  static const int _preloadBefore = 0;

  /// Number of upcoming videos to prepare as real media players.
  static const int _preloadAfter = 2;

  /// Number of additional upcoming videos to download/cache without preparing.
  static const int _cacheAhead = 5;

  /// Hard cap for prepared players retained in memory.
  static const int _maxPreparedPlayers = 2;

  /// Default delay before syncing the active page to the video player.
  static const Duration _videoSyncDebounce = Duration(milliseconds: 150);

  /// Shorter sync delay after PageView reports a settled page.
  static const Duration _pageChangeSyncDebounce = Duration(milliseconds: 80);

  /// Gap between preparing neighbor videos to avoid frame drops while scrolling.
  static const Duration _preloadPrepareGap = Duration(milliseconds: 120);

  /// Delay before disposing players outside the active preload window.
  static const Duration _disposeDebounce = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    videoPlayerManager = VideoPlayerManager(
      videoCacheService: sl<VideoCacheService>(),
    );
    _pageController = PageController();
    _activeIndexNotifier = ValueNotifier<int>(0);
    _videoSyncDebouncer = Debouncer(delay: _videoSyncDebounce);
    _disposeDebouncer = Debouncer(delay: _disposeDebounce);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoSyncDebouncer.dispose();
    _disposeDebouncer.dispose();
    _activeIndexNotifier.dispose();
    _pageController.dispose();
    videoPlayerManager.cancelAllCachedVideoDownloads();
    videoPlayerManager.disposeAll();
    videoPlayerManager.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoFeedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive == widget.isActive) return;

    if (widget.isActive) {
      _resumeCurrentVideo();
    } else {
      _pauseCurrentVideo();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      final videoId = _currentVideoId();
      if (videoId != null) {
        _ignoreVideoWork(videoPlayerManager.pause(videoId));
      }
    } else if (state == AppLifecycleState.resumed) {
      if (widget.isActive) _resumeCurrentVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<VideoFeedBloc, VideoFeedState>(
        listenWhen: (previous, current) =>
            current.videos.isNotEmpty && previous.videos != current.videos,
        listener: (context, state) {
          _activeIndexNotifier.value = state.currentIndex;
          final isReplacementFeed = state.page == 1 && state.currentIndex == 0;

          final forcePlay = !_hasStartedInitialVideo || isReplacementFeed;
          _hasStartedInitialVideo = true;
          if (forcePlay) {
            _requestVideoSyncAfterLayout(
              state.currentIndex,
              state.videos,
              forcePlay: true,
              resetToFirstPage: isReplacementFeed,
            );
          } else {
            _requestPreloadWindowForIndex(state.currentIndex, state.videos);
          }
        },
        buildWhen: (previous, current) =>
            previous.videos != current.videos ||
            previous.isInitialLoading != current.isInitialLoading ||
            (previous.videos.isEmpty &&
                current.videos.isEmpty &&
                previous.errorMessage != current.errorMessage),
        builder: (context, state) {
          if (state.isInitialLoading) {
            return const Center(child: TikTokLoadingIndicator(size: 42));
          }

          if (state.errorMessage != null && state.videos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VideoFeedBloc>().add(
                        const VideoFeedEvent.started(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.videos.isEmpty) {
            return const Center(
              child: Text(
                'No videos found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: _handlePageScrollNotification,
            child: PageView.builder(
              controller: _pageController,
              physics: const TikTokPageScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              scrollDirection: Axis.vertical,
              itemCount: state.videos.length,
              onPageChanged: (index) {
                _activeIndexNotifier.value = index;
                context.read<VideoFeedBloc>().add(
                  VideoFeedEvent.pageChanged(index: index),
                );
                _requestVideoSync(
                  index,
                  state.videos,
                  forcePlay: true,
                  delay: _pageChangeSyncDebounce,
                );
              },
              itemBuilder: (context, index) {
                final isLastVideo = index == state.videos.length - 1;
                final item = VideoPlayerItem(
                  key: ValueKey(state.videos[index].id),
                  index: index,
                  activeIndexListenable: _activeIndexNotifier,
                  video: state.videos[index],
                  manager: videoPlayerManager,
                );

                if (!isLastVideo) return item;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    item,
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 78,
                      child: RepaintBoundary(
                        child: _LastVideoLoadMoreIndicator(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  bool _handlePageScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is ScrollStartNotification) {
      _isPageScrolling = true;
      _videoSyncDebouncer.cancel();
      _disposeDebouncer.cancel();
      _videoWindowRequest++;
      _pendingVideoSync = null;
      _pendingPreloadWindow = null;
    } else if (notification is ScrollEndNotification) {
      _isPageScrolling = false;
      _flushPendingMediaWork();
    }

    return false;
  }

  /// Starts playback after the page view has been laid out. This keeps initial
  /// release startup from racing media preparation against the first video view.
  void _requestVideoSyncAfterLayout(
    int index,
    List<VideoEntity> videos, {
    required bool forcePlay,
    required bool resetToFirstPage,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || videos.isEmpty) return;

      var targetIndex = index;
      if (resetToFirstPage && _pageController.hasClients) {
        final currentPage = _pageController.page ?? 0;
        if (currentPage.round() != 0) {
          _pageController.jumpToPage(0);
        }
        targetIndex = 0;
      }

      if (targetIndex < 0 || targetIndex >= videos.length) return;
      if (_activeIndexNotifier.value != targetIndex) {
        _activeIndexNotifier.value = targetIndex;
      }

      _requestVideoSync(
        targetIndex,
        videos,
        forcePlay: forcePlay,
        delay: Duration.zero,
      );
    });
  }

  /// Runs the most recent deferred media action once the page settles.
  void _flushPendingMediaWork() {
    final pendingSync = _pendingVideoSync;
    _pendingVideoSync = null;
    final pendingPreload = _pendingPreloadWindow;
    _pendingPreloadWindow = null;

    if (pendingSync != null) {
      _scheduleVideoSync(
        pendingSync.index,
        pendingSync.videos,
        forcePlay: pendingSync.forcePlay,
        delay: pendingSync.delay,
      );
      return;
    }

    if (_scheduleSettledVideoSync()) return;

    if (pendingPreload != null) {
      _preloadWindowForIndex(pendingPreload.index, pendingPreload.videos);
    }
  }

  /// Ensures a drag/fling that settles without a new onPageChanged event still
  /// leaves the visible page prepared and playing.
  bool _scheduleSettledVideoSync() {
    if (!mounted) return false;

    final bloc = context.read<VideoFeedBloc>();
    final state = bloc.state;
    if (state.videos.isEmpty) return false;

    final index = _settledPageIndex(state);
    if (index == null) return false;

    if (_activeIndexNotifier.value != index) {
      _activeIndexNotifier.value = index;
    }
    if (state.currentIndex != index) {
      bloc.add(VideoFeedEvent.pageChanged(index: index));
    }

    final currentVideoId = state.videos[index].id;
    final shouldForcePlay = !videoPlayerManager.shouldShowPauseOverlay(
      currentVideoId,
    );

    _scheduleVideoSync(
      index,
      state.videos,
      forcePlay: shouldForcePlay,
      delay: Duration.zero,
    );
    return true;
  }

  int? _settledPageIndex(VideoFeedState state) {
    if (_pageController.hasClients) {
      final page = _pageController.page;
      if (page != null) {
        final index = page.round();
        if (index >= 0 && index < state.videos.length) return index;
      }
    }

    final currentIndex = state.currentIndex;
    if (currentIndex < 0 || currentIndex >= state.videos.length) return null;
    return currentIndex;
  }

  /// Requests active-video preparation/playback, deferring it while dragging.
  void _requestVideoSync(
    int index,
    List<VideoEntity> videos, {
    bool forcePlay = false,
    Duration delay = _videoSyncDebounce,
  }) {
    if (_isPageScrolling) {
      _pendingVideoSync = _VideoSyncRequest(
        index: index,
        videos: videos,
        forcePlay: forcePlay,
        delay: delay,
      );
      return;
    }

    _scheduleVideoSync(index, videos, forcePlay: forcePlay, delay: delay);
  }

  /// Requests neighbor preloading, deferring it while dragging.
  void _requestPreloadWindowForIndex(int index, List<VideoEntity> videos) {
    if (_isPageScrolling) {
      _pendingPreloadWindow = _PreloadWindowRequest(
        index: index,
        videos: videos,
      );
      return;
    }

    _preloadWindowForIndex(index, videos);
  }

  /// Debounces playback sync and tags it so older async work can be ignored.
  void _scheduleVideoSync(
    int index,
    List<VideoEntity> videos, {
    bool forcePlay = false,
    Duration delay = _videoSyncDebounce,
  }) {
    final requestId = ++_videoWindowRequest;
    _videoSyncDebouncer.run(() {
      if (!mounted || requestId != _videoWindowRequest) return;

      unawaited(
        _syncCurrentVideo(requestId, index, videos, forcePlay: forcePlay),
      );
    }, delay: delay);
  }

  /// Prepares the current video, starts it if this feed is active, then preloads
  /// nearby videos for the next scroll.
  Future<void> _syncCurrentVideo(
    int requestId,
    int index,
    List<VideoEntity> videos, {
    bool forcePlay = false,
  }) async {
    if (index < 0 || index >= videos.length) return;
    if (!mounted || requestId != _videoWindowRequest) return;

    final current = videos[index];
    final currentPrepare = videoPlayerManager.prepare(current);

    try {
      await currentPrepare;
    } catch (_) {
      return;
    }

    if (!mounted || requestId != _videoWindowRequest) return;
    if (!widget.isActive) return;

    try {
      await videoPlayerManager.playOnly(current.id, force: forcePlay);
    } catch (_) {
      return;
    }

    if (!mounted || requestId != _videoWindowRequest) return;

    _preloadNeighbors(index, videos, current.id, requestId: requestId);
  }

  /// Prepares nearby videos, caches farther videos, and schedules cleanup for
  /// players outside the active window.
  void _preloadNeighbors(
    int index,
    List<VideoEntity> videos,
    int currentId, {
    required int requestId,
  }) {
    final preloadVideos = <VideoEntity>[
      for (var i = index - _preloadBefore; i <= index + _preloadAfter; i++)
        if (i >= 0 && i < videos.length && i != index) videos[i],
    ];

    _ignoreVideoWork(_preparePreloadVideos(preloadVideos, requestId));

    final cacheVideos = <VideoEntity>[
      for (
        var i = index + _preloadAfter + 1;
        i <= index + _preloadAfter + _cacheAhead;
        i++
      )
        if (i >= 0 && i < videos.length) videos[i],
    ];
    final keepIds = {currentId, for (final video in preloadVideos) video.id};
    final cacheKeepIds = {
      ...keepIds,
      for (final video in cacheVideos) video.id,
    };

    videoPlayerManager.cancelCachedVideoDownloadsExcept(cacheKeepIds);
    videoPlayerManager.cacheVideos(
      cacheVideos,
      priorityIds: cacheVideos.map((video) => video.id),
    );

    final priorityIds = _priorityVideoIds(index, videos);
    _scheduleDispose(keepIds, priorityIds);
  }

  /// Rebuilds the preload window without forcing playback.
  void _preloadWindowForIndex(int index, List<VideoEntity> videos) {
    if (index < 0 || index >= videos.length) return;
    _preloadNeighbors(
      index,
      videos,
      videos[index].id,
      requestId: _videoWindowRequest,
    );
  }

  /// Prepares preload videos one at a time so scrolling stays responsive.
  Future<void> _preparePreloadVideos(
    List<VideoEntity> videos,
    int requestId,
  ) async {
    for (final video in videos) {
      if (_isPageScrolling) return;
      await Future<void>.delayed(_preloadPrepareGap);
      if (!mounted || _isPageScrolling || requestId != _videoWindowRequest) {
        return;
      }

      try {
        await videoPlayerManager.prepare(video);
      } catch (_) {
        return;
      }
    }
  }

  /// Orders retained players by usefulness when the manager needs trimming.
  List<int> _priorityVideoIds(int index, List<VideoEntity> videos) {
    final priorities = <int>[];
    for (final offset in [0, 1, -1, 2, -2]) {
      final priorityIndex = index + offset;
      if (priorityIndex >= 0 && priorityIndex < videos.length) {
        priorities.add(videos[priorityIndex].id);
      }
    }
    return priorities;
  }

  /// Removes prepared players outside the keep set after scrolling calms down.
  void _scheduleDispose(Set<int> keepIds, List<int> priorityIds) {
    _disposeDebouncer.run(() {
      _ignoreVideoWork(
        videoPlayerManager.retainOnly(
          keepIds: keepIds,
          priorityIds: priorityIds,
          maxPlayers: _maxPreparedPlayers,
        ),
      );
    });
  }

  /// Pauses only the currently visible video.
  void _pauseCurrentVideo() {
    final videoId = _currentVideoId();
    if (videoId != null) {
      _ignoreVideoWork(videoPlayerManager.pause(videoId));
    }
  }

  /// Resumes the visible video when the feed or app becomes active again.
  void _resumeCurrentVideo({bool force = false}) {
    if (!mounted) return;

    final videoId = _currentVideoId();
    if (videoId != null) {
      _ignoreVideoWork(videoPlayerManager.playOnly(videoId, force: force));
    }
  }

  /// Safely resolves the current video id from bloc state.
  int? _currentVideoId() {
    if (!mounted) return null;

    final state = context.read<VideoFeedBloc>().state;
    final currentIndex = state.currentIndex;
    final videos = state.videos;
    if (currentIndex < 0 || currentIndex >= videos.length) return null;

    return videos[currentIndex].id;
  }

  /// Fire-and-forget wrapper for media futures that should not fail the UI.
  void _ignoreVideoWork(Future<void> future) {
    unawaited(future.catchError((Object error, StackTrace stackTrace) {}));
  }
}

class _LastVideoLoadMoreIndicator extends StatelessWidget {
  const _LastVideoLoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VideoFeedBloc, VideoFeedState, bool>(
      selector: (state) =>
          state.isLoadingMore &&
          !state.hasReachedEnd &&
          state.currentIndex == state.videos.length - 1,
      builder: (context, isLoadingMore) {
        if (!isLoadingMore) return const SizedBox.shrink();

        return const VideoFeedLoadingMoreIndicator();
      },
    );
  }
}

class _VideoSyncRequest {
  final int index;
  final List<VideoEntity> videos;
  final bool forcePlay;
  final Duration delay;

  const _VideoSyncRequest({
    required this.index,
    required this.videos,
    required this.forcePlay,
    required this.delay,
  });
}

class _PreloadWindowRequest {
  final int index;
  final List<VideoEntity> videos;

  const _PreloadWindowRequest({required this.index, required this.videos});
}
