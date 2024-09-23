import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SvgImage extends StatelessWidget {
  const SvgImage(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit,
      height: height,
      width: width,
      colorFilter: color == null ? null : buildColorFilterToChangeColor(color),
    );
  }
}
