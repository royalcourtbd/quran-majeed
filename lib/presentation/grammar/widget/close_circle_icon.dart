import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CloseCircleIcon extends StatelessWidget {
  final BuildContext context;

  const CloseCircleIcon(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      SvgPath.icCloseCircle,
      height: twentyPx,
      width: twentyPx,
      colorFilter: buildColorFilter(context.color.primaryColor),
    );
  }
}
