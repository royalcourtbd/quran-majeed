import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/audio/audio_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/counter_control.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';
import 'package:quran_majeed/presentation/common/build_row_with_arrow_widget.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/audio/reciter/ui/reciter_page.dart';

class AudioPlayBottomSheet extends StatelessWidget {
  AudioPlayBottomSheet({super.key, required this.isFromAyahDetail});
  final bool isFromAyahDetail;

  static Future<void> show({
    required BuildContext context,
    bool? isFromAyahDetail,
  }) async {
    final AudioPlayBottomSheet audioPlayBottomSheet = await Future.microtask(
      () => AudioPlayBottomSheet(
        key: const Key("AudioPlayBottomSheet"),
        isFromAyahDetail: isFromAyahDetail!,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(audioPlayBottomSheet, context);
    }
  }

  final AudioPresenter _audioPresenter = locate<AudioPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: _audioPresenter,
      builder: () {
        final AudioUIState uiState = _audioPresenter.currentUiState;

        return CustomBottomSheetContainer(
          key: const Key('AudioPlayBottomSheet'),
          theme: theme,
          bottomSheetTitle: context.l10n.audioSetting,
          children: [
            const Row(
              children: [
                //TODO: When online audio stream is implemented, uncomment this code
                // Expanded(
                //   key: const Key('OnlineAudioStream'),
                //   child: MenuListItem(
                //     theme: theme,
                //     iconPath: SvgPath.icMusicPlayList,
                //     title: 'Online Audio Stream',
                //   ),
                // ),
                // QuranAppSwitchButton(
                //   key: const Key('OnlineAudioStreamSwitch'),
                //   height: nineteenPx,
                //   width: thirtyFivePx,
                //   padding: twoPx,
                //   toggleSize: fifteenPx,
                //   borderRadius: twelvePx,
                //   toggled: uiState.isOnlinePlaying!,
                //   onToggle: (value) {
                //     _audioPresenter.onAudioPlayOnline();
                //   },
                //   inactiveSwitchBorder: Border.all(
                //     color: context.color.primaryColor.withOpacity(0.3),
                //     width: 1.3,
                //   ),
                // )
              ],
            ),
            if (isFromAyahDetail) ...[
              gapH12,
              BuildRowWithArrowWidget(
                key: const Key('StartSurah'),
                theme: theme,
                iconPath: SvgPath.icDocumentOutline,
                title: context.l10n.startSurah,
                subtitle:
                    '${uiState.selectedStartSurahName} ${uiState.selectedStartSurahId!}:${uiState.selectedStartAyahId!}',
                onClicked: () => _audioPresenter.onSelectSurahButtonClicked(
                  context,
                  context.l10n.start,
                ),
              ),
              gapH12,
              BuildRowWithArrowWidget(
                key: const Key('EndSurah'),
                theme: theme,
                iconPath: SvgPath.icDocumentOutline,
                title: context.l10n.endSurah,
                subtitle:
                    '${uiState.selectedEndSurahName} ${uiState.selectedEndSurahId!}:${uiState.selectedEndAyahId!}',
                onClicked: () =>
                    _audioPresenter.onSelectSurahButtonClicked(context, 'End'),
              ),
            ],

            gapH12,
            BuildRowWithArrowWidget(
              key: const Key('SelectReciter'),
              theme: theme,
              iconPath: SvgPath.icAudioSquare,
              title: context.l10n.selectReciter,
              subtitle: _audioPresenter.getSelectedReciterName(),
              onClicked: () => uiState.isOnlinePlaying!
                  ? _audioPresenter.onClickOnlineAudioPlayButton(context)
                  : context.navigatorPush(ReciterPage()),
            ),
            gapH12,
            CounterControl(
              key: const Key('AyahRepeat'),
              theme: theme,
              label: context.l10n.ayahRepeat,
              iconPath: SvgPath.icRepeat,
              value: _audioPresenter.currentUiState.ayahRepeatNumber,
              unit: ' ${context.l10n.times}',
              onIncrement: () {
                showComingSoonMessage(context: context);
                //TODO: Uncomment this code when the feature is implemented

                // int currentRepeat =
                //     _audioPresenter.currentUiState.ayahRepeatNumber;
                // if (currentRepeat < 10) {
                //   _audioPresenter.updateAyahRepeatNumber(currentRepeat + 1);
                // }
              },
              onDecrement: () {
                showComingSoonMessage(context: context);

                //TODO: Uncomment this code when the feature is implemented

                // int currentRepeat =
                //     _audioPresenter.currentUiState.ayahRepeatNumber;
                // if (currentRepeat > 0) {
                //   _audioPresenter.updateAyahRepeatNumber(currentRepeat - 1);
                // }
              },
              // canIncrement:
              //     (_audioPresenter.currentUiState.ayahRepeatNumber) < 10,
              // canDecrement:
              //     (_audioPresenter.currentUiState.ayahRepeatNumber) > 0,
            ),
            gapH12,
            CounterControl(
              key: const Key('AyahDelay'),
              theme: theme,
              label: context.l10n.ayahDelay,
              iconPath: SvgPath.icTimer,
              value: _audioPresenter.currentUiState.ayahDelayNumber,
              unit: ' ${context.l10n.sec}',
              onIncrement: () {
                showComingSoonMessage(context: context);
                //TODO: Uncomment this code when the feature is implemented

                // int currentDelay =
                //     _audioPresenter.currentUiState.ayahDelayNumber;
                // if (currentDelay < 10) {
                //   _audioPresenter.updateAyahDelayNumber(currentDelay + 1);
                // }
              },
              onDecrement: () {
                showComingSoonMessage(context: context);
                //TODO: Uncomment this code when the feature is implemented

                // int currentDelay =
                //     _audioPresenter.currentUiState.ayahDelayNumber;
                // if (currentDelay > 0) {
                //   _audioPresenter.updateAyahDelayNumber(currentDelay - 1);
                // }
              },
              // canIncrement:
              //     (_audioPresenter.currentUiState.ayahDelayNumber) < 10,
              // canDecrement:
              //     (_audioPresenter.currentUiState.ayahDelayNumber) > 0,
            ),
            gapH20,
            SubmitButton(
              key: const Key('PlayAudio'),
              theme: theme,
              title: context.l10n.playAudio,
              buttonColor: theme.primaryColor,
              textColor: context.color.whiteColor,
              onTap: () {
                context.navigatorPop();
                _audioPresenter.displayAudioPlayerUI();
              },
            ),
            // gapH15,
          ],
        );
      },
    );
  }
}
