import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomNotificationTile extends StatelessWidget {
  final int index;
  final String title, subtitle, time, iconPath;
  final Function() onTap;
  const CustomNotificationTile({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: QuranScreen.width,
            color: index % 2 == 0
                ? theme.cardColor.withOpacity(0.5)
                : theme.scaffoldBackgroundColor,
            padding: EdgeInsets.all(tenPx),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: fiftyPx,
                  width: fiftyPx,
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(sixPx)),
                  padding: EdgeInsets.all(tenPx),
                  child: SvgPicture.asset(iconPath,
                      colorFilter:
                          buildColorFilter(context.color.primaryColor)),
                ),
                gapW10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH3,
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.color.subtitleColor,
                        ),
                      ),
                      gapH10,
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgPath.icTimer,
                            height: twelvePx,
                            width: twelvePx,
                            colorFilter: buildColorFilter(theme.primaryColor),
                          ),
                          SizedBox(width: 3.px),
                          Text(
                            time,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: tenPx,
                              color: context.color.subtitleColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          BuildDivider(theme: theme)
        ],
      ),
    );
  }
}
