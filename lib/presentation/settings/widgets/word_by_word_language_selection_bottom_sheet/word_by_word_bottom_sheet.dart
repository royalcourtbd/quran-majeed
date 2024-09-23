import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_available_items.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_downloaded_items.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_sticky_header.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_presenter.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_ui_state.dart';

class WordByWordBottomSheet extends StatelessWidget {
  WordByWordBottomSheet({super.key});
  final WordByWordPresenter presenter = locate();

  static Future<void> show(BuildContext context) async {
    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.transparent,
      builder: (_) => WordByWordBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        final WordByWordUiState uiState = presenter.currentUiState;
        return Stack(
          children: [
            ModalBarrier(
              color: Colors.transparent,
              dismissible: true,
              onDismiss: () => Navigator.of(context).pop(),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.2,
              maxChildSize: 0.95,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(twentyPx)),
                  ),
                  child: Column(
                    children: [
                      WordByWordStickyHeader(
                        title: context.l10n.wordByWordLanguage,
                        theme: theme,
                      ),
                      gapH10,
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            WordByWordDownloadedItems(
                              title: context.l10n.downloadedLanguage,
                              downloadedLanguages: uiState.downloadedLanguages,
                              selectedLanguage: uiState.selectedLanguage,
                              onLanguageSelected: ({required String name}) =>
                                  presenter.setSelectedLanguage(fileName: name),
                              onLanguageDelete: (
                                      {required String name}) async =>
                                  await presenter.deleteLanguage(
                                      fileName: name, context: context),
                              theme: theme,
                            ),
                            gapH22,
                            WordByWordAvailableItems(
                              title: context.l10n.availableLanguage,
                              items: uiState.availableLanguages,
                              downloadProgress: uiState.downloadProgress,
                              onLanguageDownload: ({required String name}) {
                                final WbwDbFileModel wbwFile =
                                    uiState.availableLanguages.firstWhere(
                                        (element) => element.name == name);
                                presenter.downloadLanguage(wbwFile: wbwFile);
                              },
                              theme: theme,
                              isDownloading: uiState.isDownloading,
                              activeDownloadId: uiState.activeDownloadId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
