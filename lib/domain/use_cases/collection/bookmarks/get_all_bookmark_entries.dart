import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';


class GetAllBookmarkEntries
    extends BaseUseCase<List<BookmarkEntity>> {
  GetAllBookmarkEntries(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, List<BookmarkEntity>>> execute() async {
    final Either<String, List<BookmarkEntity>> result =
        await mapResultToEither(
      () async => _userDataRepository.getAllBookmarks(),
    );
    return result;
  }
}
