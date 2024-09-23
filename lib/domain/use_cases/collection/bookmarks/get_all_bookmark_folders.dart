import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';


class GetAllBookmarkFoldersUseCase
    extends BaseUseCase<List<BookmarkFolderEntity>> {
  GetAllBookmarkFoldersUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, List<BookmarkFolderEntity>>> execute() async {
    final Either<String, List<BookmarkFolderEntity>> result =
        await mapResultToEither(
      () async => _userDataRepository.getAllBookmarkFolders(),
    );
    return result;
  }
}
