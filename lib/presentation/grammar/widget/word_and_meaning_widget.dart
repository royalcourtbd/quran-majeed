import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';

class WordAndMeaningWidget extends StatelessWidget {
  final ThemeData theme;
  const WordAndMeaningWidget({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.kfgq,
          fontSize: fortyTwoPx,
          color: Colors.red,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.kfgq,
              fontSize: fortyTwoPx,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: '',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.kfgq,
              fontSize: fortyTwoPx,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: '',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.kfgq,
              fontSize: fortyTwoPx,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: '',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.kfgq,
              fontSize: fortyTwoPx,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
