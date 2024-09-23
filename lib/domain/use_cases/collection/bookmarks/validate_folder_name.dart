import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class ValidateFolderNameUseCase extends BaseUseCase<bool> {
  ValidateFolderNameUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Set<String> _allFolderNames = {};

  Future<Either<String, bool>> execute({
    required String folderName,
  }) async {
    return mapResultToEither(() async {
      final List<BookmarkFolderEntity> allFolders = await _userDataRepository.getAllBookmarkFolders();
      _allFolderNames = allFolders.map((folder) => folder.name.trim().toLowerCase()).toSet();

      if (folderName.isEmpty) {
        throw Exception('Folder name cannot be empty');
      }

      if (folderName.startsWith(' ')) {
        throw Exception('Folder name cannot start with a space');
      }

      if (int.tryParse(folderName[0]) != null) {
        throw Exception('Folder name cannot start with a number');
      }

      if (folderName.length > 50) {
        throw Exception('Folder name cannot exceed 50 characters');
      }

      if (_allFolderNames.contains(folderName)) {
        throw Exception('Folder name is already used');
      }

      return true;
    });
  }
}
