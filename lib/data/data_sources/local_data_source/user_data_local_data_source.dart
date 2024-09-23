import 'dart:convert';
import 'dart:ui';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/bookmark/bookmark_mapper.dart';
import 'package:quran_majeed/data/mappers/setting_entity_mapper.dart';
import 'package:quran_majeed/data/service/database/collection/user_data_storage.dart';

import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';

import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:synchronized/synchronized.dart';

import '../../../domain/entities/last_read_entity.dart';

class UserDataLocalDataSource {
  UserDataLocalDataSource(
    this._localCacheService,
    this._userDataStorage,
  );

  final LocalCacheService _localCacheService;
  final UserDataStorage _userDataStorage;

  Future<void> saveSettingState({
    required SettingsStateEntity settingsState,
  }) async {
    await catchFutureOrVoid(() async {
      final String settingsStateSerialised =
          await settingsState.toSerialisedString();
      await _localCacheService.saveData(
        key: CacheKeys.settingsState,
        value: settingsStateSerialised,
      );
    });
  }

  Future<void> migrateOldBookmarks() async {
    try {
      final String? bookmarkJsonContent =
          await _localCacheService.getOldBookmarkJsonFile();
      if (bookmarkJsonContent == null) return; // No old bookmarks to migrate

      final List<dynamic> oldBookmarks = json.decode(bookmarkJsonContent);
      final Set<String> processedBookmarks = <String>{};

      for (final oldBookmark in oldBookmarks) {
        final String folderName = oldBookmark['name'] ?? 'Migrated Bookmarks';
        final List<dynamic> items = oldBookmark['items'] ?? [];

        for (final item in items) {
          final int surahID = item['sura'] ?? 0;
          final int ayahID = item['aya'] ?? 0;

          // Check for duplicates
          final String bookmarkKey = '$surahID-$ayahID-$folderName';
          if (processedBookmarks.contains(bookmarkKey)) continue;
          processedBookmarks.add(bookmarkKey);

          await addAyahToBookmarkFolder(
            bookmark: BookmarkEntity(
              folderName: folderName,
              color: const Color(0xff17B686), // Old folder color
              surahID: surahID,
              ayahID: ayahID,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        }
      }
    } catch (error) {
      showMessage(message: error.toString());
    }
    // Clear old bookmarks after migration
    // Note: You might want to keep the old data for a while in case of migration issues
    // await _localCacheService.saveData(key: 'bookmark', value: null);
  }

  Future<bool> determineFirstRun() async {
    final bool? firstTime =
        _localCacheService.getData(key: CacheKeys.firstTime);
    return firstTime ?? true;
  }

  Future<bool> needsMigration() async {
    return _localCacheService.getData<bool>(
            key: CacheKeys.retrievedPreviousBookmarks) ??
        true;
  }

  Future<void> saveNeedsMigration() async {
    return _localCacheService.saveData(
        key: CacheKeys.retrievedPreviousBookmarks, value: false);
  }

  Future<SettingsStateEntity> getSettingState() async {
    final SettingsStateEntity? settingState =
        await catchAndReturnFuture(() async {
      final String? settingsStateSerialised =
          _localCacheService.getData(key: CacheKeys.settingsState);
      if (settingsStateSerialised == null) return SettingsStateEntity.empty();
      final SettingsStateEntity settingsState =
          await settingsStateSerialised.toSettingStateEntity();

      return settingsState;
    });
    return settingState ?? SettingsStateEntity.empty();
  }

  Future<void> doneFirstTime() async {
    await _localCacheService.saveData(key: CacheKeys.firstTime, value: false);
  }

  Future<List<BookmarkEntity>> getAllBookmarks() async {
    final List<BookmarkData?> bookmarkDtoList =
        await _userDataStorage.allBookmarks;
    final List<BookmarkEntity> allBookmarks =
        await bookmarkDtoList.toBookmarkEntities();
    return allBookmarks;
  }

  late final Lock _addHAyahToBookmarkLock = Lock();

  Future<void> addAyahToBookmarkFolder({
    required BookmarkEntity bookmark,
    void Function(BookmarkEntity)? onBookmarkAdded,
  }) async {
    await _addHAyahToBookmarkLock.synchronized(() async {
      await _validateBookmarkInThisFolderIsBookmarkedOnce(bookmark);
      final String hexColor = getHexFromColor(bookmark.color);
      // here we are getting the bookmark id, the db is saving the bookmark with
      // this is very important, to track the unique id across devices,
      // and installations, so that we don't save the same bookmark twice.
      final int bookmarkId = await _userDataStorage.addAyahToBookmarkFolder(
        folderName: bookmark.folderName,
        surahID: bookmark.surahID,
        ayahID: bookmark.ayahID,
        color: hexColor,
      );
      onBookmarkAdded?.call(bookmark.withId(bookmarkId));
    });
  }

  Future<void> _validateBookmarkInThisFolderIsBookmarkedOnce(
    BookmarkEntity bookmark,
  ) async {
    final BookmarkData? bookmarkOfAyahOnSameFolder =
        await _userDataStorage.getBookmarksOfSameFolderWithSameAyah(
      folderName: bookmark.folderName,
      surahID: bookmark.surahID,
      ayahID: bookmark.ayahID,
    );
    final bool alreadyBookmarkedInSameFolder =
        bookmarkOfAyahOnSameFolder != null;

    if (alreadyBookmarkedInSameFolder) {
      logError(bookmark);
      throw Exception("This Ayah is already bookmarked in this folder");
    }
  }

  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required String folderName,
    required VoidCallback onBookmarkDeleted,
  }) async {
    await _userDataStorage.deleteAyahFromBookmarkFolder(
      surahID: surahID,
      ayahID: ayahID,
      folderName: folderName,
    );
    onBookmarkDeleted();
  }

