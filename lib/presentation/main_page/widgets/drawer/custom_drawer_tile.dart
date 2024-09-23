import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title, svgPath;
  final Function() onTap;
  final bool isNotification;
  final int notificationCount;
  const CustomDrawerTile({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
    this.isNotification = false,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(theme.cardColor.withOpacity(0.7)),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? fivePercentWidth : threePercentWidth,
              vertical: isMobile ? fifteenPx : sixPx),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                height: isMobile ? twentyTwoPx : twelvePx,
                width: isMobile ? twentyTwoPx : twelvePx,
                colorFilter: buildColorFilter(context.color.primaryColor),
              ),
              gapW20,
              Text(
                title,
                style: theme.textTheme.titleMedium!.copyWith(),
              ),
              Flexible(
                  child: Container(
                alignment: Alignment.centerRight,
                child: isNotification
                    ? Container(
                        height: twentyPx,
                        width: twentyPx,
                        decoration: BoxDecoration(
                            color: context.color.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(fivePx)),
                        child: Center(
                          child: Text(
                            "$notificationCount",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.color.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
