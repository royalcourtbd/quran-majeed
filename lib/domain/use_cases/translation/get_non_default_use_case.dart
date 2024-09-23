import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';

class GetNonDefaultTranslationUseCase extends BaseUseCase<void> {
  GetNonDefaultTranslationUseCase(this._translationRepository, super.errorMessageHandler);

  final TranslationRepository _translationRepository;

  Future<Either<String, void>> execute({
    required TTDbFileModel file,
    void Function(int percentage)? onProgress,
    required CancelToken cancelToken,
  }) {
    return mapResultToEither(() => _translationRepository.getNonDefaultTranslation(
          file: file,
          onProgress: onProgress,
          cancelToken: cancelToken,
        ));
  }
}
