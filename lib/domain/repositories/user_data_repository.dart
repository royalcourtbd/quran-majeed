import 'dart:ui';

import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';

import '../entities/last_read_entity.dart';

abstract class UserDataRepository {
  Future<void> doneFirstTime();

  Future<bool> determineFirstRun();

  Future<bool> needsMigration();

  Future<List<BookmarkEntity>> getAllBookmarks();

  Future<void> migrateOldBookmarks();

  Future<void> addAyahToBookmarkFolder({
    required BookmarkEntity bookmark,
    bool saveToRemote = true,
  });

  Future<void> saveCollections({
    required List<BookmarkEntity> bookmarks,
  });

    Future<bool> askForReviewIfAllowed({
    required VoidCallback askForReview,
  });


  Future<void> saveNeedsMigration();

  Future<void> updateBookmark({
    required String folderName,
    required String newFolderName,
    required Color color,
  });

  Future<void> deleteAyahFromBookmarks({
    required int surahID,
    required int ayahID,
    required String folderName,
  });

  Future<void> deleteBookmarkFolder({
    required BookmarkFolderEntity folder,
  });

  Future<List<BookmarkFolderEntity>> getAllBookmarkFolders();

  Future<List<BookmarkEntity>> getAyahListByBookmarkFolder({required String folderName});

  Future<BookmarkFolderEntity?> getBookmarkFolder({
    required String folderName,
  });

  Future<List<BookmarkFolderEntity>> getBookmarkFolderBySurahAndAyah({
    required int surahID,
    required int ayahID,
  });

  Future<
      // (
      List<BookmarkFolderEntity>
      // List<PinEntity>)
      > syncCollectionsWithRemote();

  Future<void> saveBookmarksToAyah({
    required int surahID,
    required int ayahID,
    required List<BookmarkEntity> bookmarks,
  });

  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required BookmarkFolderEntity folder,
  });

  Future<void> saveLastRead({required LastReadEntity lastRead});

  Future<List<LastReadEntity>> getLastReads();

  Future<List<LastReadEntity>> deleteLastReads({
    required List<int> deletedItem,
  });
}
