import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran_majeed/core/utility/scroll_controller_manager.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/ayah_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_all_bookmark_entries.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_all_bookmark_folders.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_words_for_surah.dart';
import 'package:quran_majeed/domain/use_cases/settings/listen_settings_changes.dart';
import 'package:quran_majeed/domain/use_cases/preload_adjacent_surahs.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_words_for_surah_ayah.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/data/sealed_classes/surah_ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/ui/ayah_details_page.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/advance_copy_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/audio_play_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/choose_musaf_mode_bottom_sheet.dart';
import 'package:quran_majeed/core/utility/ui_helper.dart';
import 'package:quran_majeed/presentation/grammar/ui/grammar_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/select_surah_ayah_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/multiple_ayah_share_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/share_ayah_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/share_image_bottom_sheet.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/tafseer/ui/tafseer_page.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

import '../../../domain/entities/last_read_entity.dart';
import '../../../domain/use_cases/user_data/save_last_read.dart';

class AyahPresenter extends BasePresenter<AyahViewUiState> {
  AyahPresenter(
    this._saveLastReadUseCase,
    this._listenSettingsChangesUseCase,
    this._getAllBookmarkFoldersUseCase,
    this._getWordsForSurah,
    this._preloadAdjacentSurahs,
    this._getAllBookmarkEntries,
    this._getWordsForSurahAyah,
  );
  final Obs<AyahViewUiState> uiState = Obs(AyahViewUiState.empty());
  AyahViewUiState get currentUiState => uiState.value;
  final PageController pageController = PageController();

  final SaveLastReadUseCase _saveLastReadUseCase;
  final ListenSettingsChangesUseCase _listenSettingsChangesUseCase;
  final GetWordsForSurah _getWordsForSurah;
  final GetWordsForSurahAyah _getWordsForSurahAyah;
  final PreloadAdjacentSurahs _preloadAdjacentSurahs;
  final GetAllBookmarkEntries _getAllBookmarkEntries;
  final AudioPresenter _audioPresenter = locate<AudioPresenter>();
  final TranslationPresenter translationPresenter =
      locate<TranslationPresenter>();

  final TextEditingController surahNameSearchController =
      TextEditingController();
  final TextEditingController ayahNumberSearchController =
      TextEditingController();

  Future<void> onClickPlayAyah(BuildContext context) async {
    await AudioPlayBottomSheet.show(
      context: context,
      isFromAyahDetail: true,
    );
    //onNewCreateBottomSheetClosed();
  }

  void setBottomNavigationBarHeight(double height) {
    uiState.value = currentUiState.copyWith(bottomNavigationBarHeight: height);
  }

  void updateCurrentPageIndex(int currentPageIndex) {
    uiState.value = currentUiState.copyWith(currentPageIndex: currentPageIndex);
  }

