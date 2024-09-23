import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.svgPath,
    required this.onTap,
    required this.theme,
  });

  final String svgPath;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: thirtyPx,
        width: thirtyPx,
        padding: padding10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacity(.2),
          borderRadius: radius10,
        ),
        child: SvgPicture.asset(
          svgPath,
          width: twentyFivePx,
          height: twentyFivePx,
          colorFilter: buildColorFilter(
            context.color.primaryColor,
          ),
        ),
      ),
    );
  }
}
