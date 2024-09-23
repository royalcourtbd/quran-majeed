import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';

class ArabicWordWidget extends StatelessWidget {
  final ThemeData theme;
  const ArabicWordWidget({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "الله",
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.kfgq,
          fontSize: fortyTwoPx,
          color: theme.primaryColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "هما",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.kfgq,
              fontSize: fortyTwoPx,
              color: theme.secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }
}
