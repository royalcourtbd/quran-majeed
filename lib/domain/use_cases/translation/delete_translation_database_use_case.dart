import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';


class DeleteTranslationDatabaseUseCase extends BaseUseCase<void> {
  DeleteTranslationDatabaseUseCase(this._translationRepository, super.errorMessageHandler);

  final TranslationRepository _translationRepository;

  Future<Either<String, void>> execute({required String fileName})  {
    return mapResultToEither( () => _translationRepository.deleteTranslationDatabase(fileName: fileName));
  }
}
