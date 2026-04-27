import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:test_video/features/video_feed/presentation/widgets/tiktok_loading_indicator.dart';
import '../../domain/entities/video_entity.dart';
import 'video_player_manager.dart';

class VideoPlayerItem extends StatelessWidget {
  final int index;
  final ValueListenable<int> activeIndexListenable;
  final VideoEntity video;
  final VideoPlayerManager manager;

  const VideoPlayerItem({
    super.key,
    required this.index,
    required this.activeIndexListenable,
    required this.video,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _VideoSurface(video: video, manager: manager),
          _ActiveVideoControls(
            index: index,
            activeIndexListenable: activeIndexListenable,
            video: video,
            manager: manager,
          ),
          const _BottomGradient(),
          _VideoMetadata(video: video),
        ],
      ),
    );
  }
}

class _VideoSnapshot {
  final VideoController? controller;
  final Player? player;
  final bool isReady;
  final bool isPlaying;
  final bool hasFirstFrameRendered;
  final String? error;
  final bool showPauseOverlay;

  const _VideoSnapshot({
    required this.controller,
    required this.player,
    required this.isReady,
    required this.isPlaying,
    required this.hasFirstFrameRendered,
    required this.error,
    required this.showPauseOverlay,
  });

  factory _VideoSnapshot.from(VideoPlayerManager manager, int videoId) {
    return _VideoSnapshot(
      controller: manager.getController(videoId),
      player: manager.getPlayer(videoId),
      isReady: manager.isReady(videoId),
      isPlaying: manager.isPlaying(videoId),
      hasFirstFrameRendered: manager.hasFirstFrameRendered(videoId),
      error: manager.getError(videoId),
      showPauseOverlay: manager.shouldShowPauseOverlay(videoId),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _VideoSnapshot &&
        other.controller == controller &&
        other.player == player &&
        other.isReady == isReady &&
        other.isPlaying == isPlaying &&
        other.hasFirstFrameRendered == hasFirstFrameRendered &&
        other.error == error &&
        other.showPauseOverlay == showPauseOverlay;
  }

  @override
  int get hashCode => Object.hash(
    controller,
    player,
    isReady,
    isPlaying,
    hasFirstFrameRendered,
    error,
    showPauseOverlay,
  );
}

class _VideoSurface extends StatefulWidget {
  final VideoEntity video;
  final VideoPlayerManager manager;

  const _VideoSurface({required this.video, required this.manager});

  @override
  State<_VideoSurface> createState() => _VideoSurfaceState();
}

class _VideoSurfaceState extends State<_VideoSurface> {
  late _VideoSnapshot _snapshot;
  VideoController? _watchedFirstFrameController;
  static const Duration _firstFrameFallbackDelay = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _snapshot = _VideoSnapshot.from(widget.manager, widget.video.id);
    widget.manager.addListener(_handleManagerChanged);
  }

  @override
  void didUpdateWidget(covariant _VideoSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.manager != widget.manager) {
      oldWidget.manager.removeListener(_handleManagerChanged);
      widget.manager.addListener(_handleManagerChanged);
    }

