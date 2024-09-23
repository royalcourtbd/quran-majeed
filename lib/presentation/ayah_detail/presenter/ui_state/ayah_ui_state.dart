import 'package:flutter/material.dart';
import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

class AyahViewUiState extends BaseUiState {
  final Map<int, List<WordByWordEntity>> wordByWordListForSurah;
  final Map<int, Map<int, Map<String, bool>>> isBookmarkMap;
  final List<WordByWordEntity> wordByWordList;
  final int selectedSurahIndex;
  final int selectedAyahIndex;
  final bool autoScroll;
  final bool isAudioPlaying;
  final bool musafIsSelected;
  final int currentPageIndex;
  final List<BookmarkFolderEntity> bookmarkFolders;
  final bool showAppAndBottomBar;
  final bool isDisposedAfter3Second;
  final int ayahNumbers;
  final bool showArabic;
  final bool showTranslation;
  final double arabicFontSize;
  final double localFontSize;
  final double tafseerFontSize;
  final ArabicFontScript arabicFontScript;
  final ArabicFonts arabicFont;
  final bool showWordByWord;
  final double bottomNavigationBarHeight;

  const AyahViewUiState({
    required this.currentPageIndex,
    required this.isBookmarkMap,
    required super.isLoading,
    required super.userMessage,
    required this.bookmarkFolders,
    required this.showArabic,
    required this.showTranslation,
    required this.arabicFontSize,
    required this.localFontSize,
    required this.arabicFontScript,
    required this.arabicFont,
    required this.showWordByWord,
    required this.wordByWordListForSurah,
    required this.wordByWordList,
    required this.autoScroll,
    required this.isAudioPlaying,
    required this.musafIsSelected,
    required this.showAppAndBottomBar,
    required this.selectedSurahIndex,
    required this.selectedAyahIndex,
    required this.bottomNavigationBarHeight,
    this.isDisposedAfter3Second = true,
    required this.ayahNumbers,
    required this.tafseerFontSize,
  });

  factory AyahViewUiState.empty() {
    return const AyahViewUiState(
      currentPageIndex: 0,
      isBookmarkMap: {},
      isLoading: true,
      userMessage: null,
      bookmarkFolders: [],
      showArabic: true,
      showTranslation: true,
      arabicFontSize: 24,
      localFontSize: 15,
      arabicFontScript: ArabicFontScript.uthmani,
      arabicFont: ArabicFonts.kfgq,
      showWordByWord: false,
      wordByWordListForSurah: {},
      wordByWordList: [],
      autoScroll: false,
      isAudioPlaying: false,
      musafIsSelected: false,
      showAppAndBottomBar: true,
      isDisposedAfter3Second: false,
      selectedSurahIndex: 0,
      selectedAyahIndex: 0,
      ayahNumbers: 7,
      bottomNavigationBarHeight: kBottomNavigationBarHeight,
      tafseerFontSize: 15,
    );
  }

  @override
  List<Object?> get props => [
        currentPageIndex,
        isBookmarkMap,
        isLoading,
        userMessage,
        wordByWordListForSurah,
        wordByWordList,
        bookmarkFolders,
        autoScroll,
        isAudioPlaying,
        musafIsSelected,
        showAppAndBottomBar,
        isDisposedAfter3Second,
        selectedSurahIndex,
        selectedAyahIndex,
        ayahNumbers,
        showArabic,
        showTranslation,
        arabicFontSize,
        localFontSize,
        arabicFontScript,
        arabicFont,
        showWordByWord,
        bottomNavigationBarHeight,
        tafseerFontSize,
      ];

  AyahViewUiState copyWith({
    int? currentPageIndex,
    Map<int, Map<int, Map<String, bool>>>? isBookmarkMap,
    Map<int, List<WordByWordEntity>>? wordByWordListForSurah,
    List<WordByWordEntity>? wordByWordList,
    bool? isLoading,
    String? errorMessage,
    List<BookmarkFolderEntity>? bookmarkFolders,
    bool? autoScroll,
    bool? isAudioPlaying,
    bool? musafIsSelected,
    bool? showAppAndBottomBar,
    bool? isDisposedAfter3Second,
    int? selectedSurahIndex,
    int? selectedAyahIndex,
    int? ayahNumbers,
    bool? showArabic,
    bool? showTranslation,
    double? arabicFontSize,
    double? localFontSize,
    ArabicFontScript? arabicFontScript,
    ArabicFonts? arabicFont,
    bool? showWordByWord,
    double? bottomNavigationBarHeight,
    double? tafseerFontSize,
  }) {
    return AyahViewUiState(
      isBookmarkMap: isBookmarkMap ?? this.isBookmarkMap,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      wordByWordListForSurah:
          wordByWordListForSurah ?? this.wordByWordListForSurah,
      wordByWordList: wordByWordList ?? this.wordByWordList,
      isLoading: isLoading ?? this.isLoading,
      autoScroll: autoScroll ?? this.autoScroll,
      bookmarkFolders: bookmarkFolders ?? this.bookmarkFolders,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      userMessage: errorMessage ?? userMessage,
      musafIsSelected: musafIsSelected ?? this.musafIsSelected,
      showAppAndBottomBar: showAppAndBottomBar ?? this.showAppAndBottomBar,
      isDisposedAfter3Second:
          isDisposedAfter3Second ?? this.isDisposedAfter3Second,
      selectedSurahIndex: selectedSurahIndex ?? this.selectedSurahIndex,
      selectedAyahIndex: selectedAyahIndex ?? this.selectedAyahIndex,
      ayahNumbers: ayahNumbers ?? this.ayahNumbers,
      showArabic: showArabic ?? this.showArabic,
      showTranslation: showTranslation ?? this.showTranslation,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      localFontSize: localFontSize ?? this.localFontSize,
      arabicFontScript: arabicFontScript ?? this.arabicFontScript,
      arabicFont: arabicFont ?? this.arabicFont,
      showWordByWord: showWordByWord ?? this.showWordByWord,
      bottomNavigationBarHeight:
          bottomNavigationBarHeight ?? this.bottomNavigationBarHeight,
      tafseerFontSize: tafseerFontSize ?? this.tafseerFontSize,
    );
  }
}
