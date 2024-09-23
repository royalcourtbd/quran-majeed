import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class NavButtonWidget extends StatelessWidget {
  const NavButtonWidget({
    super.key,
    required this.onTap,
    required this.iconSvgPath,
    this.iconColor,
    this.widget,
  });

  final VoidCallback onTap;
  final String iconSvgPath;
  final Widget? widget;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (widget != null) ? tenPx : twentyPx,
          vertical: fivePx,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(
              iconSvgPath,
              color: iconColor ?? theme.primaryColor,
              width: twentyPx,
              height: twentyPx,
            ),
            if (widget != null) ...[
              gapW5,
              widget!,
            ],
          ],
        ),
      ),
    );
  }
}
