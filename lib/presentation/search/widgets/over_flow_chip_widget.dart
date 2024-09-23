import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class OverFlowChipWidget extends StatelessWidget {
  const OverFlowChipWidget({
    super.key,
    required this.theme,
    this.onTap,
  });

  final ThemeData theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      onTap: onTap,
      theme: theme,
      child: Chip(
        padding: EdgeInsets.only(
          left: fivePx,
          top: fivePx,
          bottom: fivePx,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'More',
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            gapW5,
            Transform.rotate(
              angle: pi / 1,
              child: SvgPicture.asset(
                SvgPath.icBack,
                width: twentyTwoPx,
              ),
            ),
          ],
        ),
        backgroundColor: theme.cardColor,
        side: BorderSide.none,
      ),
    );
  }
}
