import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SearchHeaderTextWidget extends StatelessWidget {
  const SearchHeaderTextWidget({
    super.key,
    required this.title,
    required this.theme,
  });

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: QuranScreen.width,
      padding: EdgeInsets.symmetric(vertical: fourPx, horizontal: twentyPx),
      color: theme.cardColor,
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
