// By separating the mapper functions (toMap, fromMap, toEntity, fromEntity) from the entity class
// and placing them into separate files in the data layer, we gain more flexibility and scalability.
// For example, we can easily run these functions in an isolate to improve performance, or separate DTO
// object types from domain layer entities. This also makes it easier to swap out data sources in the future
// as the functions can be reused with minimal changes. Additionally, this promotes a separation of concerns
// and ensures that the entity class in the domain layer remains clean and focused on business logic.

import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:quran_majeed/core/external_libs/collection_data_structures.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/collection/user_data_storage.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';

extension DtoToBookmarkEntityMapper on List<BookmarkData?> {
  Future<List<BookmarkEntity>> toBookmarkEntities() async {
    final List<BookmarkEntity> bookmarkEntities =
        await compute(_convertBookmarkDtoToBookmarkEntities, this);
    return bookmarkEntities;
  }
}

extension BookmarkEntitiesToBookmarkFolderEntitiesMapper
    on Pair<List<BookmarkEntity>, List<BookmarkEntity>> {
  Future<List<BookmarkEntity>> findOutBookmarksToBeSaved() async {
    return await compute(_findOutBookmarksToBeSavedStatic, this);
  }
}

List<BookmarkEntity> _findOutBookmarksToBeSavedStatic(
  Pair<List<BookmarkEntity>, List<BookmarkEntity>> params,
) {
  // Here we define a local variable to hold the bookmarks that need to be saved.
  final List<BookmarkEntity>? bookmarksToBeSaved = catchAndReturn(() {
    // First we create a set of the IDs of the existing bookmarks, so we can easily
    // check if a new bookmark already exists or not.
    final List<BookmarkEntity> existingBookmarks = params.first;
    final Set<String> existingBookmarkUniqueIdentifiers = existingBookmarks
        .map((bk) => "${bk.folderName}-${bk.surahID}-${bk.ayahID}")
        .toSet();

    // Then we filter out the new bookmarks that already exist by checking if their
    // ID is present in the set we just created.
    // Using a Set helps to improve performance by removing duplicates and
    // enabling faster membership testing.
    final List<BookmarkEntity> savingBookmark = params.second;
    final Set<BookmarkEntity> bookmarksToBeSaved = savingBookmark
        .where(
          (bk) => !existingBookmarkUniqueIdentifiers
              .contains("${bk.folderName}-${bk.surahID}-${bk.ayahID}"),
        )
        .toSet();

    // Finally, we return the filtered set of new bookmarks.
    final List<BookmarkEntity> bookmarksToBeSavedList =
        bookmarksToBeSaved.toList(growable: true);
    bookmarksToBeSaved.removeWhere((bookmark) => bookmark.isInValid);
    return bookmarksToBeSavedList;
  });

  // If there was an error during the bookmark filtering process, return an
  // empty list instead.
  return bookmarksToBeSaved ?? [];
}

extension BookmarkDataToBookmarkFolderEntityMapper on List<BookmarkData?> {
  Future<List<BookmarkFolderEntity>> groupBookmarksInFolders() async {
    return await compute(_groupBookmarksInFoldersStatic, this);
  }
}

List<BookmarkFolderEntity> _groupBookmarksInFoldersStatic(
  List<BookmarkData?> params,
) {
  final List<BookmarkFolderEntity>? folders = catchAndReturn(() {
    final List<BookmarkData?> bookmarkDataList = params;

    // Group bookmarks by name
    final Map<String, List<BookmarkData?>> bookmarkDataMapGroupedByName =
        bookmarkDataList.groupListsBy((bk) => bk!.foldername);

    final List<BookmarkFolderEntity> allFolders = List.empty(growable: true);
    int folderId = 1;

    // Iterate over each group (folder)
    for (final String folderName in bookmarkDataMapGroupedByName.keys) {
      final List<BookmarkData?>? bookmarks =
          bookmarkDataMapGroupedByName[folderName];

      if (bookmarks == null || bookmarks.isEmpty) continue;

      // Get folder color from the first bookmark
      final Color folderColor = getColorFromHex(bookmarks.first!.color);

      // count total number of bookmarks in the folder
      final int totalBookmarks = bookmarks.length;

      // Get folder created and updated time
      final (folderCreatedAt, folderUpdatedAt) =
          getBookmarkFolderCreatedAndUpdatedTime(bookmarks);

      // Create a new bookmark folder entity
      allFolders.add(
        BookmarkFolderEntity(
          id: folderId++,
          name: folderName,
          color: folderColor,
          count: totalBookmarks,
          updatedAt: folderUpdatedAt,
          createdAt: folderCreatedAt,
        ),
      );
    }

    // Sort folders by name
    allFolders.sort((a, b) => a.name.compareTo(b.name));

    return allFolders;
  });

  return folders ?? [];
}

