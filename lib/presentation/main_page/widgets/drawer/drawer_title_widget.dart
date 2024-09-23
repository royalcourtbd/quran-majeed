import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DrawerTitleWidget extends StatelessWidget {
  final String title;
  final ThemeData theme;
  const DrawerTitleWidget(
      {super.key, required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: QuranScreen.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? fivePercentWidth : threePercentWidth,
                vertical: fivePx),
            child: Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.color.subtitleColor,
              ),
            ),
          ),
        ),
        BuildDivider(
          theme: theme,
        ),
      ],
    );
  }
}
