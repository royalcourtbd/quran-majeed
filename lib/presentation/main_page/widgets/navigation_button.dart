import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.iconPath,
    required this.theme,
    this.onPressed,
  });

  final String iconPath;
  final VoidCallback? onPressed;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      onTap: onPressed,
      theme: theme,
      child: Container(
        padding: EdgeInsets.all(tenPx),
        width: fortyFivePx,
        height: fortyFivePx,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(twentyPx),
        ),
        child: SvgPicture.asset(
          iconPath,
          width: fortyFivePx,
          colorFilter: buildColorFilter(context.color.primaryColor),
        ),
      ),
    );
  }
}
