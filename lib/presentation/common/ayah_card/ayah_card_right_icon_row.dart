import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

import 'package:quran_majeed/core/utility/utility.dart';

class RightIconRow extends StatelessWidget {
  const RightIconRow({
    super.key,
    required this.icon,
    required this.rowTitle,
    required this.theme,
    required this.onTapMoreButton,
    required this.isLeftAligned,
  });

  final Widget? icon;
  final String rowTitle;
  final ThemeData theme;
  final VoidCallback onTapMoreButton;
  final bool isLeftAligned;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rowTitle,
          textAlign: isLeftAligned ? TextAlign.start : TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        isMobile ? gapW10 : gapW5,
        icon ?? const SizedBox.shrink(),
        const Spacer(),
        InkWell(
          onTap: onTapMoreButton,
          child: Container(
            padding: EdgeInsets.only(
                top: twelvePx, left: twentyFivePx, bottom: twelvePx),
            height: fortyTwoPx,
            width: fortyTwoPx,
            child: SvgImage(
              SvgPath.icThreeDotOption,
              width: isMobile ? sixteenPx : tenPx,
              height: isMobile ? sixteenPx : tenPx,
              color: context.color.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
