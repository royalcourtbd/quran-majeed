import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class BuildExpansionTileTitle extends StatelessWidget {
  const BuildExpansionTileTitle({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ٱلْعَـٰلَمِينَ',
          style: context.quranText.arabicAyah!.copyWith(
            fontFamily: FontFamily.kfgq,
            fontSize: seventeenPx,
            color: theme.primaryColor,
          ),
        ),
        Row(
          children: [
            Text(
              'Occurrences : ',
              style: theme.textTheme.bodySmall!.copyWith(
                color: context.color.primaryColor,
              ),
            ),
            Text(
              '',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
