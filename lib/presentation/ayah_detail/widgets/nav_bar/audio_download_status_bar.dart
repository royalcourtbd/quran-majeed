import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/track_progress_bar.dart';

class AudioDownloadStatusBar extends StatelessWidget {
  final String qariName;
  final String downloadRange;
  final int downloadProgress;
  final VoidCallback onCancelPressed;
  final ThemeData theme;
  final double bottomNavigationBarHeight;
  const AudioDownloadStatusBar({
    super.key,
    required this.qariName,
    required this.downloadRange,
    required this.downloadProgress,
    required this.onCancelPressed,
    required this.bottomNavigationBarHeight,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: bottomNavigationBarHeight,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(left: twentyPx, right: twentyPx, top: tenPx),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(twentyPx),
        ),
        color: theme.cardColor,
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Text(
            qariName,
            style: theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: context.color.primaryColor.withOpacity(0.5),
            ),
          ),
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                downloadRange,
                style: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Completed $downloadProgress%',
                style: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          gapH15,
          TrackProgressBar(
            progress: downloadProgress.toDouble() / 100,
            onTapSeek: (double seekPercent) {
              // Do nothing
            },
            theme: theme,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: onCancelPressed,
              child: Text(
                'Cancel',
                style: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.color.primaryColor,
                ),
              ),
            ),
          ),
          gapH5,
        ],
      ),
    );
  }
}
