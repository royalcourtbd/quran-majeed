import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_button_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/track_progress_bar.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({
    super.key,
    required this.theme,
    required this.progress,
    required this.audioPresenter,
    required this.isFromAyahDetail,
    required this.bottomNavigationBarHeight,
  });

  final ThemeData theme;
  final bool isFromAyahDetail;
  final double progress;
  final double bottomNavigationBarHeight;
  final AudioPresenter audioPresenter;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: bottomNavigationBarHeight,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: twentyPx,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(twentyPx)),
        color: theme.cardColor,
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          gapH20,
          TrackProgressBar(
            progress: progress,
            onTapSeek: (double seekPercent) async {
              await audioPresenter.seekAudio(seekPercent);
            },
            theme: theme,
          ),
          gapH15,
          //TODO: jodi next e vaia bole j audio duration dekhate hobe, tokhon eta uncomment korte hobe
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       formatDuration(uiState.currentPlayTime!),
          //       style: theme.textTheme.labelSmall!.copyWith(
          //         fontWeight: FontWeight.w400,
          //         fontSize: thirteenPx,
          //       ),
          //     ),
          //     Text(
          //       formatDuration(uiState.totalDuration!),
          //       style: theme.textTheme.labelSmall!.copyWith(
          //         fontWeight: FontWeight.w400,
          //         fontSize: thirteenPx,
          //       ),
          //     ),
          //   ],
          // ),
          gapH10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavButtonWidget(
                onTap: () async => await audioPresenter.stopAudio(),
                iconSvgPath: SvgPath.icStopAudio,
              ),
              NavButtonWidget(
                onTap: () async => await audioPresenter.seekToPreviousAyah(),
                iconSvgPath: SvgPath.icPrevious,
              ),
              audioPresenter.currentUiState.isPlaying
                  ? NavButtonWidget(
                      onTap: () async => await audioPresenter.pauseAudio(),
                      iconSvgPath: SvgPath.icPause,
                    )
                  : NavButtonWidget(
                      onTap: () async => await audioPresenter.resumePlayback(),
                      iconSvgPath: SvgPath.icPlayOutline,
                    ),
              NavButtonWidget(
                onTap: () async => await audioPresenter.seekToNextAyah(),
                iconSvgPath: SvgPath.icNextOutline,
              ),
              NavButtonWidget(
                onTap: () async =>
                    await audioPresenter.onClickAudioButton(context, true),
                iconSvgPath: SvgPath.icSettingOutLine,
              ),
            ],
          ),
          gapH20,
        ],
      ),
    );
  }
}
