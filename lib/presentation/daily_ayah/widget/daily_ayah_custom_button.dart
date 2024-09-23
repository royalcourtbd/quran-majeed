import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DailyAyahCustomButton extends StatelessWidget {
  final String title, icon;
  final Function() onTap;
  final ThemeData theme;
  const DailyAyahCustomButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: fortyFourPx,
          decoration: BoxDecoration(
              color: context.color.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(fivePx))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: eighteenPx,
                height: eighteenPx,
                colorFilter: buildColorFilter(context.color.primaryColor),
              ),
              gapW10,
              Text(
                title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: context.color.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
