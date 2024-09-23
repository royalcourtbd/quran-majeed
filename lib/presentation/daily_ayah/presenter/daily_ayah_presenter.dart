import 'package:flutter/material.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/ayah_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/use_cases/notification/daily_ayah_use_case.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/daily_ayah/presenter/daily_ayah_ui_state.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class DailyAyahPresenter extends BasePresenter<DailyAyahUiState> {
  DailyAyahPresenter(this._getDailyAyahUseCase);
  final Obs<DailyAyahUiState> uiState = Obs(DailyAyahUiState.empty());
  DailyAyahUiState get currentUiState => uiState.value;

  final GetDailyAyahUseCase _getDailyAyahUseCase;
  final AyahPresenter _ayahPresenter = locate<AyahPresenter>();

  Future<void> fetchDailyAyah() async {
    final AyahDatabaseTableData result = await _getDailyAyahUseCase.execute();

    final List<WordByWordEntity> ayahWords = await _ayahPresenter.getWordsForSpecificAyah(
      result.surahId!,
      result.ayahID!,
    );
    uiState.value =
        currentUiState.copyWith(surahID: result.surahId, ayahID: result.ayahID, wordByWordEntity: ayahWords);
  }

  Future<void> shareAyah() async {
    final TranslationPresenter translationPresenter = locate<TranslationPresenter>();

    final String shareableString = await convertAyahToSharableString(
      surahID: currentUiState.surahID,
      ayahID: currentUiState.ayahID,
      listOfWordByWordEntity: currentUiState.wordByWordEntity!,
      surahName: CacheData.surahsCache[currentUiState.surahID - 1].nameEn,
      translatorName: translationPresenter.currentUiState.selectedItems.map((e) => e.name).toList(),
      translation: translationPresenter.currentUiState.selectedItems
          .map(
              (e) => translationPresenter.getTranslationText(e.fileName, currentUiState.surahID, currentUiState.ayahID))
          .toList(),
      shareWithArabicText: true,
      shareWithTranslation: true,
    );
    await shareText(text: shareableString);
  }

  @override
  Future<void> onInit() async {
    await fetchDailyAyah();
    super.onInit();
  }

  Future<void> onClickMoreButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    required bool isDirectButtonVisible,
    required bool isAddMemorizationButtonVisible,
    required bool idAddCollectionButtonVisible,
  }) async {
    await MoreOptionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      isDirectButtonVisible: isDirectButtonVisible,
      isAddMemorizationButtonVisible: isAddMemorizationButtonVisible,
      idAddCollectionButtonVisible: idAddCollectionButtonVisible,
      isFromBookmark: false,
    );
  }

  @override
  Future<void> addUserMessage(String message) {
    uiState.value = currentUiState.copyWith(errorMessage: message);
    return Future<void>.delayed(const Duration(milliseconds: 120), () {
      uiState.value = currentUiState.copyWith(errorMessage: "");
    });
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
