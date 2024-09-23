import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/throttle_service.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/entities/collections/sort_option_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/service/file_service.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/create_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/delete_ayah_from_bookmar_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/delete_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_all_bookmark_folders.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_ayah_list_by_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_bookmarks_by_surah_and_ayah.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/migrate_old_bookmarks_use_case.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/save_bookmarks_to_ayah.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/search_bookmark.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/sort_bookmark.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/update_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/check_authentication_status.dart';
import 'package:quran_majeed/domain/use_cases/collection/export_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/import_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/sign_in_user.dart';
import 'package:quran_majeed/domain/use_cases/collection/sign_out_user.dart';
import 'package:quran_majeed/domain/use_cases/collection/sync_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/validate_folder_name.dart';
import 'package:quran_majeed/domain/use_cases/info/needs_migration_use_case.dart';
import 'package:quran_majeed/domain/use_cases/info/save_needs_migration_use_case.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/ui/ayah_details_page.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/collection_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/create_new_collection_bottomsheet.dart';
import 'package:quran_majeed/presentation/bookmark_details/ui/bookmark_details_page.dart';

import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/components/import_export_bottom_sheet.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';

class CollectionPresenter extends BasePresenter<CollectionUiState> {
  CollectionPresenter(
    this._getAllBookmarkFoldersUseCase,
    this._getBookmarksBySurahAndAyahUseCase,
    this._validateBookmarkFolderNameUseCase,
    this._createBookmarkFolder,
    this._saveBookmarksToAyahUseCase,
    this._syncCollectionUseCase,
    this._deleteBookmarkFolder,
    this._updateBookmarkFolder,
    this._searchBookmarkUseCase,
    this._sortBookmarkUseCase,
    this._signInUser,
    this._signOutUser,
    this._checkAuthenticationStatus,
    this._getAyahListByBookmarkFolder,
    this._needsMigration,
    this._saveNeedsMigration,
    this._migrateOldBookmarks,
    this._importCollectionsUseCase,
    this._exportCollectionsUseCase,
    this._deleteAyahFromBookmarksUseCase,
  );

  final SyncCollectionUseCase _syncCollectionUseCase;
  final DeleteBookmarkFolderUseCase _deleteBookmarkFolder;
  final UpdateBookmarkFolderUseCase _updateBookmarkFolder;
  final SearchBookmarkUseCase _searchBookmarkUseCase;
  final TextEditingController folderNameEditingController =
      TextEditingController();
  late final FocusNode focusNode = FocusNode();

  final Obs<CollectionUiState> uiState = Obs(CollectionUiState.empty());

  final List<Color> _availableColors = const [
    Color(0xff66BB6A),
    Color(0xff7986CB),
    Color(0xff4FC3F7),
    Color(0xff4DB6AC),
    Color(0xff9CCC65),
    Color(0xffDCE775),
    Color(0xffFFB74D),
    Color(0xffFF8A65),
    Color(0xffBA68C8),
    Color(0xffF06292),
    Color(0xffE57373),
    Color(0xffBCAAA4),
    Color(0xff90A4AE),
  ];

  List<Color> get availableColors => _availableColors;

  CollectionUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    _fetchAllBookmarkFolders();
    super.onInit();
  }

  Future<void> fetchCollections() async {
    await fetchBookmarks();
  }

  Future<void> toggleColor({
    required Color color,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    uiState.value = currentUiState.copyWith(selectedColor: color);
  }

  List<BookmarkFolderEntity> _allBookmarkFolders = [];

  Future<void> fetchBookmarks() async {
    await parseDataFromEitherWithUserMessage(
      task: _getAllBookmarkFoldersUseCase.execute,
      onDataLoaded: (folders) {
        final List<BookmarkFolderEntity> bookmarkFolders =
            folders.toList(growable: true);
        _allBookmarkFolders = bookmarkFolders;
        uiState.value =
            currentUiState.copyWith(bookmarkFolders: bookmarkFolders);
        if (currentUiState.selectedSort != null) {
          _sortBookmarks(currentUiState.selectedSort!);
        }
      },
    );
  }

  SortOptionEntity? _lastOption;

  Future<void> sortCollections(SortOptionEntity option) async {
    if (_lastOption == option) return;
    _lastOption = option;
    await _sortBookmarks(option);
    uiState.refresh();
  }

  final SortBookmarkUseCase _sortBookmarkUseCase;

  Future<void> _sortBookmarks(SortOptionEntity option) async {
    await parseDataFromEitherWithUserMessage(
      task: () => _sortBookmarkUseCase.execute(
        folders: _allBookmarkFolders,
        option: option,
      ),
      onDataLoaded: (sortedFolders) {
        _allBookmarkFolders = sortedFolders;
        uiState.value = uiState.value.copyWith(
          selectedSort: option,
          bookmarkFolders: sortedFolders,
        );
        uiState.refresh();
      },
    );
  }

  Future<void> onClickNewCreate({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required CollectionPresenter presenter,
  }) async {
    await CreateNewCollectionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      presenter: presenter,
    );
  }

  final GetAllBookmarkFoldersUseCase _getAllBookmarkFoldersUseCase;

  Future<void> _fetchAllBookmarkFolders() async {
    await parseDataFromEitherWithUserMessage(
      task: _getAllBookmarkFoldersUseCase.execute,
      onDataLoaded: (folders) {
        final List<BookmarkFolderEntity> sortedFolders =
            folders.sortedBy((f) => f.createdAt).reversed.toList();
        uiState.value = currentUiState.copyWith(bookmarkFolders: sortedFolders);
      },
    );
  }

  Future<void> _toggleSyncingIndicator({bool toggle = true}) async {
    uiState.value = uiState.value.copyWith(isSyncing: toggle);
  }

  final DeleteAyahFromBookmarksUseCase _deleteAyahFromBookmarksUseCase;

  Future<void> removeAyahFromBookmark({
    required BookmarkEntity bookmark,
    required BuildContext context,
    required String foldername,
    required Function(int) onRemoveItem,
  }) async {
    final List<BookmarkEntity> ayahList = [...currentUiState.bookmarks];
    if (ayahList.isEmpty) return;

    final int index = ayahList
        .indexWhere((currentBookmark) => currentBookmark.id == bookmark.id);
    if (index <= -1) return;

    onRemoveItem(index);

    await Future.delayed(const Duration(milliseconds: 300));

    ayahList.removeAt(index);
    uiState.value = currentUiState.copyWith(bookmarks: ayahList);

    await _deleteAyahFromBookmarksUseCase.execute(
      surahID: bookmark.surahID,
      ayahID: bookmark.ayahID,
      folderName: foldername,
    );

    await _updateBookmarkCount(bookmark: bookmark);

    if (ayahList.isEmpty && context.mounted) {
      context.navigatorPop<bool>(result: true);
    }

    uiState.refresh();
  }

  Future<void> _updateBookmarkCount({required BookmarkEntity bookmark}) async {
    final List<BookmarkEntity> bookmarks = currentUiState.bookmarks;
    final int count = bookmarks
        .where((element) => element.folderName == bookmark.folderName)
        .length;
    final List<BookmarkFolderEntity> updatedFolders = currentUiState
        .bookmarkFolders
        .map((folder) => folder.name == bookmark.folderName
            ? folder.copyWith(count: count)
            : folder)
        .toList();
    final List<BookmarkEntity> updatedBookmarks = currentUiState.bookmarks
        .map((b) => b.folderName == bookmark.folderName
            ? b.copyWith(folderName: bookmark.folderName)
            : b)
        .toList();
    uiState.value = currentUiState.copyWith(
        bookmarkFolders: updatedFolders, bookmarks: updatedBookmarks);
  }

  Future<void> deleteBookmarkFolder({
    required BookmarkFolderEntity folder,
  }) async {
    await parseDataFromEitherWithUserMessage(
      task: () => _deleteBookmarkFolder.execute(folder: folder),
      onDataLoaded: (message) async {
        final List<BookmarkFolderEntity> bookmarks =
            currentUiState.bookmarkFolders.toList(growable: true)
              ..remove(folder);
        uiState.value = currentUiState.copyWith(bookmarkFolders: bookmarks);
        await fetchBookmarks();
        await addUserMessage(message);
      },
    );
  }

  String _lastBookmarkQuery = "";

  Future<void> searchBookmarks({required String query}) async {
    final String trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      uiState.value =
          currentUiState.copyWith(bookmarkFolders: _allBookmarkFolders);
    }

    if (trimmedQuery == _lastBookmarkQuery) return;
    await parseDataFromEitherWithUserMessage(
      task: () => _searchBookmarkUseCase.execute(
        query: trimmedQuery,
        allFolders: _allBookmarkFolders,
      ),
      onDataLoaded: (bookmarks) {
        uiState.value =
            currentUiState.copyWith(filteredBookmarkFolders: bookmarks);
      },
    );
    _lastBookmarkQuery = trimmedQuery;
  }

  void toggleGridView() {
    final bool isGridView = currentUiState.isGridView;
    uiState.value = currentUiState.copyWith(isGridView: !isGridView);
  }

  final GetAyahListByBookmarkFolder _getAyahListByBookmarkFolder;

  Future<void> fetchAyahListByBookmarkFolder({
    required String folderName,
  }) async {
    uiState.value = uiState.value.copyWith(isLoading: true);
    final AyahPresenter ayahPresenter = locate<AyahPresenter>();
    final Either<String, List<BookmarkEntity>> result =
        await _getAyahListByBookmarkFolder.execute(folderName);
    await result.fold(
      (errorMessage) async => addUserMessage(errorMessage),
      (bookmarks) async {
        Map<int, Map<int, List<WordByWordEntity>>> updatedAyahCache =
            Map.from(uiState.value.ayahcache);

        for (final bookmark in bookmarks) {
          final int surahNumber = bookmark.surahID;
          final int ayahNumber = bookmark.ayahID;

          if (!updatedAyahCache.containsKey(surahNumber)) {
            updatedAyahCache[surahNumber] = {};
          }

          if (!updatedAyahCache[surahNumber]!.containsKey(ayahNumber)) {
            final List<WordByWordEntity> words = await ayahPresenter
                .getWordsForSpecificAyah(surahNumber, ayahNumber);
            updatedAyahCache[surahNumber]![ayahNumber] = words;
          }
        }

        uiState.value = uiState.value.copyWith(
          bookmarks: bookmarks,
          ayahcache: updatedAyahCache,
          isLoading: false,
        );
      },
    );
  }

  Future<void> onBookmarkFolderClicked({
    required BookmarkFolderEntity folder,
    required BuildContext context,
    required TextEditingController editingController,
  }) async {
    await disposeKeyboard(
      context,
      editingController,
    );
    if (folder.isInvalid || folder.count == 0) {
      await showMessage(message: context.l10n.noBookmarkAdded);
      return;
    }

    await fetchAyahListByBookmarkFolder(folderName: folder.name);

    final BookmarkDetailsPage bookmarkDetailsPage =
        await Future.microtask(() => BookmarkDetailsPage(
              folderName: folder.name,
            ));
    if (context.mounted) await context.navigatorPush<bool>(bookmarkDetailsPage);
    focusNode.unfocus();
    await fetchBookmarks();
  }

  Future<void> fetchSelectedCollections({
    required int surahID,
    required int ayahID,
  }) async {
    await _fetchSelectedBookmarks(
      surahID: surahID,
      ayahID: ayahID,
    );
  }

  final GetBookmarksBySurahAndAyahUseCase _getBookmarksBySurahAndAyahUseCase;

  Future<void> _fetchSelectedBookmarks({
    required int surahID,
    required int ayahID,
  }) async {
    await parseDataFromEitherWithUserMessage(
      task: () async => _getBookmarksBySurahAndAyahUseCase.execute(
        surahID: surahID,
        ayahID: ayahID,
      ),
      onDataLoaded: (folders) {
        final Set<String> bookmarkFolderNames =
            folders.map((f) => f.name).toSet();
        uiState.value = currentUiState.copyWith(
          selectedBookmarkFolderNames: bookmarkFolderNames,
        );
      },
    );
  }

  final NeedsMigration _needsMigration;
  final SaveNeedsMigration _saveNeedsMigration;
  final MigrateOldBookmarks _migrateOldBookmarks;

  Future<void> migrateOldBookmarksIfNeeded() async {
    final bool needsMigration = await _needsMigration.execute();
    if (needsMigration) {
      await _migrateOldBookmarks.execute();
      await _saveNeedsMigration.execute();
      await fetchBookmarks(); // Refresh the bookmark list after migration
    }
  }

  bool _hasShownErrorToast = false;

  void validateInput(String value) {
    final bool isValid = RegExp(r'^[a-zA-Z0-9].*').hasMatch(value);
    uiState.value = currentUiState.copyWith(isInputError: !isValid);

    if (!isValid && !_hasShownErrorToast) {
      showMessage(message: "Input must start with a letter or number");
      _hasShownErrorToast = true;
    } else if (isValid) {
      _hasShownErrorToast = false;
    }
  }

  final ValidateFolderNameUseCase _validateBookmarkFolderNameUseCase;

  Future<void> addCollectionToAyah({
    required int surahID,
    required int ayahID,
    Color? color,
    VoidCallback? onSaved,
  }) async {
    final String purifiedName = folderNameEditingController.text.trim();
    final bool isValid = await _validateFolderName(
      name: purifiedName,
    );
    if (!isValid) return;

    final Color selectedColor = color ?? currentUiState.selectedColor;

    await _createBookmarkAndAddToAyah(
      name: purifiedName,
      surahID: surahID,
      ayahID: ayahID,
      color: selectedColor,
    );
    onSaved?.call();

    folderNameEditingController.clear();
  }

  Future<void> doneButtonHandler({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required void Function(int, {required bool isBookmarked}) onBookmarkToggled,
  }) async {
    await saveBookmarksForAyah(
      surahID: surahID,
      ayahID: ayahID,
      onSaved: (collectionId, {required bool isBookmarked}) {
        onBookmarkToggled(
          isBookmarked: isBookmarked,
          collectionId,
        );
        context.navigatorPop<void>();
      },
    );
  }

  void onNewCreateBottomSheetClosed(TabController tabController) {
    // final CollectionType collectionType = _presenter.currentUiState.selectedCollectionType;
    // final int collectionIndex = CollectionType.values.indexWhere(
    //   (collection) => collection.name == collectionType.name,
    // );
    // tabController?.animateTo(collectionIndex);
  }

  Future<void> _clearSelection() async {
    uiState.value = currentUiState.copyWith(
      selectedBookmarkFolderNames: {},
    );
  }

  Future<void> onCollectionClicked({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required AyahPresenter ayahPresenter,
  }) async {
    if (!context.mounted) return;
    await CollectionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      onBookmarkToggled: (
        count, {
        required bool isBookmarked,
      }) async {
        ayahPresenter.updateAyahDataWithBookmark(
          surahID: surahID,
          ayahID: ayahID,
          isBookmarked: isBookmarked,
          isMultiBookmarked: count > 1,
        );
        ayahPresenter.uiState.refresh();
      },
    );
  }

  Future<bool> _validateFolderName({
    required String name,
  }) async {
    bool isValid = true;
    final String purifiedName = name.trim();
    await parseDataFromEitherWithUserMessage(
      task: () async => _validateBookmarkFolderNameUseCase.execute(
        folderName: purifiedName,
      ),
      onDataLoaded: (validated) async => isValid = validated,
      valueOnError: false,
    );
    return isValid;
  }

  final CreateBookmarkFolderUseCase _createBookmarkFolder;

  Future<void> _createBookmarkAndAddToAyah({
    required String name,
    required int surahID,
    required int ayahID,
    required Color color,
  }) async {
    await executeMessageOnlyUseCase(
      () async => _createBookmarkFolder.execute(
        name: name,
        color: color,
        surahID: surahID,
        ayahID: ayahID,
      ),
    );
    await _fetchAllBookmarkFolders();
    await toggleBookmarkFolderToSelectedByName(name);
  }

  Future<void> goToAyahPageWithSurahAndAyahID({
    required BuildContext context,
    required int surahID,
    required int ayahID,
  }) async {
    final AyahDetailsPage ayahPage =
        await Future.microtask(() => AyahDetailsPage(
              initialPageIndex: surahID - 1,
              initialAyahIndex: ayahID - 1,
            ));
    if (context.mounted) await context.navigatorPush<void>(ayahPage);
  }

  Future<void> toggleBookmarkFolderToSelectedByName(String name) async {
    final Set<String> selectedBookmarkFolderNames =
        Set.from(currentUiState.selectedBookmarkFolderNames);
    selectedBookmarkFolderNames.contains(name)
        ? selectedBookmarkFolderNames.remove(name)
        : selectedBookmarkFolderNames.add(name);
    uiState.value = currentUiState.copyWith(
      selectedBookmarkFolderNames: selectedBookmarkFolderNames,
    );
  }

  Future<bool> updateBookmarkFolder({
    required BookmarkFolderEntity folder,
    required String newName,
    required Color newColor,
  }) async {
    final bool isValid = folder.name == newName ||
        await _validateFolderName(
          name: newName.trim(),
        );
    if (!isValid) return false;
    await executeMessageOnlyUseCase(
      () async => _updateBookmarkFolder.execute(
        folderName: folder.name.trim(),
        newFolderName: newName.trim(),
        color: newColor,
      ),
    );
    await fetchBookmarks();
    return true;
  }

  void closeBookmarkNotification() {
    uiState.value = currentUiState.copyWith(bookmarkNoticeShown: false);
  }

  final SaveBookmarksToAyahUseCase _saveBookmarksToAyahUseCase;

  Future<void> saveBookmarksForAyah({
    required int surahID,
    required int ayahID,
    required void Function(
      int, {
      required bool isBookmarked,
    }) onSaved,
  }) async {
    final Set<String> selectedBookmarkFolderNames =
        currentUiState.selectedBookmarkFolderNames;

    uiState.value = uiState.value
        .copyWith(isBookmarkChanged: selectedBookmarkFolderNames.isNotEmpty);

    final List<BookmarkFolderEntity> bookmarkFolders = currentUiState
        .bookmarkFolders
        .filter((f) => selectedBookmarkFolderNames.contains(f.name))
        .toList();

    final bool isBookmarkChanged = currentUiState.isBookmarkChanged;

    if (isBookmarkChanged) {
      await addUserMessage("Bookmark saved");
    }

    await executeMessageOnlyUseCase(
      () async => _saveBookmarksToAyahUseCase.execute(
        surahID: surahID,
        ayahID: ayahID,
        savingFolders: bookmarkFolders,
      ),
      onSuccess: () => onSaved(
        bookmarkFolders.length,
        isBookmarked: bookmarkFolders.isNotEmpty,
      ),
      showMessage: false,
    );

    await _clearSelection();
  }

  void toggleSelectionVisibility() {
    final bool newState = !currentUiState.checkBox;
    uiState.value = currentUiState.copyWith(
      checkBox: newState,
      isSelected: newState ? currentUiState.isSelected : {},
    );
  }

  void selectBookmarkItem(int index) {
    final isSelectedSet = Set<int>.from(currentUiState.isSelected);
    if (isSelectedSet.contains(index)) {
      isSelectedSet.remove(index);
    } else {
      isSelectedSet.add(index);
    }
    uiState.value = currentUiState.copyWith(isSelected: isSelectedSet);
  }

  // ############################################
  // ############# Authentication ###############
  // ############################################

  final SignInUserUseCase _signInUser;
  final SignOutUserUseCase _signOutUser;
  final CheckAuthenticationStatusUseCase _checkAuthenticationStatus;

  Future<void> _fetchAuthentication() async {
    uiState.value = currentUiState.copyWith(
      isAuthenticated: await _checkAuthenticationStatus.execute(),
    );
  }

  Future<void> toggleSignIn() async {
    Throttle.throttle("toggleSignIn_throttle_tag", 1.inSeconds, () async {
      final bool isAuthenticated = currentUiState.isAuthenticated;
      final Future<Either<String, String>> authenticationTask =
          isAuthenticated ? _signOutUser.execute() : _signInUser.execute();

      await executeMessageOnlyUseCase(() => authenticationTask);
      await Future<void>.delayed(560.inMilliseconds);

      await onCheckAuthentication(onAuthenticated: _syncAndFetchBookmarks);
    });
  }

  Future<void> onCheckAuthentication({
    required VoidCallback onAuthenticated,
    VoidCallback? onUnauthenticated,
  }) async {
    final bool isAuthenticated = await _checkAuthenticationStatus.execute();
    uiState.value = currentUiState.copyWith(isAuthenticated: isAuthenticated);
    isAuthenticated ? onAuthenticated() : onUnauthenticated?.call();
  }

  Future<void> _syncAndFetchBookmarks() async {
    await _toggleSyncingIndicator();
    await parseDataFromEitherWithUserMessage(
      task: _syncCollectionUseCase.execute,
      onDataLoaded: (collection) async {
        final List<BookmarkFolderEntity> bookmarkFolders = collection;
        _allBookmarkFolders = bookmarkFolders;
        uiState.value = currentUiState.copyWith(
          bookmarkFolders: bookmarkFolders,
        );
        await fetchBookmarks();
        await _toggleSyncingIndicator(toggle: false);
      },
    );
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  @override
  Future<void> addUserMessage(String message) async {
    showMessage(message: message);
  }

  ///
  /// Extra v2 features
  ///

  void togglePlayer() {
    // final bool isPlaying = currentUiState.isPlaying;
    // uiState.value = currentUiState.copyWith(isPlaying: !isPlaying);
  }

  Future<void> onClickBookmarkPageMoreButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    required String folderName,
    required BookmarkEntity bookmark,
    required bool isDirectButtonVisible,
    required bool isAddMemorizationButtonVisible,
    required bool idAddCollectionButtonVisible,
    required Function(int) onRemoveItem,
  }) async {
    await MoreOptionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      bookmark: bookmark,
      onBookmarkRemoved: (bookmark) async {
        await RemoveDialog.show(
          title: context.l10n.removeBookmark,
          context: context,
          onRemove: () => removeAyahFromBookmark(
            bookmark: bookmark,
            context: context,
            foldername: folderName,
            onRemoveItem: onRemoveItem,
          ),
        );
      },
      isDirectButtonVisible: isDirectButtonVisible,
      isAddMemorizationButtonVisible: isAddMemorizationButtonVisible,
      idAddCollectionButtonVisible: idAddCollectionButtonVisible,
      isFromBookmark: true,
    );
  }

  Future<void> onImportExportButtonClicked(BuildContext context) {
    return ImportExportBottomSheet.show(
      context: context,
      onImportSelected: _importCollections,
      onExportSelected: _exportCollections,
    );
  }

  late final FileService _fileService = locate();

  Future<void> _exportCollections() async => await fetchCollectionsForExport(
        onFetched: _fileService.saveTextContentToFile,
      );

  Future<void> _importCollections() async =>
      await _fileService.getContentFromTextFile(
        onContent: importCollectionsFromText,
      );

  final ExportCollectionsUseCase _exportCollectionsUseCase;

  Future<void> fetchCollectionsForExport({
    required void Function(String) onFetched,
  }) async {
    await parseDataFromEitherWithUserMessage(
      task: () async => await _exportCollectionsUseCase.execute(),
      onDataLoaded: onFetched,
    );
  }

  final ImportCollectionsUseCase _importCollectionsUseCase;

  Future<void> importCollectionsFromText(String text) async {
    await _toggleSyncingIndicator();
    await executeMessageOnlyUseCase(
      () async => await _importCollectionsUseCase.execute(text),
    );
    await fetchCollections();
    await _toggleSyncingIndicator(toggle: false);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    _fetchAuthentication();
    await migrateOldBookmarksIfNeeded()
        .then((_) async => await fetchBookmarks());
    _syncAndFetchBookmarks();
  }
}
