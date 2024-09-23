import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SetSelectedWbwLanguageUseCase extends BaseUseCase<void> {
  final WordByWordRepository _repository;

  SetSelectedWbwLanguageUseCase(this._repository, ErrorMessageHandler errorMessageHandler)
      : super(errorMessageHandler);

  Future<Either<String, void>> execute({required String fileName}) async {
    return mapResultToEither(() => _repository.setSelectedWbwLanguage(fileName));
  }
}
