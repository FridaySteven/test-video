import 'package:flutter/widgets.dart';

class TikTokPageScrollPhysics extends PageScrollPhysics {
  const TikTokPageScrollPhysics({super.parent});

  static const double _minPageFlingVelocity = 35;
  static const double _pageCommitThreshold = 0.08;
  static const SpringDescription _spring = SpringDescription(
    mass: 0.2,
    stiffness: 1000,
    damping: 40,
  );

  @override
  TikTokPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TikTokPageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get minFlingDistance => 2;

  @override
  double get minFlingVelocity => _minPageFlingVelocity;

  @override
  double get maxFlingVelocity => 20000;

  @override
  double? get dragStartDistanceMotionThreshold => 1;

  @override
  SpringDescription get spring => _spring;

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

    final currentPage = position.pixels / viewportDimension;
    final basePage = currentPage.floor();
    final pageDelta = currentPage - basePage;

    final int targetPage;
    if (velocity > _minPageFlingVelocity) {
      targetPage = basePage + 1;
    } else if (velocity < -_minPageFlingVelocity) {
      targetPage = basePage;
    } else if (pageDelta >= _pageCommitThreshold) {
      targetPage = basePage + 1;
    } else {
      targetPage = basePage;
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
      spring,
      position.pixels,
      targetPixels,
      velocity,
      tolerance: toleranceFor(position),
    );
  }
}
