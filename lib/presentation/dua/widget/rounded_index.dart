import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class RoundedIndex extends StatelessWidget {
  const RoundedIndex({
    super.key,
    required this.theme,
    required this.subCategoryIndex,
    required this.bgColor,
    required this.textColor,
    this.height,
    this.width,
  });

  final ThemeData theme;
  final int subCategoryIndex;
  final double? height, width;
  final Color? bgColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? thirtyFivePx,
      width: width ?? thirtyFivePx,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        "${subCategoryIndex + 1}",
        style: theme.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
