import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../bloc/video_feed_bloc.dart';
import '../bloc/video_feed_event.dart';
import '../bloc/video_feed_state.dart';
import '../widgets/tiktok_page_scroll_physics.dart';
import '../widgets/video_player_item.dart';
import '../widgets/video_player_manager.dart';
import '../../domain/entities/video_entity.dart';

class VideoFeedPage extends StatefulWidget {
  final bool isActive;

  const VideoFeedPage({super.key, this.isActive = true});

  @override
  State<VideoFeedPage> createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage>
    with WidgetsBindingObserver {
  late VideoPlayerManager videoPlayerManager;
  late PageController _pageController;
  late ValueNotifier<int> _activeIndexNotifier;
  Timer? _syncTimer;
  Timer? _disposeTimer;
  int _videoWindowRequest = 0;
  bool _hasStartedInitialVideo = false;
  static const int _preloadBefore = 1;
  static const int _preloadAfter = 3;

  @override
  void initState() {
    super.initState();
    videoPlayerManager = VideoPlayerManager();
    _pageController = PageController();
    _activeIndexNotifier = ValueNotifier<int>(0);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _syncTimer?.cancel();
    _disposeTimer?.cancel();
    _activeIndexNotifier.dispose();
    _pageController.dispose();
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
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      final currentIndex = context.read<VideoFeedBloc>().state.currentIndex;
      final videos = context.read<VideoFeedBloc>().state.videos;
      if (videos.isNotEmpty && currentIndex < videos.length) {
        _ignoreVideoWork(videoPlayerManager.pause(videos[currentIndex].id));
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
          if (isReplacementFeed && _pageController.hasClients) {
            _pageController.jumpToPage(0);
          }

          final forcePlay = !_hasStartedInitialVideo || isReplacementFeed;
          _hasStartedInitialVideo = true;
          if (forcePlay) {
            _scheduleVideoSync(
              state.currentIndex,
              state.videos,
              forcePlay: true,
            );
          } else {
            _preloadWindowForIndex(state.currentIndex, state.videos);
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
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
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

          return PageView.builder(
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
              _scheduleVideoSync(index, state.videos, forcePlay: true);
            },
            itemBuilder: (context, index) {
              return VideoPlayerItem(
                key: ValueKey(state.videos[index].id),
                index: index,
                activeIndexListenable: _activeIndexNotifier,
                video: state.videos[index],
                manager: videoPlayerManager,
              );
            },
          );
        },
      ),
    );
  }

  void _scheduleVideoSync(
    int index,
    List<VideoEntity> videos, {
    bool forcePlay = false,
  }) {
    _syncTimer?.cancel();

    _syncTimer = Timer(const Duration(milliseconds: 80), () {
      unawaited(_syncCurrentVideo(index, videos, forcePlay: forcePlay));
    });
  }

  Future<void> _syncCurrentVideo(
    int index,
    List<VideoEntity> videos, {
    bool forcePlay = false,
  }) async {
    if (index < 0 || index >= videos.length) return;

    final requestId = ++_videoWindowRequest;
    final current = videos[index];
    final currentPrepare = videoPlayerManager.prepare(current);

    _preloadNeighbors(index, videos, current.id);

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
  }

  void _preloadNeighbors(int index, List<VideoEntity> videos, int currentId) {
    final preloadVideos = <VideoEntity>[
      for (var i = index - _preloadBefore; i <= index + _preloadAfter; i++)
        if (i >= 0 && i < videos.length && i != index) videos[i],
    ];

    for (final video in preloadVideos) {
      _ignoreVideoWork(videoPlayerManager.prepare(video));
    }

    final keepIds = {currentId, for (final video in preloadVideos) video.id};

    _scheduleDispose(keepIds);
  }

  void _preloadWindowForIndex(int index, List<VideoEntity> videos) {
    if (index < 0 || index >= videos.length) return;
    _preloadNeighbors(index, videos, videos[index].id);
  }

  void _scheduleDispose(Set<int> keepIds) {
    _disposeTimer?.cancel();
    _disposeTimer = Timer(const Duration(seconds: 20), () {
      _ignoreVideoWork(videoPlayerManager.disposeExcept(keepIds));
    });
  }

  void _pauseCurrentVideo() {
    final state = context.read<VideoFeedBloc>().state;
    final currentIndex = state.currentIndex;
    final videos = state.videos;
    if (videos.isNotEmpty && currentIndex < videos.length) {
      _ignoreVideoWork(videoPlayerManager.pause(videos[currentIndex].id));
    }
  }

  void _resumeCurrentVideo({bool force = false}) {
    final state = context.read<VideoFeedBloc>().state;
    final currentIndex = state.currentIndex;
    final videos = state.videos;
    if (videos.isNotEmpty && currentIndex < videos.length) {
      _ignoreVideoWork(
        videoPlayerManager.playOnly(videos[currentIndex].id, force: force),
      );
    }
  }

  void _ignoreVideoWork(Future<void> future) {
    unawaited(future.catchError((Object error, StackTrace stackTrace) {}));
  }
}
