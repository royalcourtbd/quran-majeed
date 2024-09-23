import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class AdaptiveSelectionBox extends StatelessWidget {
  const AdaptiveSelectionBox({
    super.key,
    this.title,
    required this.boxTitle,
    required this.onTap,
  });

  final String? title;
  final String boxTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        if (title != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall!.copyWith(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          gapH10,
        ],
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: isMobile ? radius6 : radius3,
            ),
            width: double.infinity,
            padding: isMobile ? padding10 : padding5,
            height: isMobile ? fortyPx : twentyFivePx,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    boxTitle,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  SvgPath.icArrowDownOutline,
                  width: twentyPx,
                  colorFilter: buildColorFilter(context.color.blackColor),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
