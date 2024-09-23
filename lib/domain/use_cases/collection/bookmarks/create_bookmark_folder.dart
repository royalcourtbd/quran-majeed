import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';


class CreateBookmarkFolderUseCase extends BaseUseCase<String> {
  CreateBookmarkFolderUseCase(
    this._userDataRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final UserDataRepository _userDataRepository;

  Future<Either<String, String>> execute({
    required String name,
    required Color color,
    required int surahID,
    required int ayahID,
  }) async {
    return mapResultToEither(() async {
      await _saveAPlaceholderBookmark(
        name: name,
        color: color,
        surahID: surahID,
        ayahID: ayahID,
      );
      return "";
    });
  }

  Future<void> _saveAPlaceholderBookmark({
  required  String name,
  required Color color,
  required int surahID,
  required int ayahID,
  }) async {
    final BookmarkEntity bookmarkPlaceholder = BookmarkEntity.placeholder(
      folderName: name.trim(),
      color: color,
      surahID: surahID,
      ayahID: ayahID,
      
    );
    await _userDataRepository.addAyahToBookmarkFolder(
      bookmark: bookmarkPlaceholder,
    );
  }
}
