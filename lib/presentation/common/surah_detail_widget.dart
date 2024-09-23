import 'package:flutter/material.dart';

import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SurahDetailWidget extends StatelessWidget {
  const SurahDetailWidget({
    super.key,
    required this.theme,
    required this.surahName,
    required this.surahType,
    required this.totalAyah,
  });

  final ThemeData theme;
  final String surahName;
  final String surahType;
  final int totalAyah;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          surahName,
          style: theme.textTheme.titleMedium,
        ),
        gapH4,
        Text(
          '$surahType • $totalAyah ${context.l10n.verses}',
          style: theme.textTheme.bodySmall!.copyWith(
            color: context.color.subtitleColor,
          ),
        ),
      ],
    );
  }
}
