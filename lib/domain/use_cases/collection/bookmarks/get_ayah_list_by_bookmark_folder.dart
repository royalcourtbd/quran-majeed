import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class GetAyahListByBookmarkFolder extends BaseUseCase<List<BookmarkEntity>> {
  GetAyahListByBookmarkFolder(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, List<BookmarkEntity>>> execute(String folderName) async {
    final Either<String, List<BookmarkEntity>> result =
        await mapResultToEither(
      () async => _userDataRepository.getAyahListByBookmarkFolder(folderName:folderName),
    );
    return result;
  }
}