import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/entities/collections/sort_option_entity.dart';

class SortBookmarkUseCase extends BaseUseCase<List<BookmarkFolderEntity>> {
  SortBookmarkUseCase(super.errorMessageHandler);

  Future<Either<String, List<BookmarkFolderEntity>>> execute({
    required SortOptionEntity option,
    required List<BookmarkFolderEntity> folders,
  }) async {
    return mapResultToEither(
      () async {
        final List<BookmarkFolderEntity> sortedBookmarks =
            await compute(_sortBookmarks, (option, folders));
        return sortedBookmarks;
      },
    );
  }
}

List<BookmarkFolderEntity> _sortBookmarks(
  (SortOptionEntity, List<BookmarkFolderEntity>) param,
) {
  final (option, folders) = param;
  switch (option.type) {
    case SortOptionType.aToZ:
      return _sortByName(folders);
    case SortOptionType.createdDate:
      return _sortByCreatedAt(folders);
    case SortOptionType.lastUpdated:
      return _sortByUpdatedAt(folders);
    default:
      return folders;
  }
}

List<BookmarkFolderEntity> _sortByUpdatedAt(
  List<BookmarkFolderEntity> folders,
) =>
    folders
        .sortedByCompare(
          (folder) => folder.updatedAt,
          (fb, fa) => fb.compareTo(fa),
        )
        .reversed
        .toList();

List<BookmarkFolderEntity> _sortByCreatedAt(
  List<BookmarkFolderEntity> folders,
) =>
    folders
        .sortedByCompare(
          (folder) => folder.createdAt,
          (fb, fa) => fb.compareTo(fa),
        )
        .reversed
        .toList();

List<BookmarkFolderEntity> _sortByName(List<BookmarkFolderEntity> folders) =>
    folders.sortedByCompare(
      (folder) => folder.name,
      (fb, fa) => fb.compareTo(fa),
    );
