import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon(
      {super.key, required this.svgPath, this.onPressed, required this.theme});
  final String svgPath;
  final VoidCallback? onPressed;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SvgPicture.asset(
        svgPath,
        fit: BoxFit.scaleDown,
        colorFilter: buildColorFilter(context.color.primaryColor),
      ),
    );
  }
}
