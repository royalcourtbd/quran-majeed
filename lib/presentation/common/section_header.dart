import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.theme,
  });
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.quranText.lableExtraSmall!.copyWith(
          fontWeight: FontWeight.w600,
          color: context.color.subtitleColor,
        ),
      ),
    );
  }
}
