import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/carousel_slider/carousel_options.dart';
import 'package:quran_majeed/core/external_libs/carousel_slider/carousel_state.dart';
import 'package:quran_majeed/core/external_libs/carousel_slider/utils.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';

abstract class CarouselControllerHelper {
  factory CarouselControllerHelper() => CarouselControllerImpl();

  bool get ready;

  Future<void> get onReady;

  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  void jumpToPage(int page);

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  void startAutoPlay();

  void stopAutoPlay();
}

class CarouselControllerImpl implements CarouselControllerHelper {
  late final Completer<void> _readyCompleter = Completer<void>();

  CarouselState? _state;

  set state(CarouselState? state) {
    _state = state;
    if (_readyCompleter.isCompleted) return;
    _readyCompleter.complete();
  }

  void _setModeController() =>
      _state?.changeMode(CarouselPageChangedReason.controller);

  @override
  bool get ready => _state != null;

  @override
  Future<void> get onReady => _readyCompleter.future;

  @override
  Future<void> nextPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    final bool? isNeedResetTimer =
        _state?.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer ?? false) _state?.onResetTimer();

    _setModeController();
    await _state?.pageController?.nextPage(
      duration: duration ?? 300.inMilliseconds,
      curve: curve ?? Curves.linear,
    );
    if (isNeedResetTimer ?? false) _state?.onResumeTimer();
  }

  @override
  Future<void> previousPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    final bool isNeedResetTimer =
        _state?.options.pauseAutoPlayOnManualNavigate ?? false;
    if (isNeedResetTimer) _state?.onResetTimer();

    _setModeController();
    await _state?.pageController?.previousPage(
      duration: duration ?? 300.inMilliseconds,
      curve: curve ?? Curves.linear,
    );
    if (isNeedResetTimer) _state?.onResumeTimer();
  }

  @override
  void jumpToPage(int page) {
    final index = getRealIndex(
      _state?.pageController?.page?.toInt() ?? 0,
      (_state?.realPage ?? 0) - (_state?.initialPage ?? 0),
      _state?.itemCount ?? 0,
    );

    _setModeController();
    final int pageToJump =
        (_state?.pageController?.page?.toInt() ?? 0) + page - index;
    return _state?.pageController?.jumpToPage(pageToJump);
  }

  @override
  Future<void> animateToPage(
    int page, {
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    final bool isNeedResetTimer =
        _state?.options.pauseAutoPlayOnManualNavigate ?? false;
    if (isNeedResetTimer) {
      _state?.onResetTimer();
    }
    final index = getRealIndex(
      _state?.pageController?.page?.toInt() ?? 0,
      (_state?.realPage ?? 0) - (_state?.initialPage ?? 0),
      _state?.itemCount ?? 0,
    );
    int smallestMovement = page - index;
    if ((_state?.options.enableInfiniteScroll ?? false) &&
        _state?.itemCount != null &&
        (_state?.options.animateToClosest ?? false)) {
      if ((page - index).abs() >
          (page + (_state?.itemCount ?? 0) - index).abs()) {
        smallestMovement = page + (_state?.itemCount ?? 0) - index;
      } else if ((page - index).abs() >
          (page - (_state?.itemCount ?? 0) - index).abs()) {
        smallestMovement = page - (_state?.itemCount ?? 0) - index;
      }
    }
    _setModeController();
    await _state?.pageController?.animateToPage(
      (_state?.pageController?.page?.toInt() ?? 0) + smallestMovement,
      duration: duration ?? 300.inMilliseconds,
      curve: curve ?? Curves.linear,
    );
    if (isNeedResetTimer) _state?.onResumeTimer();
  }

  @override
  void startAutoPlay() => _state?.onResumeTimer();

  @override
  void stopAutoPlay() => _state?.onResetTimer();
}
