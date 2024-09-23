import 'dart:ui';

import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/entities/collections/sort_option_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

class CollectionUiState extends BaseUiState {
  CollectionUiState({
    required super.isLoading,
    required super.userMessage,
    required this.ayahcache,
    required this.bookmarkNoticeShown,
    required this.isGridView,
    required this.bookmarks,
    required this.isInputError,
    required this.selectedSort,
    required this.isAuthenticated,
    required this.bookmarkFolders,
    required this.selectedBookmarkFolderNames,
    required this.isSyncing,
    required this.checkBox,
    required this.isSelected,
    required this.isBookmarkChanged,
    required this.selectedColor,
     required this.filteredBookmarkFolders,
  });

  factory CollectionUiState.empty() => CollectionUiState(
        isLoading: false,
        userMessage: "",
        ayahcache: const {},
        bookmarkNoticeShown: true,
        isGridView: false,
        bookmarks: const [],
        isInputError: false,
        selectedSort: SortOptionEntity.options.first,
        isAuthenticated: false,
        bookmarkFolders: const [],
        selectedColor: const Color(0xffE57373),
        selectedBookmarkFolderNames: const {},
        filteredBookmarkFolders: const [] ,
        isSyncing: false,
        checkBox: false,
        isSelected: const {},
        isBookmarkChanged: false,
      );

  final List<BookmarkFolderEntity> bookmarkFolders;
  final List<BookmarkEntity> bookmarks;
  final Map<int, Map<int, List<WordByWordEntity>>> ayahcache;
  final bool isGridView;
  final bool isInputError;
  final bool bookmarkNoticeShown;
  final List<SortOptionEntity> sortOptions = SortOptionEntity.options;
  final SortOptionEntity? selectedSort;
  final Set<String> selectedBookmarkFolderNames;
  final List<BookmarkFolderEntity> filteredBookmarkFolders;
  final bool isAuthenticated;
  final bool isSyncing;
  final bool checkBox;
  final Set isSelected;
  final bool isBookmarkChanged;
  final Color selectedColor;

  @override
  List<Object?> get props => [
        bookmarkNoticeShown,
        isGridView,
        ayahcache,
        isInputError,
        filteredBookmarkFolders,
        bookmarks,
        selectedSort,
        sortOptions,
        isAuthenticated,
        userMessage,
        isLoading,
        bookmarkFolders,
        selectedBookmarkFolderNames,
        isSyncing,
        checkBox,
        isSelected,
        isBookmarkChanged,
        selectedColor,
      ];

  bool get askToSync => !isAuthenticated && bookmarkNoticeShown;

  CollectionUiState copyWith({
    bool? bookmarkNoticeShown,
    bool? isLoading,
    String? userMessage,
    bool? isGridView,
    bool? isInputError,
    List<BookmarkFolderEntity>? filteredBookmarkFolders,
    List<BookmarkEntity>? bookmarks,
    Map<int, Map<int, List<WordByWordEntity>>>? ayahcache,
    SortOptionEntity? selectedSort,
    bool? isAuthenticated,
    List<BookmarkFolderEntity>? bookmarkFolders,
    Set<String>? selectedBookmarkFolderNames,
    bool? isSyncing,
    bool? checkBox,
    Set? isSelected,
    bool? isBookmarkChanged,
    Color? selectedColor,
  }) {
    return CollectionUiState(
      bookmarkNoticeShown: bookmarkNoticeShown ?? this.bookmarkNoticeShown,
      filteredBookmarkFolders: filteredBookmarkFolders ?? this.filteredBookmarkFolders,
      isGridView: isGridView ?? this.isGridView,
      isInputError: isInputError ?? this.isInputError,
      ayahcache: ayahcache ?? this.ayahcache,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedSort: selectedSort ?? this.selectedSort,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      bookmarkFolders: bookmarkFolders ?? this.bookmarkFolders,
      selectedBookmarkFolderNames: selectedBookmarkFolderNames ?? this.selectedBookmarkFolderNames,
      isSyncing: isSyncing ?? this.isSyncing,
      checkBox: checkBox ?? this.checkBox,
      isSelected: isSelected ?? this.isSelected,
      isBookmarkChanged: isBookmarkChanged ?? this.isBookmarkChanged,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
