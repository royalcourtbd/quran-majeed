import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';

class DeleteAvailableTranslationUseCase extends BaseUseCase<void> {
  DeleteAvailableTranslationUseCase(this._translationRepository, super.errorMessageHandler);

  final TranslationRepository _translationRepository;

  Future<Either<String, void>> execute({required TTDbFileModel file}) {
    return mapResultToEither(() => _translationRepository.deleteAvailableTranslation(file: file));
  }
}