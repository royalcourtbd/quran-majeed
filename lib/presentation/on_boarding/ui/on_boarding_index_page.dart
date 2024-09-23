import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/language_selection_list.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_content.dart';

class OnBoardingIndexPage extends StatelessWidget {
  const OnBoardingIndexPage({
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

  @override
  Widget build(BuildContext context) {
    if (screenIndex == 2) {
      return LanguageSelectionList(
        screenIndex: screenIndex,
        onGoNextPage: onGoNextPage,
        theme: theme,
      );
    }
    return OnBoardingContent(
      screenIndex: screenIndex,
      onGoNextPage: onGoNextPage,
      progress: progress,
      theme: theme,
    );
  }

 
}
