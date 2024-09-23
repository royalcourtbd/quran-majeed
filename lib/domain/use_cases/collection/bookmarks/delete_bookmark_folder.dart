import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';


class DeleteBookmarkFolderUseCase extends BaseUseCase<String> {
  DeleteBookmarkFolderUseCase(
    this._userDataRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);
  final UserDataRepository _userDataRepository;

  Future<Either<String, String>> execute({
    required BookmarkFolderEntity folder,
  }) async {
    return mapResultToEither(() async {
      await _userDataRepository.deleteBookmarkFolder(folder: folder);
      return "Folder deleted successfully";
    });
  }
}
