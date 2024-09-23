import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';

class SurahDetailTile extends StatelessWidget {
  const SurahDetailTile({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.theme,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: twentyPx),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium!.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: FontFamily.koho,
        ),
      ),
    );
  }
}