    if (oldWidget.video.id != widget.video.id ||
        oldWidget.manager != widget.manager) {
      _snapshot = _VideoSnapshot.from(widget.manager, widget.video.id);
    }
  }

  @override
  void dispose() {
    widget.manager.removeListener(_handleManagerChanged);
    super.dispose();
  }

  void _handleManagerChanged() {
    final next = _VideoSnapshot.from(widget.manager, widget.video.id);
    if (next == _snapshot) return;
    setState(() {
      _snapshot = next;
    });
  }

  void _watchFirstFrame(VideoController controller) {
    if (_watchedFirstFrameController == controller) return;
    _watchedFirstFrameController = controller;

    unawaited(
      () async {
        try {
          await controller.waitUntilFirstFrameRendered.timeout(
            _firstFrameFallbackDelay,
          );
        } on TimeoutException {
          // media_kit can miss this signal during rapid attach/detach cycles.
        }

        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        if (_snapshot.controller != controller || !_snapshot.isReady) return;
        widget.manager.markFirstFrameRendered(widget.video.id);
      }().catchError((Object error, StackTrace stackTrace) {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _snapshot.controller;
    final canRenderVideo = controller != null && _snapshot.isReady;
    if (canRenderVideo) {
      _watchFirstFrame(controller);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (canRenderVideo)
          Positioned.fill(
            child: RepaintBoundary(
              child: Video(
                controller: controller,
                fit: BoxFit.cover,
                controls: NoVideoControls,
              ),
            ),
          ),
        // Positioned.fill(
        //   child: IgnorePointer(
        //     child: AnimatedOpacity(
        //       opacity: canShowVideo ? 0 : 1,
        //       duration: const Duration(milliseconds: 800),
        //       curve: Curves.easeOutCubic,
        //       child: Image.network(
        //         widget.video.thumbnailUrl,
        //         fit: BoxFit.cover,
        //         filterQuality: FilterQuality.low,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _ActiveVideoControls extends StatefulWidget {
  final int index;
  final ValueListenable<int> activeIndexListenable;
  final VideoEntity video;
  final VideoPlayerManager manager;

  const _ActiveVideoControls({
    required this.index,
    required this.activeIndexListenable,
    required this.video,
    required this.manager,
  });

  @override
  State<_ActiveVideoControls> createState() => _ActiveVideoControlsState();
}

class _ActiveVideoControlsState extends State<_ActiveVideoControls> {
  late _VideoSnapshot _snapshot;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _snapshot = _VideoSnapshot.from(widget.manager, widget.video.id);
    _isActive = widget.index == widget.activeIndexListenable.value;
    widget.manager.addListener(_handleChanged);
    widget.activeIndexListenable.addListener(_handleChanged);
  }

  @override
  void didUpdateWidget(covariant _ActiveVideoControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.manager != widget.manager) {
      oldWidget.manager.removeListener(_handleChanged);
      widget.manager.addListener(_handleChanged);
    }
    if (oldWidget.activeIndexListenable != widget.activeIndexListenable) {
      oldWidget.activeIndexListenable.removeListener(_handleChanged);
      widget.activeIndexListenable.addListener(_handleChanged);
    }

    if (oldWidget.video.id != widget.video.id ||
        oldWidget.index != widget.index ||
        oldWidget.manager != widget.manager ||
        oldWidget.activeIndexListenable != widget.activeIndexListenable) {
      _snapshot = _VideoSnapshot.from(widget.manager, widget.video.id);
      _isActive = widget.index == widget.activeIndexListenable.value;
    }
  }

  @override
  void dispose() {
    widget.manager.removeListener(_handleChanged);
    widget.activeIndexListenable.removeListener(_handleChanged);
    super.dispose();
  }

  void _handleChanged() {
    final nextSnapshot = _VideoSnapshot.from(widget.manager, widget.video.id);
    final nextIsActive = widget.index == widget.activeIndexListenable.value;
    if (nextSnapshot == _snapshot && nextIsActive == _isActive) return;

    setState(() {
      _snapshot = nextSnapshot;
      _isActive = nextIsActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isActive) return const SizedBox.shrink();

    final player = _snapshot.player;
    final error = _snapshot.error;
    final isReady = _snapshot.isReady;
    final hasFirstFrameRendered = _snapshot.hasFirstFrameRendered;
    final canInteract = isReady && hasFirstFrameRendered && player != null;

    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (canInteract)
            Positioned.fill(
              bottom: 48,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  unawaited(
                    widget.manager
                        .togglePlayPause(widget.video.id)
                        .catchError((Object error, StackTrace stackTrace) {}),
                  );
                },
              ),
            ),
          if (error != null) _VideoErrorMessage(error: error),
          if ((isReady && !hasFirstFrameRendered) && error == null)
            const Center(child: TikTokLoadingIndicator()),
          if (canInteract) ...[
            _PauseIndicator(visible: _snapshot.showPauseOverlay),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _VideoProgressBar(player: player),
            ),
          ],
        ],
      ),
    );
  }
}

class _VideoErrorMessage extends StatelessWidget {
  final String error;

  const _VideoErrorMessage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _BottomGradient extends StatelessWidget {
  const _BottomGradient();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 300,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoMetadata extends StatelessWidget {
  final VideoEntity video;

  const _VideoMetadata({required this.video});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 16,
      right: 80,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@${video.authorName}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              video.title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _PauseIndicator extends StatelessWidget {
  final bool visible;

  const _PauseIndicator({required this.visible});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: const Center(
          child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 72),
        ),
      ),
    );
  }
}

class _VideoProgressBar extends StatelessWidget {
  final Player player;

  const _VideoProgressBar({required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.stream.duration,
      initialData: player.state.duration,
      builder: (context, durationSnapshot) {
        final duration = durationSnapshot.data ?? Duration.zero;

        return StreamBuilder<Duration>(
          stream: player.stream.position,
          initialData: player.state.position,
          builder: (context, positionSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;
            final maxMs = duration.inMilliseconds;

            if (maxMs <= 0) {
              return const _ProgressTrack(progress: 0);
            }

            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
                overlayShape: SliderComponentShape.noOverlay,
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
              ),
              child: Slider(
                min: 0,
                max: maxMs.toDouble(),
                value: position.inMilliseconds.clamp(0, maxMs).toDouble(),
                onChanged: (_) {},
                onChangeEnd: (value) {
                  final target = Duration(milliseconds: value.round());
                  unawaited(
                    player
                        .seek(target)
                        .catchError((Object error, StackTrace stackTrace) {}),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ProgressTrack extends StatelessWidget {
  final double progress;

  const _ProgressTrack({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 2,
        backgroundColor: Colors.white24,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
