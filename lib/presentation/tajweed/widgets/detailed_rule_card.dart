import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DetailedRuleCard extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final Color cardColor;
  final String description;
  final String arabicText;

  const DetailedRuleCard({
    super.key,
    required this.theme,
    required this.title,
    required this.cardColor,
    required this.description,
    required this.arabicText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: fifteenPx),
      padding: padding15,
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.1),
        borderRadius: radius20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: QuranScreen.width,
            padding: padding10,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: radius12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SvgPicture.asset(
                  SvgPath.icAudioPlay,
                ),
              ],
            ),
          ),
          gapH18,
          Text(
            description,
            style: theme.textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          gapH18,
          Container(
            width: QuranScreen.width,
            padding:
                EdgeInsets.symmetric(horizontal: fifteenPx, vertical: eightPx),
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.2),
              borderRadius: radius12,
            ),
            child: Text(
              arabicText,
              style: context.quranText.arabicAyah!.copyWith(
                fontFamily: FontFamily.kfgq,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
