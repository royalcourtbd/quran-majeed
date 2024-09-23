import 'package:flutter/material.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.title,
    this.onTap,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
    this.svgPicture,
    required this.theme,
  });

  final String title;
  final VoidCallback? onTap;
  final Color buttonColor;
  final Color textColor;
  final Widget? svgPicture;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: const Key('SubmitButton'),
        alignment: Alignment.center,
        width: double.infinity,
        height: fortyFourPx,
        decoration: BoxDecoration(
          borderRadius: isMobile ? radius8 : radius4,
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPicture != null) ...[
              svgPicture!,
              gapW10, // Assuming gapW10 is a SizedBox with width of 10
            ],
            Text(
              title,
              style: theme.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
