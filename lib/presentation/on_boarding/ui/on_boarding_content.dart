import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_presenter.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/language_selection_list.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_ui_state.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_content_screen.dart';

class OnBoardingContent extends StatelessWidget {
  OnBoardingContent({
    super.key,
    required this.screenIndex,
    required this.onGoNextPage,
    required this.progress,
    required this.theme,
  });

  final int screenIndex;
  final VoidCallback onGoNextPage;
  final double progress;
  final ThemeData theme;

  final OnBoardingPresenter _presenter = locate<OnBoardingPresenter>();
  bool get isDbLoadingScreen => screenIndex == 3;

  @override
  Widget build(BuildContext context) {
    final List<OnBoardingScreen> screen = _presenter.currentUiState.screenList;

  switch (screenIndex) {
    case 0:
    return OnBoardingContentScreen(
      title: screen[0].title,
      description: screen[0].description,
      theme: theme,
      iconSvgPath: screen[0].iconSvgPath,
      isDbLoadingScreen: isDbLoadingScreen,
      screenIndex: 0,
      onGoNextPage: onGoNextPage,
      progress: progress,
    );
    case 1:
    return OnBoardingContentScreen(
      title: screen[1].title,
      description: screen[1].description,
      theme: theme,
      iconSvgPath: screen[1].iconSvgPath,
      isDbLoadingScreen: isDbLoadingScreen,
      screenIndex: 1,
      onGoNextPage: onGoNextPage,
      progress: progress,
    );
    case 2:
    return LanguageSelectionList(screenIndex: screenIndex, onGoNextPage: onGoNextPage, theme: theme);
    case 3:
    return OnBoardingContentScreen(
      title: screen[2].title,
      description: screen[2].description,
      theme: theme,
      iconSvgPath: screen[2].iconSvgPath,
      isDbLoadingScreen: isDbLoadingScreen,
      screenIndex: 3,
      onGoNextPage: onGoNextPage,
      progress: progress,
    );
    default:
    return const SizedBox();
  }}
}
