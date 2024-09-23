import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetSelectedWbwLanguageUseCase extends BaseUseCase<String> {
  final WordByWordRepository _repository;

  GetSelectedWbwLanguageUseCase(this._repository, ErrorMessageHandler errorMessageHandler)
      : super(errorMessageHandler);

  Future<Either<String, String>> execute() async {
    return mapResultToEither(() => _repository.getSelectedWbwLanguage());
  }
}