import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.theme,
    required this.isDownloading,
    required this.downloadProgress,
    this.isAllFilesDownloading = false,
    required this.onTapDownloadButton,
  });

  final ThemeData theme;
  final bool isDownloading;
  final int downloadProgress;
  final bool isAllFilesDownloading;
  final VoidCallback onTapDownloadButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapDownloadButton,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            (isDownloading && !isAllFilesDownloading)
                ? SvgPath.icClose
                : SvgPath.icDownload,
            width: (isDownloading && !isAllFilesDownloading)
                ? fourteenPx
                : twentyFourPx,
            colorFilter:
                buildColorFilter(context.color.blackColor.withOpacity(0.3)),
          ),
          if (isDownloading && !isAllFilesDownloading)
            SizedBox(
              width: twentyFourPx, // Slightly larger than the icon
              height: twentyFourPx,
              child: CircularProgressIndicator(
                value: isDownloading ? downloadProgress / 100.0 : null,
                backgroundColor: context.color.primaryColor.withOpacity(0.2),
                valueColor:
                    AlwaysStoppedAnimation<Color>(context.color.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
