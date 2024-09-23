import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class DeleteAyahFromBookmarksUseCase extends BaseUseCase<void> {
  DeleteAyahFromBookmarksUseCase(
    this._userDataRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final UserDataRepository _userDataRepository;

  Future<Either<String, void>> execute({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    return mapResultToEither(() async {
      await _userDataRepository.deleteAyahFromBookmarks(
        surahID: surahID,
        ayahID: ayahID,
        folderName: folderName,
      );
      return; // Since the use case is void, we just return without a value.
    });
  }
}