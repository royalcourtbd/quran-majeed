import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';


class SaveBookmarksToAyahUseCase extends BaseUseCase<String> {
  SaveBookmarksToAyahUseCase(
    super.errorMessageHandler,
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, String>> execute({
    required int surahID,
    required int ayahID,
    required List<BookmarkFolderEntity> savingFolders,
  }) async {
    return mapResultToEither(() async {
      final List<BookmarkEntity> generatedBookmarks =
        await _mapBookmarkFoldersIntoBookmarks(savingFolders, surahID, ayahID);
      await _userDataRepository.saveBookmarksToAyah(
      surahID: surahID,
      ayahID: ayahID,
      bookmarks: generatedBookmarks,
      );
      return savingFolders.isNotEmpty ? "Collection saved" : "";
    });
  }

  Future<List<BookmarkEntity>> _mapBookmarkFoldersIntoBookmarks(
    List<BookmarkFolderEntity> folders,
    int surahID,
    int ayahID,
  ) async {
    final List<BookmarkEntity> bookmarks = await compute(
      _mapBookmarkFoldersIntoBookmarksPure,
      (folders, surahID, ayahID),
    );
    return bookmarks;
  }
}

List<BookmarkEntity> _mapBookmarkFoldersIntoBookmarksPure(
  (List<BookmarkFolderEntity>, int, int) param,
) {
  final (folders, surahID, ayahID) = param;
  final List<BookmarkEntity> generatedBookmarks = folders
      .map(
        (folder) =>
            _mapBookmarkFolderToBookmark(folder: folder, surahID: surahID, ayahID: ayahID),
      )
      .toList();
  return generatedBookmarks;
}

BookmarkEntity _mapBookmarkFolderToBookmark({
  required int surahID,
  required int ayahID,
  required BookmarkFolderEntity folder,
}) =>
    BookmarkEntity(
      folderName: folder.name.trim(),
      color: folder.color,
      surahID: surahID,
      ayahID: ayahID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
