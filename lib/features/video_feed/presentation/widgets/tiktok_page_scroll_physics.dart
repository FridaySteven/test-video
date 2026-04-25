import 'package:flutter/widgets.dart';

class TikTokPageScrollPhysics extends ScrollPhysics {
  const TikTokPageScrollPhysics({super.parent});

  static const double _minPageFlingVelocity = 35;
  static const double _pageCommitThreshold = 0.16;
  static const SpringDescription _spring = SpringDescription(
    mass: 0.45,
    stiffness: 430,
    damping: 34,
  );

  @override
  TikTokPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TikTokPageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get minFlingDistance => 3;

  @override
  double get minFlingVelocity => _minPageFlingVelocity;

  @override
  double get maxFlingVelocity => 12000;

  @override
  double? get dragStartDistanceMotionThreshold => 2;

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final viewportDimension = position.viewportDimension;
    if (viewportDimension <= 0) {
      return super.createBallisticSimulation(position, velocity);
    }

    final page = position.pixels / viewportDimension;
    final basePage = page.floor();
    final pageDelta = page - basePage;
    final int targetPage;

    if (velocity > _minPageFlingVelocity) {
      targetPage = basePage + 1;
    } else if (velocity < -_minPageFlingVelocity) {
      targetPage = basePage;
    } else if (pageDelta <= _pageCommitThreshold) {
      targetPage = basePage;
    } else if (pageDelta >= 1 - _pageCommitThreshold) {
      targetPage = basePage + 1;
    } else {
      targetPage = page.round();
    }

    final targetPixels = (targetPage * viewportDimension).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    if ((targetPixels - position.pixels).abs() <
        toleranceFor(position).distance) {
      return null;
    }

    return ScrollSpringSimulation(
      _spring,
      position.pixels,
      targetPixels,
      velocity,
      tolerance: toleranceFor(position),
    );
  }
}
