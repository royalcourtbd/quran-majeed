import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/audio_download/widgets/download_row.dart';
import 'package:quran_majeed/presentation/audio/audio_download/widgets/qari_name_section.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/audio/audio_download/widgets/surah_audio_list.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';

class AudioDownloadPage extends StatelessWidget {
  AudioDownloadPage({
    super.key,
    required this.reciter,
  });

  final Reciter reciter;

  final ReciterPresenter reciterPresenter = locate<ReciterPresenter>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      appBar:
          CustomAppBar(title: context.l10n.audioDownloadManager, theme: theme),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              isColored: true,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  gapH20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: twentyPx),
                    child: QariNameSection(
                      reciter: reciter,
                      theme: theme,
                      reciterPresenter: reciterPresenter,
                    ),
                  ),
                  gapH20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: twentyPx),
                    child: DownloadRow(
                      tapOnDownloadButton: () {
                        showComingSoonMessage(context: context);
                        //  reciterPresenter.downloadAllSurahs(reciter);
                      },
                      theme: theme,
                      tapOnShareButton: () =>
                          showComingSoonMessage(context: context),
                    ),
                  ),
                  gapH22,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: twentyPx),
                    child: SectionHeader(
                      title: context.l10n.listOfSurahAudio,
                      theme: theme,
                    ),
                  ),
                  gapH8,
                  //TODO: V2.0 te Search functionality korte hobe
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: twentyPx),
                  //   child: SizedBox(
                  //     height: fortyFivePx,
                  //     child: UserInputField(
                  //       borderRadius: radius10,
                  //       textEditingController: _surahNameEditingController,
                  //       hintText: 'Search By Surah Name',
                  //       contentPadding: EdgeInsets.symmetric(horizontal: twentyPx),
                  //     ),
                  //   ),
                  // ),
                  // gapH5,
                  SurahAudioList(
                    reciter: reciter,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //TODO: Implement this
      // bottomNavigationBar: Visibility(
      //   visible: reciterPresenter.uiState.value.isSelected! != {},
      //   child: Container(
      //     width: QuranScreen.width,
      //     padding: EdgeInsets.symmetric(horizontal: twentyPx, vertical: fifteenPx),
      //     decoration: BoxDecoration(
      //       color: Theme.of(context).cardColor,
      //       borderRadius: const BorderRadius.vertical(
      //         top: Radius.circular(20),
      //       ),
      //     ),
      //     child: TwoWayActionButton(
      //       submitButtonTitle: 'Downad',
      //       cancelButtonTitle: 'Cancel',
      //       onSubmitButtonTap: () => {},
      //       onCancelButtonTap: () => context.navigatorPop<void>(),
      //     ),
      //   ),
      // ),
    );
  }
}
