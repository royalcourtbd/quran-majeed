import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetDownloadedWbwLanguagesUseCase extends BaseUseCase<List<String>> {
  final WordByWordRepository _repository;

  GetDownloadedWbwLanguagesUseCase(this._repository, ErrorMessageHandler errorMessageHandler)
      : super(errorMessageHandler);

  Future<Either<String, List<String>>> execute() async {
    return mapResultToEither(() => _repository.getDownloadedWbwLanguages());
  }
}