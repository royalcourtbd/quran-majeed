import 'dart:ui';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';


class UpdateBookmarkFolderUseCase extends BaseUseCase<String> {
  UpdateBookmarkFolderUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, String>> execute({
    required String folderName,
    required String newFolderName,
    required Color color,
  }) async {
    return mapResultToEither(() async {
      await _userDataRepository.updateBookmark(
        folderName: folderName,
        newFolderName: newFolderName,
        color: color,
      );
      return "Folder updated successfully";
    });
  }
}
