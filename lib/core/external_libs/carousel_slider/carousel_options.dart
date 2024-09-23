import 'package:flutter/material.dart';

enum CarouselPageChangedReason { timed, manual, controller }

enum CenterPageEnlargeStrategy { scale, height, zoom }

class CarouselOptions {
  CarouselOptions({
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.animateToClosest = true,
    this.reverse = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.onScrolled,
    this.scrollPhysics,
    this.pageSnapping = true,
    this.scrollDirection = Axis.horizontal,
    this.pauseAutoPlayOnTouch = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.enlargeStrategy = CenterPageEnlargeStrategy.scale,
    this.enlargeFactor = 0.3,
    this.disableCenter = false,
    this.padEnds = true,
    this.clipBehavior = Clip.hardEdge,
  });

  final double? height;

  final double aspectRatio;

  final double viewportFraction;

  final int initialPage;

  final bool enableInfiniteScroll;

  final bool animateToClosest;

  final bool reverse;

  final bool autoPlay;

  final Duration autoPlayInterval;

  final Duration autoPlayAnimationDuration;

  final Curve autoPlayCurve;

  final bool? enlargeCenterPage;

  final Axis scrollDirection;

  final void Function(int index, CarouselPageChangedReason reason)?
      onPageChanged;

  final ValueChanged<double?>? onScrolled;

  final ScrollPhysics? scrollPhysics;

  final bool pageSnapping;

  final bool pauseAutoPlayOnTouch;

  final bool pauseAutoPlayOnManualNavigate;

  final bool pauseAutoPlayInFiniteScroll;

  final CenterPageEnlargeStrategy enlargeStrategy;

  final double enlargeFactor;

  final bool disableCenter;

  final bool padEnds;

  final Clip clipBehavior;

  CarouselOptions copyWith({
    double? height,
    double? aspectRatio,
    double? viewportFraction,
    int? initialPage,
    bool? enableInfiniteScroll,
    bool? reverse,
    bool? autoPlay,
    Duration? autoPlayInterval,
    Duration? autoPlayAnimationDuration,
    Curve? autoPlayCurve,
    bool? enlargeCenterPage,
    void Function(int index, CarouselPageChangedReason reason)? onPageChanged,
    ValueChanged<double?>? onScrolled,
    ScrollPhysics? scrollPhysics,
    bool? pageSnapping,
    Axis? scrollDirection,
    bool? pauseAutoPlayOnTouch,
    bool? pauseAutoPlayOnManualNavigate,
    bool? pauseAutoPlayInFiniteScroll,
    CenterPageEnlargeStrategy? enlargeStrategy,
    double? enlargeFactor,
    bool? disableCenter,
    Clip? clipBehavior,
    bool? padEnds,
  }) =>
      CarouselOptions(
        height: height ?? this.height,
        aspectRatio: aspectRatio ?? this.aspectRatio,
        viewportFraction: viewportFraction ?? this.viewportFraction,
        initialPage: initialPage ?? this.initialPage,
        enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
        reverse: reverse ?? this.reverse,
        autoPlay: autoPlay ?? this.autoPlay,
        autoPlayInterval: autoPlayInterval ?? this.autoPlayInterval,
        autoPlayAnimationDuration:
            autoPlayAnimationDuration ?? this.autoPlayAnimationDuration,
        autoPlayCurve: autoPlayCurve ?? this.autoPlayCurve,
        enlargeCenterPage: enlargeCenterPage ?? this.enlargeCenterPage,
        onPageChanged: onPageChanged ?? this.onPageChanged,
        onScrolled: onScrolled ?? this.onScrolled,
        scrollPhysics: scrollPhysics ?? this.scrollPhysics,
        pageSnapping: pageSnapping ?? this.pageSnapping,
        scrollDirection: scrollDirection ?? this.scrollDirection,
        pauseAutoPlayOnTouch: pauseAutoPlayOnTouch ?? this.pauseAutoPlayOnTouch,
        pauseAutoPlayOnManualNavigate:
            pauseAutoPlayOnManualNavigate ?? this.pauseAutoPlayOnManualNavigate,
        pauseAutoPlayInFiniteScroll:
            pauseAutoPlayInFiniteScroll ?? this.pauseAutoPlayInFiniteScroll,
        enlargeStrategy: enlargeStrategy ?? this.enlargeStrategy,
        enlargeFactor: enlargeFactor ?? this.enlargeFactor,
        disableCenter: disableCenter ?? this.disableCenter,
        clipBehavior: clipBehavior ?? this.clipBehavior,
        padEnds: padEnds ?? this.padEnds,
      );
}
