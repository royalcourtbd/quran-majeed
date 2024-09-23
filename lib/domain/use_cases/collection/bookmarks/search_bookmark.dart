import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:synchronized/synchronized.dart';

class SearchBookmarkUseCase extends BaseUseCase<List<BookmarkFolderEntity>> {
  SearchBookmarkUseCase(super.errorMessageHandler);

  late final Lock _searchLock = Lock();

  Future<Either<String, List<BookmarkFolderEntity>>> execute({
    required String query,
    required List<BookmarkFolderEntity> allFolders,
  }) async {
    return mapResultToEither(() async {
      return _searchLock.synchronized(() async {
        if (query.isEmpty) return allFolders;
        final List<BookmarkFolderEntity> filteredFolders =
            await compute(_filterFolderByQuery, (allFolders, query));
        return filteredFolders;
      });
    });
  }
}

Future<List<BookmarkFolderEntity>> _filterFolderByQuery(
  (List<BookmarkFolderEntity>, String) param,
) async {
  final (allFolders, query) = param;
  final String normalizedQuery = query.trim().toLowerCase();

  return allFolders.where((folder) => 
    folder.name.toLowerCase().contains(normalizedQuery)
  ).toList();
}
