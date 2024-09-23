import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/buttons/download_button.dart';
import 'package:quran_majeed/presentation/common/show_surah_number_widget.dart';
import 'package:quran_majeed/presentation/common/surah_detail_widget.dart';

class SurahAudioListItem extends StatelessWidget {
  final int index;
  final Reciter reciter;
  final ThemeData theme;

  late final ReciterPresenter reciterPresenter = locate<ReciterPresenter>();

  SurahAudioListItem({
    super.key,
    required this.index,
    required this.reciter,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: PresentableWidgetBuilder(
        presenter: reciterPresenter,
        builder: () {
          final ReciterUiState uiState = reciterPresenter.currentUiState;
          bool isDownloaded =
              uiState.reciterSurahIds?[reciter.id]?.contains(index + 1) ??
                  false;
          return Container(
            padding: EdgeInsets.only(top: tenPx, bottom: tenPx, right: twoPx),
            child: Row(
              children: [
                gapW20,
                Visibility(
                  visible: reciterPresenter.uiState.value.checkBoxVisible!,
                  child: Transform.scale(
                    scale: 0.9,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: reciterPresenter.uiState.value.isSelected ==
                          {reciterPresenter.uiState.value.isSelected}
                              .contains(index),
                      onChanged: (value) {
                        reciterPresenter.selectSurah(index);
                      },
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                    ),
                  ),
                ),
                reciterPresenter.uiState.value.checkBoxVisible!
                    ? gapW12
                    : const SizedBox.shrink(),
                ShowSurahNumberWidget(
                  theme: theme,
                  formatSurahNumber: (index + 1).toString(),
                ),
                gapW15,
                SurahDetailWidget(
                  theme: theme,
                  surahName: getTranslatedSurahName(
                      surah: CacheData.surahsCache[index], context: context),
                  surahType: getSurahType(
                      type: CacheData.surahsCache[index].type,
                      context: context),
                  totalAyah: CacheData.surahsCache[index].totalAyah,
                ),
                const Spacer(),
                isDownloaded
                    ? GestureDetector(
                        onTap: () async {
                          await RemoveDialog.show(
                            title:
                                "${CacheData.surahsCache[index].nameEn} Audio",
                            context: context,
                            onRemove: () => reciterPresenter
                                .deleteAudioFilesBySurahAndReciter(
                                    surahId: index + 1, reciter: reciter),
                          );
                        },
                        child: SvgImage(
                          SvgPath.icDeleteOutline,
                          width: twentyPx,
                          height: twentyPx,
                          color: context.color.primaryColor.withOpacity(0.5),
                        ),
                      )
                    : DownloadButton(
                        theme: theme,
                        downloadProgress: uiState.downloadProgress!,
                        isDownloading: (index + 1) ==
                                uiState.currentDownloadingSurahIndex! &&
                            uiState.isDownloading!,
                        onTapDownloadButton: () =>
                            reciterPresenter.downloadSurahAudio(
                          index + 1,
                          reciter,
                        ),
                      ),
                gapW20,
              ],
            ),
          );
        },
      ),
    );
  }
}
