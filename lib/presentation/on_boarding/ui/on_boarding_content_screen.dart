import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/database_loader_indicator.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_features_next_button.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_features_text.dart';

class OnBoardingContentScreen extends StatelessWidget {
  const OnBoardingContentScreen({
    super.key,
    required this.title,
    required this.description,
    required this.theme,
    required this.iconSvgPath,
    required this.isDbLoadingScreen,
    required this.screenIndex,
    required this.onGoNextPage,
    required this.progress,
  });

  final String title;
  final String description;
  final ThemeData theme;
  final String iconSvgPath;
  final bool isDbLoadingScreen;
  final int screenIndex;
  final VoidCallback onGoNextPage;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: QuranScreen.height * 0.21),
        SvgPicture.asset(iconSvgPath, fit: BoxFit.fill),
        const Spacer(),
        OnBoardingFeaturesText(
          title: title,
          description: description,
          theme: theme,
        ),
        if (isDbLoadingScreen) ...[
          DatabaseLoaderIndicator(progress: progress),
          gapH20
        ],
        if (!isDbLoadingScreen) ...[
          gapH50,
          OnboardingButton(
            onPressed: onGoNextPage,
            screenIndex: screenIndex,
            theme: theme,
          )
        ],
      ],
    );
  }
}
