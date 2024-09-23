import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:quran_majeed/core/external_libs/collection_data_structures.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/user_data_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/user_data_remote_data_source.dart';
import 'package:quran_majeed/data/mappers/bookmark/bookmark_mapper.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';

import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/use_cases/info/review_ask_count_service.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  UserDataRepositoryImpl(
    this._userDataLocalDataSource,
    this._userDataRemoteDataSource,
    this._reviewAskCountService,
  );

  final UserDataLocalDataSource _userDataLocalDataSource;
  final UserDataRemoteDataSource _userDataRemoteDataSource;

  @override
  Future<void> doneFirstTime() => _userDataLocalDataSource.doneFirstTime();

  @override
  Future<bool> determineFirstRun() async {
    final bool? shouldCountAsFirstTime = await catchAndReturnFuture(() async {
      final bool isFirstTime = await _userDataLocalDataSource.determineFirstRun();
      if (isFirstTime) return true;
      return false;
    });

    return shouldCountAsFirstTime ?? true;
  }

  @override
  Future<bool> needsMigration() async {
    final bool? needsMigration = await catchAndReturnFuture(() async {
      final bool isItReallyNeed = await _userDataLocalDataSource.needsMigration();
      if (isItReallyNeed) return true;
      return false;
    });

    return needsMigration ?? true;
  }

  // saveNeedsMigration
  @override
  Future<void> saveNeedsMigration() async {
    await _userDataLocalDataSource.saveNeedsMigration();
  }

  /// Bookmark related methods

  List<BookmarkFolderEntity> _allBookmarkFolders = [];

  @override
  Future<List<BookmarkEntity>> getAllBookmarks() async {
    final List<BookmarkEntity> allBookmarks = await _userDataLocalDataSource.getAllBookmarks();
    return allBookmarks;
  }

  // migrateOldBookmarks

  @override
  Future<void> migrateOldBookmarks() async {
    await _userDataLocalDataSource.migrateOldBookmarks();
  }

  @override
  Future<void> addAyahToBookmarkFolder({
    required BookmarkEntity bookmark,
    bool saveToRemote = true,
  }) async {
    await _userDataLocalDataSource.addAyahToBookmarkFolder(
      bookmark: bookmark,
      onBookmarkAdded: (bookmark) async => _userDataRemoteDataSource.addAyahToBookmarkFolder(bookmark: bookmark),
    );
  }

  @override
  Future<void> saveCollections({
    required List<BookmarkEntity> bookmarks,
  }) async {
    await Future.forEach(
      bookmarks,
      (bookmark) => catchFutureOrVoid(
        () => _userDataLocalDataSource.addAyahToBookmarkFolder(bookmark: bookmark),
      ),
    );
  }

  @override
  Future<void> deleteAyahFromBookmarks({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    await _userDataLocalDataSource.deleteAyahFromBookmarkFolder(
      surahID: surahID,
      ayahID: ayahID,
      folderName: folderName,
      onBookmarkDeleted: () async => _userDataRemoteDataSource.deleteAyahFromBookmark(
        surahID: surahID,
        ayahID: ayahID,
      ),
    );
  }

  @override
  Future<void> deleteBookmarkFolder({
    required BookmarkFolderEntity folder,
  }) async {
    await _userDataLocalDataSource.deleteBookmarkFolder(
      folderName: folder.name,
      onBookmarkFolderDeleted: () async => _userDataRemoteDataSource.deleteBookmarkFolder(folderName: folder.name),
    );
  }

  late final BookmarkFolderEntity favouriteFolder = BookmarkFolderEntity.favourites();

  @override
  Future<List<BookmarkFolderEntity>> getAllBookmarkFolders() async {
    final List<BookmarkFolderEntity> folders = await _userDataLocalDataSource.getAllBookmarkFolders();
    _allBookmarkFolders = folders;

    final bool needTodAddFavouriteFolder =
        _allBookmarkFolders.isEmpty || _allBookmarkFolders.firstWhereOrNull((b) => b.name == "Favourites") == null;
    if (needTodAddFavouriteFolder) _allBookmarkFolders.add(favouriteFolder);
    return _allBookmarkFolders;
  }

  @override
  Future<List<BookmarkEntity>> getAyahListByBookmarkFolder({required String folderName}) async {
    final List<BookmarkEntity> bookmarks =
        await _userDataLocalDataSource.getAyahListByBookmarkFolder(folderName: folderName);
    return bookmarks;
  }

  @override
  Future<BookmarkFolderEntity?> getBookmarkFolder({
    required String folderName,
  }) async {
    final BookmarkFolderEntity? bookmarkFolder =
        await _userDataLocalDataSource.getBookmarkFolder(folderName: folderName);
    return bookmarkFolder;
  }

  @override
  Future<List<BookmarkFolderEntity>> getBookmarkFolderBySurahAndAyah({
    required int surahID,
    required int ayahID,
  }) async {
    final List<BookmarkFolderEntity> bookmarkFolder = await _userDataLocalDataSource.getBookmarkFolderBySurahAndAyah(
      surahID: surahID,
      ayahID: ayahID,
    );
    return bookmarkFolder;
  }

  @override
  Future<void> updateBookmark({
    required String folderName,
    required String newFolderName,
    required Color color,
  }) async {
    await _userDataLocalDataSource.updateBookmarkFolderName(
      folderName: folderName,
      newFolderName: newFolderName,
      color: color,
      onBookmarkFolderUpdated: () async => _userDataRemoteDataSource.updateBookmarkFolderName(
        folderName: folderName,
        newFolderName: newFolderName,
        color: color,
      ),
    );
  }

  @override
  Future<List<BookmarkFolderEntity>> syncCollectionsWithRemote() async {
    final bool canSync = await _userDataLocalDataSource.needSync();

    if (!canSync) {
      return <BookmarkFolderEntity>[];
    }

    final List<BookmarkFolderEntity> syncedBookmarks = await _syncBookmarksWithRemote();

    return syncedBookmarks;
  }

  Future<List<BookmarkFolderEntity>> _syncBookmarksWithRemote() async {
    final List<BookmarkFolderEntity>? syncedBookmarks = await catchAndReturnFuture(() async {
      final List<BookmarkEntity> localBookmarks = await getAllBookmarks();
      final List<BookmarkEntity> remoteBookmarks = await _userDataRemoteDataSource.getSavedBookmarks();
      final List<BookmarkEntity> remoteBookmarksToBeSaved = await _filterOutSavingCapableBookmarks(
        existingBookmarks: remoteBookmarks,
        savingBookmarks: localBookmarks,
      );

      await _userDataRemoteDataSource.saveBookmarks(remoteBookmarksToBeSaved);

      final List<BookmarkEntity> localBookmarksToBeSaved = await _filterOutSavingCapableBookmarks(
        existingBookmarks: localBookmarks,
        savingBookmarks: remoteBookmarks,
      );

      await Future.forEach(
        localBookmarksToBeSaved,
        (bookmark) async => catchFutureOrVoid(
          () async => addAyahToBookmarkFolder(bookmark: bookmark, saveToRemote: false),
        ),
      );
      return getAllBookmarkFolders();
    });
    return syncedBookmarks ?? [];
  }

  Future<List<BookmarkEntity>> _filterOutSavingCapableBookmarks({
    required List<BookmarkEntity> existingBookmarks,
    required List<BookmarkEntity> savingBookmarks,
  }) async {
    final Pair<List<BookmarkEntity>, List<BookmarkEntity>> bookmarkPair = Pair(existingBookmarks, savingBookmarks);

    final List<BookmarkEntity> bookmarksToBeSaved = await bookmarkPair.findOutBookmarksToBeSaved();
    return bookmarksToBeSaved;
  }

  @override
  Future<void> saveBookmarksToAyah({
    required int surahID,
    required int ayahID,
    required List<BookmarkEntity> bookmarks,
  }) async {
    await _userDataLocalDataSource.saveBookmarksToSurahAndAyah(
      surahID: surahID,
      ayahID: ayahID,
      bookmarks: bookmarks,
      onBookmarksSaved: (bookmarks) async => _userDataRemoteDataSource.saveBookmarksToAyah(
        surahID: surahID,
        ayahID: ayahID,
        bookmarks: bookmarks,
      ),
    );
  }

  @override
  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required BookmarkFolderEntity folder,
  }) async {
    await _userDataLocalDataSource.deleteAyahFromBookmarkFolder(
      surahID: surahID,
      ayahID: ayahID,
      folderName: folder.name,
      onBookmarkDeleted: () => _userDataRemoteDataSource.deleteAyahFromBookmarkFolder(
        surahID: surahID,
        ayahID: ayahID,
        folderName: folder.name,
      ),
    );
  }

// Receives a pair of lists, one containing existing bookmarks and the other
// containing new bookmarks to be added.

  @override
  Future<List<LastReadEntity>> getLastReads() async {
    final List<LastReadEntity> lastReads = await _userDataLocalDataSource.getLastReads();
    return lastReads;
  }

  @override
  Future<void> saveLastRead({required LastReadEntity lastRead}) async {
    await _userDataLocalDataSource.addToLastReads(lastRead: lastRead);
  }

  @override
  Future<List<LastReadEntity>> deleteLastReads({required List<int> deletedItem}) async {
    return await _userDataLocalDataSource.deleteLastRead(deletedItem);
  }

  final ReviewAskCountService _reviewAskCountService;

  @override
  Future<bool> askForReviewIfAllowed({
    required VoidCallback askForReview,
  }) async {
    final bool? shown = await catchAndReturnFuture(() async {
      return _reviewAskCountService.askForReviewIfAllowed(
        askForReview: askForReview,
      );
    });
    return shown ?? false;
  }
}
