import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/audio/audio_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/auto_scroll_control_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_bar/audio_download_status_bar.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_bar/audio_player_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_details_page_app_bar.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_page_scroll_view.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_bar/simple_navigation_buttons.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';
import 'package:quran_majeed/core/external_libs/fancy_scaffold.dart';

class AyahDetailsPage extends StatelessWidget {
  AyahDetailsPage({
    super.key,
    this.initialPageIndex = 0,
    required this.initialAyahIndex,
  });
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final AyahPresenter _ayahPresenter = locate<AyahPresenter>();
  late final AudioPresenter _audioPresenter = locate<AudioPresenter>();

  final int initialPageIndex;
  final int initialAyahIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PopScope(
      onPopInvokedWithResult: (bool isPopInvoked, dynamic result) =>
          _ayahPresenter.fetchAndSaveLastAyah(),
      child: PresentableWidgetBuilder(
        presenter: _ayahPresenter,
        onInit: () async {
          await _ayahPresenter.initializeAyahDetailsPage(
            initialPageIndex: initialPageIndex,
            initialAyahIndex: initialAyahIndex,
          );
        },
        builder: () {
          final AyahViewUiState uiState = _ayahPresenter.uiState.value;
          final AudioUIState audioUIState = _audioPresenter.uiState.value;
          return Scaffold(
            key: scaffoldKey,
            endDrawer: MiniSettingsDrawer(),
            body: FancyScaffold(
              isAudioPlaying: audioUIState.isPlaying,
              appBar: AyahDetailsPageAppBar(
                key: const Key('ayah_details_page_app_bar'),
                ayahPresenter: _ayahPresenter,
                scaffoldKey: scaffoldKey,
                theme: theme,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: AyahPageScrollView(
                      key: const Key('ayah_page_scroll_view'),
                      ayahPresenter: _ayahPresenter,
                      uiState: uiState,
                    ),
                  ),
                ],
              ),
              bottomNavigationBarHeight: uiState.bottomNavigationBarHeight,
              bottomNavigationBar: audioUIState.isDownloading
                  ? AudioDownloadStatusBar(
                      qariName: _audioPresenter.getSelectedReciterName(),
                      downloadRange:
                          '${audioUIState.selectedStartSurahName} - ${audioUIState.selectedEndSurahName}',
                      downloadProgress: audioUIState.downloadProgress,
                      onCancelPressed: () => _audioPresenter.cancelDownload(),
                      bottomNavigationBarHeight:
                          uiState.bottomNavigationBarHeight,
                      theme: theme,
                    )
                  : audioUIState.showPlayerControls
                      ? AudioPlayerWidget(
                          theme: theme,
                          progress:
                              audioUIState.currentPlayTime!.inMilliseconds /
                                  audioUIState.totalDuration!.inMilliseconds,
                          audioPresenter: _audioPresenter,
                          isFromAyahDetail: true,
                          bottomNavigationBarHeight:
                              uiState.bottomNavigationBarHeight,
                        )
                      : uiState.autoScroll
                          ? AutoScrollControlWidget(
                              theme: theme,
                              ayahPresenter: _ayahPresenter,
                              bottomNavigationBarHeight:
                                  uiState.bottomNavigationBarHeight,
                            )
                          : SimpleNavigationButtons(
                              ayahPresenter: _ayahPresenter,
                              audioPresenter: _audioPresenter,
                              theme: theme,
                              isTafseerPage: false,
                              bottomNavigationBarHeight:
                                  uiState.bottomNavigationBarHeight,
                            ),
            ),
          );
        },
      ),
    );
  }
}