  Future<void> deleteBookmarkFolder({
    required String folderName,
    required void Function() onBookmarkFolderDeleted,
  }) async {
    await _userDataStorage.deleteBookmarkFolderByName(folderName: folderName);
    onBookmarkFolderDeleted();
  }

  Future<List<BookmarkFolderEntity>> getAllBookmarkFolders() async {
    final List<BookmarkData> bookmarkDtoList =
        await _userDataStorage.allBookmarks;
    final List<BookmarkFolderEntity> bookmarkFolders =
        await bookmarkDtoList.groupBookmarksInFolders();
    return bookmarkFolders;
  }

  // getAyahListByBookmarkFolder

  Future<List<BookmarkEntity>> getAyahListByBookmarkFolder({
    required String folderName,
  }) async {
    final List<BookmarkData?> bookmarkDtoList =
        await _userDataStorage.getBookmarksByFolderName(folderName: folderName);
    final List<BookmarkEntity> bookmarkEntities =
        await bookmarkDtoList.toBookmarkEntities();
    return bookmarkEntities;
  }

  Future<BookmarkFolderEntity?> getBookmarkFolder({
    required String folderName,
  }) async {
    final List<BookmarkData?> bookmarkDtoList =
        await _userDataStorage.getBookmarksByFolderName(folderName: folderName);
    if (bookmarkDtoList.isEmpty) return null;

    final int folderId = DateTime.now().microsecond;

    final (folderCreatedAt, folderUpdatedAt) = await compute(
      getBookmarkFolderCreatedAndUpdatedTime,
      bookmarkDtoList,
    );

    final Color folderColor =
        await getColorFromHexAsync(bookmarkDtoList.first!.color);

    // count total number of bookmarks in the folder
    final int totalBookmarks = bookmarkDtoList.length;

    return BookmarkFolderEntity(
      id: folderId,
      name: folderName,
      color: folderColor,
      count: totalBookmarks,
      updatedAt: folderUpdatedAt,
      createdAt: folderCreatedAt,
    );
  }

  Future<List<BookmarkFolderEntity>> getBookmarkFolderBySurahAndAyah({
    required int surahID,
    required int ayahID,
  }) async {
    final List<BookmarkData> bookmarkData = await _userDataStorage
        .getBookmarkFolderBySurahAndAyah(surahID: surahID, ayahID: ayahID);

    if (bookmarkData.isEmpty) {
      return []; // Return an empty list if no bookmarks are found
    }

    final Color folderColor =
        await getColorFromHexAsync(bookmarkData.first.color);

    // count total number of bookmarks in the folder
    final int totalBookmarks = bookmarkData.length;
    final (folderCreatedAt, folderUpdatedAt) =
        getBookmarkFolderCreatedAndUpdatedTime(bookmarkData);

    return bookmarkData
        .map((bookmark) => BookmarkFolderEntity(
              id: bookmark.id,
              name: bookmark.foldername,
              color: folderColor,
              count: totalBookmarks,
              updatedAt: folderUpdatedAt,
              createdAt: folderCreatedAt,
            ))
        .toList();
  }

