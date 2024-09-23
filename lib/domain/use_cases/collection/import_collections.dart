import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/data/mappers/bookmark/bookmark_mapper.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class ImportCollectionsUseCase extends BaseUseCase<String> {
  ImportCollectionsUseCase(
    super.errorMessageHandler,
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, String>> execute(String collectionJsonString) async {
    return mapResultToEither(() async {
      _validateFile(collectionJsonString);

      final bookmarks =
          await compute(_mapToCollectionList, collectionJsonString);

      logDebug(bookmarks);

      await _userDataRepository.saveCollections(
        bookmarks: bookmarks,
      );
      return "Your collections have been imported successfully.";
    });
  }

  void _validateFile(String collectionJsonString) {
    if (collectionJsonString.isEmpty) throw Exception("The file is empty.");
    if (!collectionJsonString.contains("bookmarks") &&
        !collectionJsonString.contains("pins")) {
      throw Exception("The file is likely not exported from the Quran Majeed app.");
    }
  }
}

Future<List<BookmarkEntity>> _mapToCollectionList(
  String collectionJsonString,
) async {
  final Map<String, dynamic> collectionMap =
      jsonDecode(collectionJsonString) as Map<String, dynamic>;

  final List<Map<String, Object?>> bookmarksMap =
      (collectionMap["bookmarks"] as List<dynamic>)
          .map((any) => any as Map<String, Object?>)
          .toList();

final List<BookmarkEntity> bookmarks = await bookmarksMap.toBookmarks();

  return bookmarks;
}
