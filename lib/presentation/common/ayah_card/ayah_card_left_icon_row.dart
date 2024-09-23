import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

import 'package:quran_majeed/core/utility/utility.dart';

class LeftIconRow extends StatelessWidget {
  const LeftIconRow({
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
        icon ?? const SizedBox.shrink(),
        isMobile ? gapW10 : gapW5,
        Expanded(
          child: Text(
            rowTitle,
            textAlign: isLeftAligned ? TextAlign.start : TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: context.color.primaryColor,
            ),
          ),
        ),
        gapW15,
        GestureDetector(
          onTap: onTapMoreButton,
          child: SvgImage(
            SvgPath.icThreeDotOption,
            width: isMobile ? sixteenPx : tenPx,
            height: isMobile ? sixteenPx : tenPx,
            color: context.color.primaryColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
