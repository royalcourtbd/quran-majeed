import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class ShareScreenShotButton extends StatelessWidget {
  const ShareScreenShotButton({super.key, required this.theme, this.onPressed});
  final VoidCallback? onPressed;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: QuranScreen.width,
        padding: padding15,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: QuranColor.shareButtonGradients,
          ),
          borderRadius: BorderRadius.circular(fiftyPx),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(
              SvgPath.icShare2,
              width: twentyFivePx,
              height: twentyFivePx,
              color: Colors.white,
            ),
            gapW16,
            Text(
              'Share Screenshot',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
