import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SettingsCardHeader extends StatelessWidget {
  const SettingsCardHeader({
    super.key,
    required this.title,
    required this.svgPath,
    this.trailing,
    this.isSelected = false,
  });

  final String title;
  final String svgPath;
  final Widget? trailing;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: isMobile
            ? Colors.transparent
            : isSelected
                ? context.color.primaryColor.withOpacity(0.06)
                : Colors.transparent,
        borderRadius: isMobile ? BorderRadius.zero : radius3,
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 0 : fivePx,
        horizontal: isMobile ? 0 : fivePx,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            width: isMobile ? twentyFivePx : twelvePx,
            colorFilter:
                buildColorFilterToChangeColor(context.color.primaryColor),
          ),
          isMobile ? gapW12 : gapW8,
          Text(
            title,
            style: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.color.primaryColor,
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
