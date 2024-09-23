import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/bookmark/bookmark_mapper.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class ExportCollectionsUseCase extends BaseUseCase<String> {
  ExportCollectionsUseCase(
    super.errorMessageHandler,
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

   Future<Either<String, String>> execute() async {
    return mapResultToEither(() async {
      final List<BookmarkEntity> bookmarks = await _userDataRepository.getAllBookmarks();
      final String collectionJsonString = await compute(_collectionToMapList, bookmarks);
      return collectionJsonString;
    });
  }
}

Future<String> _collectionToMapList(List<BookmarkEntity> param) async {
  final List<Map<String, Object?>> bookmarksAsMap = await convertBookmarkListToDtoMap(param);

  final Map<String, List<Map<String, Object?>>> collectionMap = {
    "bookmarks": bookmarksAsMap,
  };

  final String collectionJson = json.encode(collectionMap);
  return collectionJson;
}