(DateTime, DateTime) getBookmarkFolderCreatedAndUpdatedTime(
  List<BookmarkData?> bookmarkDataList,
) {
  final DateTime earliestCreatedAt = bookmarkDataList
      .map((bk) => bk!.createdAt)
      .reduce((bkb, bka) => bkb.isBefore(bka) ? bkb : bka);
  final DateTime latestUpdatedAt = bookmarkDataList
      .map((bk) => bk!.updatedAt)
      .reduce((bkb, bka) => bkb.isAfter(bka) ? bkb : bka);

  return (earliestCreatedAt, latestUpdatedAt);
}

Future<List<BookmarkEntity>> _convertBookmarkDtoToBookmarkEntities(
  List<BookmarkData?> param,
) async {
  final List<Future<BookmarkEntity>> futures =
      param.map((dto) async => _convertDtoToBookmarkEntity(dto!)).toList();
  return Future.wait(futures);
}

BookmarkEntity _convertDtoToBookmarkEntity(BookmarkData dto) => BookmarkEntity(
      id: dto.id,
      folderName: dto.foldername,
      color: getColorFromHex(dto.color),
      surahID: dto.suraId,
      ayahID: dto.ayahId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );

extension BookmarkToDtoMap on BookmarkEntity {
  Future<Map<String, Object?>> toMap() async =>
      compute(_convertBookmarkToDtoMap, this);
}

Map<String, Object?> _convertBookmarkToDtoMap(
  BookmarkEntity bookmark,
) {
  return {
    'id': bookmark.id,
    'surah_id': bookmark.surahID,
    'ayah_id': bookmark.ayahID,
    'color': getHexFromColor(bookmark.color),
    'folder_name': bookmark.folderName,
    'created_at': bookmark.createdAt.toTimestamp,
    'updated_at': bookmark.updatedAt.toTimestamp,
  };
}

extension BookmarkListToDtoMap on List<BookmarkEntity> {
  Future<List<Map<String, Object?>>> toMapList() async =>
      compute(convertBookmarkListToDtoMap, this);
}

Future<List<Map<String, Object?>>> convertBookmarkListToDtoMap(
  List<BookmarkEntity> bookmarks,
) async {
  final List<Future<Map<String, Object?>>> futures =
      bookmarks.map((bookmark) async {
    return _convertBookmarkToDtoMap(bookmark);
  }).toList();
  final List<Map<String, Object?>> result = await Future.wait(futures);
  return result;
}

BookmarkEntity _convertMapToBookmarkEntity(
  Map<String, Object?> dtoMap,
) {
  return BookmarkEntity(
    id: dtoMap['id'] as int? ?? 0,
    surahID: dtoMap['surah_id'] as int? ?? 0,
    ayahID: dtoMap['ayah_id'] as int? ?? 0,
    color: getColorFromHex(dtoMap['color'] as String?),
    folderName: dtoMap['folder_name'] as String? ?? '',
    createdAt: (dtoMap['created_at'] as int?).fromTimestampToDateTime,
    updatedAt: (dtoMap['updated_at'] as int?).fromTimestampToDateTime,
  );
}

extension MapsToBookmarkList on List<Map<String, Object?>> {
  Future<List<BookmarkEntity>> toBookmarks() async {
    return compute(_convertMapsToBookmarkList, this);
  }
}

Future<List<BookmarkEntity>> _convertMapsToBookmarkList(
  List<Map<String, Object?>> bookmarkMaps,
) async {
  final List<Future<BookmarkEntity>> futures = bookmarkMaps
      .map(
        (bookmarkMap) => Future<BookmarkEntity>.value(
          _convertMapToBookmarkEntity(bookmarkMap),
        ),
      )
      .toList();
  return Future.wait(futures);
}
