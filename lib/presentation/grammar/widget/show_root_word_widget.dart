import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class ShowRootWordWidget extends StatelessWidget {
  const ShowRootWordWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.theme,
  });

  final String title;
  final String? subtitle;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        gapW15,
        Text(
          subtitle ?? "",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.kfgq,
            fontSize: nineteenPx,
          ),
        ),
      ],
    );
  }
}
