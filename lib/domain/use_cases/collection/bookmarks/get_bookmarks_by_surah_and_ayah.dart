import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class GetBookmarksBySurahAndAyahUseCase extends BaseUseCase<List<BookmarkFolderEntity>> {
  GetBookmarksBySurahAndAyahUseCase(
    super.errorMessageHandler,
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, List<BookmarkFolderEntity>>> execute({
    required int surahID,
    required int ayahID,
  }) async {
    return mapResultToEither(
      () async => _userDataRepository.getBookmarkFolderBySurahAndAyah(
        surahID: surahID,
        ayahID: ayahID,
      ),
    );
  }
}