  Future<void> saveBookmarksToSurahAndAyah({
    required int surahID,
    required int ayahID,
    required List<BookmarkEntity> bookmarks,
    required void Function(List<BookmarkEntity>) onBookmarksSaved,
  }) async {
    await _deleteAllPreviousBookmarksOfSurahAndAyah(
      surahID: surahID,
      ayahID: ayahID,
    );
    final List<BookmarkEntity> savedBookmarks = List.empty(growable: true);
    await Future.forEach(
      bookmarks,
      (bookmark) async => catchFutureOrVoid(
        () => addAyahToBookmarkFolder(
          bookmark: bookmark,
          onBookmarkAdded: savedBookmarks.add,
        ),
      ),
    );
    onBookmarksSaved(savedBookmarks);
  }

  Future<void> _deleteAllPreviousBookmarksOfSurahAndAyah({
    required int surahID,
    required int ayahID,
  }) async {
    await _userDataStorage.deleteAllBookmarksOfSurahAndAyah(
      surahID: surahID,
      ayahID: ayahID,
    );
  }

  Future<void> updateBookmarkFolderName({
    required String folderName,
    required String newFolderName,
    required Color color,
    required void Function() onBookmarkFolderUpdated,
  }) async {
    await _userDataStorage.updateBookmarkFolderName(
      folderName: folderName,
      newFolderName: newFolderName,
      color: getHexFromColor(color),
    );
    onBookmarkFolderUpdated();
  }

  Future<bool> needSync() async {
    final bool? needsSync = await catchAndReturnFuture(() async {
      final bool isConnectedToInternet = await checkInternetConnection();
      if (!isConnectedToInternet) return false;

      final int? lastSyncDateInMs =
          _localCacheService.getData<int>(key: CacheKeys.lastSyncDate);
      final DateTime lastSyncDate = DateTime(lastSyncDateInMs ?? 0);

      final DateTime currentDate = DateTime.now();

      final Duration timeDifference = lastSyncDate.difference(currentDate);

      return timeDifference.inDays != 0;
    });
    return needsSync ?? true;
  }

  // Asynchronously retrieves the last read entities.
  Future<List<LastReadEntity>> getLastReads() async {
    // Retrieve the cached last read data from local storage.
    final String? lastReadCachedDate =
        _localCacheService.getData(key: CacheKeys.lastReads);

    // Parse the cached data into a list of LastReadEntity objects.
    return lastReadCachedDate != null
        ? mLastReadFromJson(lastReadCachedDate)
        : [];
  }

  // Asynchronously adds a LastReadEntity to the last reads list.
  Future<void> addToLastReads({required LastReadEntity lastRead}) async {
    // Retrieve the current list of last read entities from local storage.
    List<LastReadEntity> cachedLastRead = await getLastReads();

    // Check if the given LastReadEntity already exists in the list.
    final existingIndex =
        cachedLastRead.indexWhere((lr) => lr.surahIndex == lastRead.surahIndex);

    // Update the existing LastReadEntity if found, or add the new LastReadEntity to the list if space is available.
    if (existingIndex >= 0) {
      cachedLastRead.removeAt(existingIndex);
      cachedLastRead.add(lastRead);
    } else if (cachedLastRead.length < 10) {
      // Limit the list size to 10
      cachedLastRead.add(lastRead);
    } else {
      cachedLastRead.removeAt(0);
      cachedLastRead.add(lastRead);
    }

    // Save the updated last reads list to local storage.
    await _localCacheService.saveData(
      key: CacheKeys.lastReads,
      value: mLastReadToJson(cachedLastRead),
    );
  }

  Future<List<LastReadEntity>> deleteLastRead(List<int> lastReads) async {
    // Retrieve the cached last read data from local storage.
    final String? lastReadCachedData =
        _localCacheService.getData(key: CacheKeys.lastReads);

    // Parse the cached data into a list of LastReadEntity objects.
    // If the cached data is null, create an empty list.
    final parsedLastRead = lastReadCachedData != null
        ? mLastReadFromJson(lastReadCachedData)
        : <LastReadEntity>[];

    // If the number of indices to be removed is equal to the number of LastReadEntity objects,
    // clear the entire list.
    if (lastReads.length == parsedLastRead.length) {
      parsedLastRead.clear();
    } else {
      // Create a list of surahIndex values corresponding to the indices to be removed.
      final deletedList =
          lastReads.map((index) => parsedLastRead[index].surahIndex).toList();

      // Remove LastReadEntity objects from the list where the surahIndex matches the values in deletedList.
      parsedLastRead
          .removeWhere((item) => deletedList.contains(item.surahIndex));
    }

    // Save the updated last read data to the local cache.
    await _localCacheService.saveData(
      key: CacheKeys.lastReads,
      value: mLastReadToJson(parsedLastRead),
    );

    // Return the updated list of LastReadEntity objects.
    return parsedLastRead;
  }
}
