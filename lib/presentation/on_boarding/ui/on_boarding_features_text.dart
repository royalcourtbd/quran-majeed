import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class OnBoardingFeaturesText extends StatelessWidget {
  const OnBoardingFeaturesText({
    super.key,
    required this.title,
    required this.description,
    required this.theme,
  });

  final String title;
  final String description;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          gapH16,
          Text(
            description,
            style: theme.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
          gapH15,
        ],
      ),
    );
  }
}
