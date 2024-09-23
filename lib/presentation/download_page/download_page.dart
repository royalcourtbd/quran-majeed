import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/download_page/available_downloadable_item.dart';
import 'package:quran_majeed/presentation/download_page/downloaded_items.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class DownloadPage extends StatelessWidget {
  final String title;
  final bool isTafseer;
  final int surahID;
  final dynamic presenter;

  const DownloadPage({
    super.key,
    required this.title,
    required this.isTafseer,
    required this.presenter,
    this.surahID = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: isTafseer
          ? (presenter as TafseerPresenter)
          : (presenter as TranslationPresenter),
      builder: () {
        final dynamic uiState = presenter.currentUiState;
        return Scaffold(
          appBar: CustomAppBar(
            title: title,
            theme: theme,
          ),
          body: Column(
            children: [
              Expanded(
                child: RoundedScaffoldBody(
                  isColored: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //TODO: V2.0 te Search functionality korte hobe
                      // CustomSearchField(
                      //   theme: theme,
                      //   textEditingController: _searchController,
                      //   hintText: 'Search $title',
                      // ),
                      // gapH20,
                      gapH10,
                      uiState.isLoading
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: QuranScreen.width / 1.5),
                              child: LoadingIndicator(
                                color: context.color.primaryColor,
                                theme: theme,
                              ),
                            )
                          : Expanded(
                              key: key,
                              child: FadeIn(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: [
                                    DownloadedItems(
                                      key: key,
                                      theme: theme,
                                      downloadedItems: uiState.availableItems,
                                      title: title,
                                      isItemSelected: (item) =>
                                          presenter.isSelected(item),
                                      deleteItem: (item) async =>
                                          await RemoveDialog.show(
                                        title: "Remove Item",
                                        context: context,
                                        onRemove: () =>
                                            presenter.deleteItem(item),
                                      ),
                                      surahID: surahID,
                                      downloadProgress:
                                          uiState.downloadProgress,
                                      onSelectItem: (
                                              {required TTDbFileModel file,
                                              int? surahID}) async =>
                                          await presenter.toggleSelection(
                                              file: file, surahID: surahID),
                                      isShowDeleteButton: (item) =>
                                          presenter.isShowDeleteButton(item),
                                    ),
                                    gapH10,
                                    AvailableDownloadableItem(
                                      key: key,
                                      theme: theme,
                                      title: title,
                                      totalItems: uiState.downloadableItems,
                                      initiateDownloadFunc:
                                          (languageKey, file) =>
                                              presenter.initiateDownload(
                                                  languageKey: languageKey,
                                                  file: file),
                                      totalAvailableToDownloadItemsCount: uiState
                                          .totalAvailableToDownloadItemsCount,
                                      totalSizes: uiState.totalSizes,
                                      downloadProgress:
                                          uiState.downloadProgress,
                                      isAllFilesDownloading:
                                          uiState.isAllFilesDownloading,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
