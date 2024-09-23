import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class StoreButton extends StatelessWidget {
  const StoreButton({
    super.key,
    required this.theme,
    required this.iconPath,
    required this.buttonLabel,
    this.onPressed,
  });

  final ThemeData theme;
  final String iconPath;
  final String buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: fiftyPx,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacity(0.07),
          borderRadius: radius10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            gapW10,
            Text(
              buttonLabel,
              style: theme.textTheme.bodyMedium,
            ),
            gapW18,
            SvgPicture.asset(
              SvgPath.icCopy,
              colorFilter: buildColorFilter(context.color.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
