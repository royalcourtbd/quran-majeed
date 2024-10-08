import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/arabic_ayah_text_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/word_by_word_ayah_text_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/translation_text_widget.dart';
import 'package:quran_majeed/presentation/common/ayah_card/build_ayah_continer_top_row.dart';

import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_presenter.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_ui_state.dart';

class AyahContainer extends StatelessWidget {
  final int index;
  final int surahID;
  final int ayahNumber;
  final bool isFromTafseerPage;
  final List<WordByWordEntity> wordData;
  final Function() onClickMore;
  final AyahPresenter ayahPresenter;
  final ThemeData theme;
  final bool? isExpanded;
  final VoidCallback? onTapAyahCard;

  final String? ayahTopRowTitle;
  final bool? isFromSpecificPage;
  final bool isIconLeft;

  const AyahContainer({
    super.key,
    required this.index,
    required this.surahID,
    required this.ayahNumber,
    required this.wordData,
    required this.onClickMore,
    required this.ayahPresenter,
    required this.theme,
    this.isFromTafseerPage = false,
    this.ayahTopRowTitle,
    this.isFromSpecificPage = false,
    this.isIconLeft = false, // Default value

    this.onTapAyahCard,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBookmarked = ayahPresenter.currentUiState
            .isBookmarkMap[surahID]?[ayahNumber]?['isBookmarked'] ??
        false;
    final bool isMultiBookmarked = ayahPresenter.currentUiState
            .isBookmarkMap[surahID]?[ayahNumber]?['isMultiBookmarked'] ??
        false;

    late final WordByWordPresenter wordByWordPresenter = locate();
    return PresentableWidgetBuilder(
        presenter: ayahPresenter,
        builder: () {
          final AyahViewUiState uiState = ayahPresenter.currentUiState;
          final bool showArabic = uiState.showArabic;
          final bool showTranslation = uiState.showTranslation;
          final ArabicFontScript arabicFontScript = uiState.arabicFontScript;
          final double localFontSize = uiState.localFontSize;
          final double arabicFontSize = uiState.arabicFontSize;
          final String arabicFontName = uiState.arabicFont.name;

          final WordByWordUiState wordByWordUiState =
              wordByWordPresenter.currentUiState;

          return GestureDetector(
            onTap: onTapAyahCard,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: twentyPx,
                vertical: twelvePx,
              ),
              decoration: BoxDecoration(
                color: ayahPresenter.getAyahBackgroundColor(
                    theme, index, isFromSpecificPage!, isFromTafseerPage),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isExpanded!) ...[
                    BuildAyahContainerTopRow(
                      onTapMoreButton: onClickMore,
                      rowTitle: ayahTopRowTitle!,
                      theme: theme,
                      icon: isBookmarked
                          ? SvgImage(
                              isMultiBookmarked
                                  ? SvgPath.icBookmarkTwo
                                  : SvgPath.icBookmark,
                              width: sixteenPx,
                              height: sixteenPx,
                              color: theme.primaryColor,
                            )
                          : null,
                      isIconLeft: isIconLeft, // Pass the parameter
                    ),
                    gapH25,
                  ],
                  if (showArabic && !uiState.showWordByWord)
                    ArabicAyahTextWidget(
                      ayahNumber: ayahNumber,
                      wordData: wordData,
                      arabicFontScript: arabicFontScript,
                      arabicFontName: arabicFontName,
                      arabicFontSize: arabicFontSize,
                      theme: theme,
                    ),
                  if (uiState.showWordByWord &&
                      wordByWordUiState.selectedLanguage.isNotEmpty)
                    WordByWordAyahTextWidget(
                      wordData: wordData,
                      surahID: surahID,
                      ayahNumber: ayahNumber,
                      arabicFontScript: uiState.arabicFontScript,
                      arabicFontName: uiState.arabicFont.name,
                      arabicFontSize: uiState.arabicFontSize,
                      theme: theme,
                      localFontSize: uiState.localFontSize,
                    ),
                  gapH25,
                  if (showTranslation)
                    TranslationTextWidget(
                      surahID: surahID,
                      ayahNumber: ayahNumber,
                      localFontSize: localFontSize,
                      theme: theme,
                    ),
                ],
              ),
            ),
          );
        });
  }
}
