import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class LanguageSelectionDescription extends StatelessWidget {
  const LanguageSelectionDescription({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = theme.textTheme;
    final TextStyle regularBodyStyle = textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx, fontWeight: FontWeight.w400, height: 1.5);
    final TextStyle mediumBodyStyle = textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx, fontWeight: FontWeight.w600, height: 1.5);
    return Padding(
      padding:
          EdgeInsets.only(top: kToolbarHeight, left: twentyPx, right: twentyPx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Language',
            style: textTheme.bodyMedium!.copyWith(
              fontSize: twentyThreePx,
              fontWeight: FontWeight.w800,
            ),
          ),
          gapH15,
          RichText(
            key: key,
            text: TextSpan(
              children: [
                _buildTextSpan('Translations, Tafsir', mediumBodyStyle),
                _buildTextSpan(' and ', regularBodyStyle),
                _buildTextSpan('Word by Word', mediumBodyStyle),
                _buildTextSpan(
                    ' language will be automatically selected based on your language selection.',
                    regularBodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(String text, TextStyle style) {
    return TextSpan(text: text, style: style);
  }
}
