import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ShowSurahNumberWidget extends StatelessWidget {
  const ShowSurahNumberWidget(
      {super.key, required this.formatSurahNumber, required this.theme});
  final String formatSurahNumber;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: isMobile ? padding5 : padding4,
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.7),
            borderRadius: isMobile ? radius10 : radius5,
          ),
          child: SvgPicture.asset(
            SvgPath.icSuraNumber,
            width: isMobile ? thirtyTwoPx : twentyPx,
            fit: BoxFit.cover,
            colorFilter:
                buildColorFilterToChangeColor(context.color.blackColor),
          ),
        ),
        Text(
          formatSurahNumber,
          style: context.quranText.lableExtraSmall!
              .copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
