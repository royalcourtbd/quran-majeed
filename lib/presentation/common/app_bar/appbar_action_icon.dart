import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';

class AppbarActionIcon extends StatelessWidget {
  const AppbarActionIcon({
    super.key,
    required this.theme,
    required this.svgPath,
    this.width,
    this.height,
    this.iconColor,
    this.onIconTap,
  });

  final String svgPath;
  final ThemeData theme;
  final Color? iconColor;
  final VoidCallback? onIconTap;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onIconTap,
      visualDensity: VisualDensity.compact,
      icon: SvgImage(
        svgPath,
        color: iconColor ?? theme.primaryColor,
        width: width ?? twentyTwoPx,
        height: height ?? twentyTwoPx,
      ),
    );
  }
}
