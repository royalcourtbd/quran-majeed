import 'package:flutter/material.dart';

// Animation that shows and hides the scrollbar
class SlideFadeTransition extends StatelessWidget {
  const SlideFadeTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: const Key("SlideFadeTransitionAnimatedBuilder"),
      animation: animation,
      builder: (context, child) =>
          // If the animation value is 0.0, return an empty SizedBox (invisible)
          animation.value == 0.0
              ? const SizedBox.shrink()
              // Otherwise, return the child widget or an empty SizedBox if the
              // child is null
              : (child ?? const SizedBox.shrink()),
      child: SlideTransition(
        key: const Key("SlideFadeTransitionSlideTransition"),
        position: Tween(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}
