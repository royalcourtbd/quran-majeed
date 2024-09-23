import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SetNotificationTimeSetting extends StatelessWidget {
  const SetNotificationTimeSetting({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: textTheme.titleSmall!.copyWith(
            fontWeight: isMobile ? FontWeight.w600 : FontWeight.w700,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? fifteenPx : sevenPx,
              vertical: isMobile ? eightPx : fourPx,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.scrim.withOpacity(0.1),
              borderRadius: radius5,
              border: Border.all(
                color: themeData.colorScheme.scrim.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: isMobile ? FontWeight.w400 : FontWeight.w500,
                    color: themeData.primaryColor,
                  ),
                ),
                gapW5,
                SvgPicture.asset(
                  SvgPath.icArrowDownOutline,
                  height: isMobile ? twentyPx : tenPx,
                  colorFilter: buildColorFilterToChangeColor(
                      themeData.colorScheme.scrim),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
