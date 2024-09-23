import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/carousel_slider/carousel_options.dart';

class CarouselState {
  CarouselState(
    this.options,
    this.onResetTimer,
    this.onResumeTimer,
    this.changeMode,
  );

  CarouselOptions options;

  PageController? pageController;

  int realPage = 10000;

  int initialPage = 0;

  int? itemCount;

  VoidCallback onResetTimer;

  VoidCallback onResumeTimer;

  void Function(CarouselPageChangedReason) changeMode;
}
