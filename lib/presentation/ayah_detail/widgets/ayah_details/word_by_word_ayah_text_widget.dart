import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_presenter.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_ui_state.dart';

class WordByWordAyahTextWidget extends StatelessWidget {
  const WordByWordAyahTextWidget({
    super.key,
    required this.wordData,
    required this.arabicFontScript,
    required this.arabicFontName,
    required this.arabicFontSize,
    required this.theme,
    required this.localFontSize,
    required this.surahID,
    required this.ayahNumber,
  });

  final List<WordByWordEntity> wordData;
  final ArabicFontScript arabicFontScript;
  final String arabicFontName;
  final double arabicFontSize;
  final ThemeData theme;
  final double localFontSize;
  final int surahID;
  final int ayahNumber;

  @override
  Widget build(BuildContext context) {
    final WordByWordPresenter wordByWordPresenter = locate();

    return PresentableWidgetBuilder(
      presenter: wordByWordPresenter,
      builder: () {
        final WordByWordUiState wordByWordUiState =
            wordByWordPresenter.currentUiState;
        final String selectedLanguage = wordByWordUiState.selectedLanguage;

        return Align(
          alignment: Alignment.centerRight,
          child: Wrap(
            textDirection: TextDirection.rtl,
            runSpacing: 10,
            spacing: twentyPx,
            alignment: WrapAlignment.start,
            children: List.generate(
              wordData.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    arabicFontScript == ArabicFontScript.uthmani
                        ? wordData[index].uthmani!
                        : wordData[index].indopak!,
                    textDirection: TextDirection.rtl,
                    style: context.quranText.arabicAyah!.copyWith(
                      fontFamily: arabicFontName,
                      fontSize: arabicFontSize,
                    ),
                  ),
                  gapH5,
                  Text(
                    _getTranslation(wordData[index], selectedLanguage, surahID,
                        ayahNumber, index),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: localFontSize,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTranslation(WordByWordEntity word, String selectedLanguage,
      int surahID, int ayahNumber, int wordID) {
    switch (selectedLanguage) {
      case 'English':
        return word.en!;
      case 'Bangla':
        return word.bn!;
      default:
        return CacheData
                .wordByWordCache[selectedLanguage]?[surahID]?[ayahNumber]
                    ?[wordID]
                .translation ??
            '';
    }
  }
}
