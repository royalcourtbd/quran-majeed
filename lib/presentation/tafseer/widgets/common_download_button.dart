import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CommonDownloadButton extends StatelessWidget {
  const CommonDownloadButton({
    super.key,
    required this.theme,
    required this.isVisible,
    required this.downloadProgress,
  });

  final ThemeData theme;
  final bool isVisible;
  final double downloadProgress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        downloadProgress > 0 && isVisible
            ? SvgPicture.asset(
                SvgPath.icCancelDownload,
                width: twelvePx,
                colorFilter: buildColorFilter(context.color.primaryColor),
              )
            : SvgPicture.asset(
                SvgPath.icDownload,
                width: twentyFourPx,
                colorFilter: buildColorFilter(
                  context.color.primaryColor,
                ),
              ),
        if (downloadProgress > 0 && isVisible)
          SizedBox(
            width: twentyFourPx, // Slightly larger than the icon
            height: twentyFourPx,
            child: CircularProgressIndicator(
              value: downloadProgress,
              backgroundColor: context.color.primaryColor.withOpacity(0.2),
              valueColor:
                  AlwaysStoppedAnimation<Color>(context.color.primaryColor),
            ),
          ),
      ],
    );
  }
}
