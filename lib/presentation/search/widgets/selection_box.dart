import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class SelectionBox extends StatelessWidget {
  const SelectionBox({
    super.key,
    required this.themeData,
    required this.title,
    required this.onTap,
  });

  final ThemeData themeData;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: themeData,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: fifteenPx,
          vertical: fifteenPx,
        ),
        decoration: BoxDecoration(
          color: themeData.primaryColor.withOpacity(0.1),
          borderRadius: radius10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: themeData.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            Transform.rotate(
              angle: 3 * pi / 2,
              child: SvgPicture.asset(
                SvgPath.icBack,
                width: twentyTwoPx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
