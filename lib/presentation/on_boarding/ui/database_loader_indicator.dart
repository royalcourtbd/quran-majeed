import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/track_progress_bar.dart';

class DatabaseLoaderIndicator extends StatelessWidget {
  const DatabaseLoaderIndicator({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final TextStyle? textThemeBodyMedium = textTheme.bodyMedium;
    final bool isLoadingFinished = progress == 100;
    final Color primaryColor = themeData.primaryColor;
    return AnimatedContainer(
      duration: 100.inMilliseconds,
      margin: paddingH16,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gapH50,
          RepaintBoundary(
            child: TrackProgressBar(
              progress: progress,
              theme: themeData,
            ),
          ),
          gapH10,
          if (isLoadingFinished)
            Text(
              "Optimized Complete",
              style: textThemeBodyMedium?.copyWith(
                color: primaryColor,
                fontSize: twelvePx,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            Text(
              "Already Optimized ${progress.toInt()}%",
              style: textThemeBodyMedium?.copyWith(
                fontSize: twelvePx,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
