import 'package:flutter/material.dart';

class TikTokLoadingIndicator extends StatefulWidget {
  final double size;

  const TikTokLoadingIndicator({super.key, this.size = 34});

  @override
  State<TikTokLoadingIndicator> createState() => _TikTokLoadingIndicatorState();
}

class _TikTokLoadingIndicatorState extends State<TikTokLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 760),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size * 0.46;
    final travel = widget.size * 0.26;
    final paintSize = widget.size + (dotSize * 0.7);

    return Semantics(
      label: 'Loading',
      liveRegion: true,
      child: SizedBox.square(
        dimension: paintSize,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = Curves.easeInOutCubic.transform(_controller.value);
            final leftOffset = -travel + (travel * 2 * value);
            final rightOffset = travel - (travel * 2 * value);
            final scaleA = 0.88 + (0.22 * value);
            final scaleB = 1.1 - (0.22 * value);

            final cyanDot = Transform.translate(
              key: const ValueKey('cyan-loading-dot'),
              offset: Offset(leftOffset, 0),
              child: Transform.scale(
                scale: scaleA,
                child: _LoadingDot(
                  size: dotSize,
                  color: const Color(0xFF25F4EE),
                ),
              ),
            );
            final redDot = Transform.translate(
              key: const ValueKey('red-loading-dot'),
              offset: Offset(rightOffset, 0),
              child: Transform.scale(
                scale: scaleB,
                child: _LoadingDot(
                  size: dotSize,
                  color: const Color(0xFFFF2C55),
                ),
              ),
            );

            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: value < 0.5 ? [cyanDot, redDot] : [redDot, cyanDot],
            );
          },
        ),
      ),
    );
  }
}

class VideoFeedLoadingMoreIndicator extends StatelessWidget {
  const VideoFeedLoadingMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Semantics(
          label: 'Loading more videos',
          liveRegion: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ExcludeSemantics(child: TikTokLoadingIndicator(size: 28)),
              SizedBox(height: 8),
              _LoadingRail(width: 54),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingRail extends StatefulWidget {
  final double width;

  const _LoadingRail({required this.width});

  @override
  State<_LoadingRail> createState() => _LoadingRailState();
}

class _LoadingRailState extends State<_LoadingRail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: widget.width,
        height: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = Curves.easeInOutCubic.transform(_controller.value);
              return CustomPaint(painter: _LoadingRailPainter(progress: value));
            },
          ),
        ),
      ),
    );
  }
}

class _LoadingRailPainter extends CustomPainter {
  final double progress;

  const _LoadingRailPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()..color = Colors.white.withValues(alpha: 0.16);
    final accentPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF25F4EE), Color(0xFFFFFFFF), Color(0xFFFF2C55)],
      ).createShader(Offset.zero & size);

    final radius = Radius.circular(size.height / 2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, radius),
      trackPaint,
    );

    final segmentWidth = size.width * 0.36;
    final x = (size.width + segmentWidth) * progress - segmentWidth;
    final segment = Rect.fromLTWH(x, 0, segmentWidth, size.height);
    canvas.drawRRect(RRect.fromRectAndRadius(segment, radius), accentPaint);
  }

  @override
  bool shouldRepaint(covariant _LoadingRailPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LoadingDot extends StatelessWidget {
  final double size;
  final Color color;

  const _LoadingDot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.38),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