  Future<void> jumpToDesiredLocation({
    required int initialPageIndex,
    required int initialAyahIndex,
  }) async {
    if (pageController.hasClients) {
      pageController.jumpToPage(initialPageIndex);
    }
    await Future.delayed(700.milliseconds);
    final scrollController = getScrollController(initialPageIndex);
    if (scrollController.isAttached) {
      await scrollController.scrollTo(
        index: initialAyahIndex,
        duration: 500.milliseconds,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchSettingState();
    await loadAllBookmarkedAyahs();
  }

  Future<void> loadAllBookmarkedAyahs() async {
    await parseDataFromEitherWithUserMessage(
      task: () async => await _getAllBookmarkEntries.execute(),
      onDataLoaded: (bookmarks) {
        final Map<int, Map<int, Map<String, bool>>> newIsBookmarkMap = {};

        for (var bookmark in bookmarks) {
          if (newIsBookmarkMap[bookmark.surahID] == null) {
            newIsBookmarkMap[bookmark.surahID] = {};
          }
          if (newIsBookmarkMap[bookmark.surahID]![bookmark.ayahID] == null) {
            newIsBookmarkMap[bookmark.surahID]![bookmark.ayahID] = {};
          }
          newIsBookmarkMap[bookmark.surahID]![bookmark.ayahID]![
              'isBookmarked'] = true;
        }

        // Check for multi-bookmarks
        for (var surahId in newIsBookmarkMap.keys) {
          for (var ayahID in newIsBookmarkMap[surahId]!.keys) {
            final bookmarksForAyah = bookmarks
                .where((b) => b.surahID == surahId && b.ayahID == ayahID)
                .toList();
            newIsBookmarkMap[surahId]![ayahID]!['isMultiBookmarked'] =
                bookmarksForAyah.length > 1;
          }
        }

        uiState.value =
            currentUiState.copyWith(isBookmarkMap: newIsBookmarkMap);
      },
    );
  }

  Future<void> onTapAyahCard({
    required BuildContext context,
    required int surahID,
    required int ayahNumber,
  }) async {
    final TafseerPresenter tafseerPresenter = locate<TafseerPresenter>();
    await tafseerPresenter.initializeData(surahID: surahID);
    final TafseerPage tafseerPage = await Future.microtask(
      () => TafseerPage(
        surahID: surahID,
        ayahID: ayahNumber,
      ),
    );

    if (context.mounted) {
      await context.navigatorPush<void>(tafseerPage);
    } else if (QuranMajeed.globalContext.mounted) {
      await QuranMajeed.globalContext.navigatorPush<void>(tafseerPage);
    }
  }

  Future<void> onAyahMoreClicked({
    required BuildContext context,
    required SurahEntity surah,
    required int ayahNumber,
    required List<WordByWordEntity> wordByWordList,
  }) async {
    await onClickMoreButton(
      context: context,
      surahID: surah.serial,
      ayahID: ayahNumber,
      listOfWordByWordEntity: wordByWordList,
      isDirectButtonVisible: false,
      isAddMemorizationButtonVisible: true,
      isAddCollectionButtonVisible: true,
      isPlayButtonVisible: true,
      isCopyAyahButtonVisible: true,
    );
  }

  Future<void> toggleWordByWord({required bool showWordByWord}) async {
    uiState.value = currentUiState.copyWith(
      showWordByWord: showWordByWord,
      showArabic: !showWordByWord,
    );
    await _updateSettings();
  }

  Future<void> _updateSettings() async {
    final SettingsStateEntity currentSettings =
        await locate<SettingsRepository>().getSettingsState();
    final updatedSettings = currentSettings.copyWith(
      showWordByWord: currentUiState.showWordByWord,
      showArabic: currentUiState.showArabic,
    );
    await locate<SettingsRepository>()
        .updateSettings(settingsState: updatedSettings);
  }

  void _updateSettingsState(SettingsStateEntity settingState) {
    uiState.value = uiState.value.copyWith(
      arabicFontScript: settingState.arabicFontScript,
      arabicFontSize: settingState.arabicFontSize,
      localFontSize: settingState.localFontSize,
      showArabic: settingState.showArabic,
      arabicFont: settingState.arabicFont,
      showWordByWord: settingState.showWordByWord,
      showTranslation: settingState.showTranslation,
      tafseerFontSize: settingState.tafseerFontSize,
    );
  }

  StreamSubscription<Either<String, SettingsStateEntity>>? _settingsChangeSub;

  Future<void> fetchSettingState() async {
    final SettingsStateEntity settingsState =
        await locate<SettingsRepository>().getSettingsState();
    _updateSettingsState(settingsState);
    await handleStreamEvents(
      stream: _listenSettingsChangesUseCase.execute(),
      onData: _updateSettingsState,
      subscription: _settingsChangeSub,
    );
  }

  Future<void> goToAyahPageWithSurahAndAyahID({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    bool isNeedToPop = false,
  }) async {
    if (isNeedToPop) {
      context.navigatorPop();
    }
    final AyahDetailsPage ayahPage =
        await Future.microtask(() => AyahDetailsPage(
              initialPageIndex: surahID - 1,
              initialAyahIndex: ayahID - 1,
            ));
    if (context.mounted) await context.navigatorPush<void>(ayahPage);
  }

  Future<void> fetchAndSaveLastAyah() async {
    if (currentUiState.isDisposedAfter3Second) {
      await catchFutureOrVoid(() async {
        final int pageIndex = currentUiState.currentPageIndex;
        final int index =
            getItemPositionsListener(pageIndex).itemPositions.value.first.index;

        final LastReadEntity lastRead = LastReadEntity(
            ayahIndex: index + 1,
            surahIndex: pageIndex,
            surahName: CacheData.surahsCache[pageIndex].nameEn);
        await _saveLastReadUseCase.execute(lastRead: lastRead);
        uiState.value = currentUiState.copyWith(isDisposedAfter3Second: false);
      });
    }
  }

  final GetAllBookmarkFoldersUseCase _getAllBookmarkFoldersUseCase;

  Future<void> fetchBookmarkFolders() async {
    await parseDataFromEitherWithUserMessage(
      task: () async => await _getAllBookmarkFoldersUseCase.execute(),
      onDataLoaded: (folderList) =>
          uiState.value = uiState.value.copyWith(bookmarkFolders: folderList),
    );
  }

  Future<List<WordByWordEntity>> getWordsForSurah(int surahNumber) async {
    final result = await _getWordsForSurah.execute(surahNumber);
    return result.fold(
      (error) => [],
      (words) async {
        await _preloadAdjacentSurahs.execute(surahNumber);
        uiState.value = currentUiState.copyWith(
          wordByWordListForSurah: {
            ...currentUiState.wordByWordListForSurah,
            surahNumber: words,
          },
        );
        return words;
      },
    );
  }

  Color getAyahBackgroundColor(ThemeData theme, int index,
      bool isFromSpecificPage, bool isFromTafseerPage) {
    if (isFromTafseerPage) {
      return theme.scaffoldBackgroundColor;
    }

    final bool isOddIndex = index.isOdd;
    final Color baseColor = theme.scaffoldBackgroundColor;
    final Color altColor = theme.cardColor.withOpacity(0.5);

    return (isFromSpecificPage == isOddIndex) ? baseColor : altColor;
  }

  Future<List<WordByWordEntity>> getWordsForSpecificAyah(
      int surahNumber, int ayahNumber) async {
    final Either<String, List<WordByWordEntity>> result =
        await _getWordsForSurahAyah.execute(surahNumber, ayahNumber);
    return result.fold(
      (error) => [],
      (words) {
        return words;
      },
    );
  }

  Future<void> updateAyahDataWithBookmark({
    required int surahID,
    required int ayahID,
    required bool isBookmarked,
    required bool isMultiBookmarked,
  }) async {
    final updatedIsBookmarkMap = Map<int, Map<int, Map<String, bool>>>.from(
        currentUiState.isBookmarkMap);

    if (updatedIsBookmarkMap[surahID] == null) {
      updatedIsBookmarkMap[surahID] = {};
    }

    updatedIsBookmarkMap[surahID]![ayahID] = {
      'isBookmarked': isBookmarked,
      'isMultiBookmarked': isMultiBookmarked,
    };

    uiState.value =
        currentUiState.copyWith(isBookmarkMap: updatedIsBookmarkMap);
  }

  (bool, bool) checkAyahBookmarkStatus(int surahID, int ayahID) {
    final surahBookmarks = currentUiState.isBookmarkMap[surahID];
    if (surahBookmarks == null) return (false, false);

    final ayahBookmark = surahBookmarks[ayahID];
    if (ayahBookmark == null) return (false, false);

    return (
      ayahBookmark['isBookmarked'] ?? false,
      ayahBookmark['isMultiBookmarked'] ?? false,
    );
  }

  String getSurahName(BuildContext context) {
    String currentLanguage = getCurrentLanguage(context);
    if (currentLanguage == 'bn') {
      return CacheData.surahsCache[currentUiState.currentPageIndex].nameBn;
    } else if (currentLanguage == 'ar') {
      return CacheData.surahsCache[currentUiState.currentPageIndex].name;
    } else {
      return CacheData.surahsCache[currentUiState.currentPageIndex].nameEn;
    }
  }

  Future<void> initializeAyahDetailsPage({
    required int initialPageIndex,
    required int initialAyahIndex,
  }) async {
    await UiHelper.doOnPageLoaded(() async {
      await jumpToDesiredLocation(
        initialPageIndex: initialPageIndex,
        initialAyahIndex: initialAyahIndex,
      );

      _audioPresenter.initializePositionListener();
      await _setIsDisposedAfter3Second();
      uiState.value = currentUiState.copyWith(
        currentPageIndex: initialPageIndex,
        selectedSurahIndex: initialPageIndex,
        selectedAyahIndex: initialAyahIndex,
      );
    });
  }

  String formatHijbNumber(String hijb) {
    final List<String> hijbFractioned = hijb.split('.');
    final String hijbFirstPart = hijbFractioned.first;
    final String hijbLastPart = hijbFractioned.last;
    String? formattedHijbNumber;
    switch (hijbLastPart) {
      case '25':
        formattedHijbNumber = '$hijbFirstPart¼';
        break;
      case '5':
        formattedHijbNumber = '$hijbFirstPart½';
        break;
      case '75':
        formattedHijbNumber = '$hijbFirstPart¾';
        break;
      default:
        formattedHijbNumber = hijb;
    }
    return formattedHijbNumber;
  }

  Future<void> _setIsDisposedAfter3Second() async {
    await Future<void>.delayed(3.seconds);
    uiState.value = currentUiState.copyWith(isDisposedAfter3Second: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  ItemScrollController getScrollController(int pageIndex) {
    return ScrollControllerManager().getScrollController(pageIndex);
  }

  ItemPositionsListener getItemPositionsListener(int pageIndex) {
    return ScrollControllerManager().getItemPositionsListener(pageIndex);
  }

  Future<void> onMusafModeTap(BuildContext context) async {
    await ChooseMusafModeBottomSheet.show(context: context);
  }

  void updateWordByWordData(int ayahNumber) async {
    uiState.value = currentUiState.copyWith(
        wordByWordList: currentUiState.wordByWordListForSurah[ayahNumber]);
  }

  Future<void> onClickMoreButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    required bool isDirectButtonVisible,
    required bool isAddMemorizationButtonVisible,
    required bool isAddCollectionButtonVisible,
    required bool isPlayButtonVisible,
    required bool isCopyAyahButtonVisible,
  }) async {
    await MoreOptionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      isDirectButtonVisible: false,
      isAddMemorizationButtonVisible: true,
      idAddCollectionButtonVisible: true,
      isPlayButtonVisible: isPlayButtonVisible,
      isCopyAyahButtonVisible: isCopyAyahButtonVisible,
    );
  }

  Future<void> onSurahListTap({
    required BuildContext context,
    required String title,
    required bool isDoneButtonEnabled,
    required bool isJumpToAyahBottomSheet,
    required Function(int surahId) onSurahSelected,
    required Function(int ayahId) onAyahSelected,
    required Function() onSubmit,
  }) async {
    uiState.value = currentUiState.copyWith(
        selectedSurahIndex: pageController.page!.round());
    await SelectSurahAyahBottomSheet.show(
      context: context,
      bottomSheetTitle: title,
      presenter: SurahAyahPresenter.ayah(locate<AyahPresenter>()),
      isDoneButtonEnabled: isDoneButtonEnabled,
      isJumpToAyahBottomSheet: isJumpToAyahBottomSheet,
      onSurahSelected: onSurahSelected,
      onAyahSelected: onAyahSelected,
      onJumpToTafseer: () async => await goToTafseerPage(
        context: context,
        surahID: currentUiState.selectedSurahIndex + 1,
        ayahID: currentUiState.selectedAyahIndex + 1,
      ),
      onSubmit: onSubmit,
    );
  }

  void onSelectSurah(int surahIndex) {
    final int ayahNumbers = CacheData.surahsCache[surahIndex].totalAyah;
    _audioPresenter.onSelectSurah(surahIndex);
    uiState.value = currentUiState.copyWith(
      selectedSurahIndex: surahIndex,
      ayahNumbers: ayahNumbers,
      selectedAyahIndex: 0,
    );
  }

  Future<void> goToTafseerPage({
    required BuildContext context,
    required int surahID,
    required int ayahID,
  }) async {
    await getWordsForSurah(currentUiState.selectedSurahIndex + 1);
    if (context.mounted) {
      await onTapAyahCard(
        context: context,
        surahID:
            CacheData.surahsCache[currentUiState.selectedSurahIndex].serial,
        ayahNumber: currentUiState.selectedAyahIndex + 1,
      );
    }
  }

  void onSelectAyah(int ayahIndex) {
    uiState.value = currentUiState.copyWith(
      selectedAyahIndex: ayahIndex,
    );
  }

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

//TODO: Implement this function
  Future<void> showWordGrammarBottomSheet(BuildContext context,
      List<WordByWordEntity> wordList, int selectedWordIndex) async {
    await GrammarBottomSheet.show(
      context: context,
      wordList: wordList,
      selectedWordIndex: selectedWordIndex,
    );
    // onNewCreateBottomSheetClosed();
  }

  void toggleAutoScroll() {
    uiState.value =
        currentUiState.copyWith(autoScroll: !currentUiState.autoScroll);
  }

  Future<void> onClickAdvanceCopy(BuildContext context, ThemeData theme) async {
    await AdvanceCopyBottomSheet.show(
      context: context,
      theme: theme,
    );
    //onNewCreateBottomSheetClosed();
  }

  Future<void> onClickShareButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
  }) async {
    await ShareAyahBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
    );
  }

  Future<String> _makeShareableString({
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
  }) async {
    return await convertAyahToSharableString(
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      surahName: CacheData.surahsCache[surahID - 1].nameEn,
      translatorName: translationPresenter.currentUiState.selectedItems
          .map((e) => e.name)
          .toList(),
      translation: translationPresenter.currentUiState.selectedItems
          .map((e) => translationPresenter.getTranslationText(
              e.fileName, surahID, ayahID))
          .toList(),
      shareWithArabicText: true,
      shareWithTranslation: true,
    );
  }

  Future<void> copySingleAyahText({
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
  }) async {
    final String shareableString = await _makeShareableString(
        surahID: surahID,
        ayahID: ayahID,
        listOfWordByWordEntity: listOfWordByWordEntity);
    copyText(text: shareableString);
    addUserMessage('Ayah copied to clipboard');
  }

  Future<void> shareSingleAyahText({
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
  }) async {
    final String shareableString = await _makeShareableString(
        surahID: surahID,
        ayahID: ayahID,
        listOfWordByWordEntity: listOfWordByWordEntity);
    await shareText(text: shareableString);
  }

  Future<void> onClickMultipleAyahShareButton(BuildContext context) async {
    await MultipleAyahShareBottomSheet.show(
      context: context,
    );
  }

  Future<void> onClickShareImageButton(BuildContext context) async {
    await ShareImageBottomSheet.show(
      context: context,
    );
  }
}
