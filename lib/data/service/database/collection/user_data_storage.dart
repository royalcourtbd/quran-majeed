import 'package:drift/drift.dart';
// ignore: unused_import
import 'package:quran_majeed/data/service/database/collection/tables/bookmark_table.dart';
import 'package:quran_majeed/data/service/database/database_loader.dart';

part 'user_data_storage.g.dart';


@DriftDatabase(tables: [Bookmark])
class UserDataStorage extends _$UserDataStorage {
  UserDataStorage({QueryExecutor? queryExecutor}) : super(queryExecutor ?? loadUserDatabase());

  @override
  int get schemaVersion => 1;

  Future<List<BookmarkData>> get allBookmarks =>
      (select(bookmark)..orderBy([(tbl) => OrderingTerm(expression: tbl.foldername)])).get();

  Future<BookmarkData?> getBookmarksOfSameFolderWithSameAyah({
    required int surahID,
    required String folderName,
    required int ayahID,
  }) =>
      ((select(bookmark))
            ..where(
                (tbl) => tbl.suraId.equals(surahID) & tbl.ayahId.equals(ayahID) & tbl.foldername.equals(folderName)))
          .getSingleOrNull();

  Future<int> addAyahToBookmarkFolder({
    required int surahID,
    required int ayahID,
    required String folderName,
    required String color,
  }) {
    return transaction(() async {
      return into(bookmark).insert(
        BookmarkCompanion.insert(
          foldername: folderName,
          suraId: surahID,
          ayahId: ayahID,
          color: color,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    });
  }

  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) {
    return transaction(() async {
      await (delete(bookmark)
            ..where(
                (tbl) => tbl.suraId.equals(surahID) & tbl.ayahId.equals(ayahID) & tbl.foldername.equals(folderName)))
          .go();
    });
  }

  Future<void> deleteBookmarkFolderByName({required String folderName}) {
    return transaction(() async {
      await (delete(bookmark)..where((tbl) => tbl.foldername.equals(folderName))).go();
    });
  }



  Future<List<BookmarkData?>> getBookmarksByFolderName({required String folderName}) =>
      (select(bookmark)..where((tbl) => tbl.foldername.equals(folderName))).get();

  Future<List<BookmarkData>> getBookmarkFolderBySurahAndAyah({
    required int surahID,
    required int ayahID,
  }) {
    return (select(bookmark)..where((tbl) => tbl.suraId.equals(surahID) & tbl.ayahId.equals(ayahID))).get();
  }

  // deleteAllBookmarksOfSurahAndAyah

  Future<void> deleteAllBookmarksOfSurahAndAyah({
    required int surahID,
    required int ayahID,
  }) {
    return transaction(() async {
      await (delete(bookmark)..where((tbl) => tbl.suraId.equals(surahID) & tbl.ayahId.equals(ayahID))).go();
    });
  }

  Future<void> updateBookmarkFolderName({
    required String folderName,
    required String newFolderName,
    required String color,
  }) {
    return transaction(() async {
      await (update(bookmark)..where((tbl) => tbl.foldername.equals(folderName)))
          .write(BookmarkCompanion(foldername: Value(newFolderName), color: Value(color)));
    });
  }
}
