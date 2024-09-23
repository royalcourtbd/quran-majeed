import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class DownloadWbwLanguageUseCase extends BaseUseCase<void> {
  final WordByWordRepository _repository;

  DownloadWbwLanguageUseCase(this._repository, ErrorMessageHandler errorMessageHandler) : super(errorMessageHandler);

  Future<Either<String, void>> execute({
    required WbwDbFileModel wbwFile,
    required void Function(int) onProgress,
    required CancelToken cancelToken,
  }) async {
    return mapResultToEither(() => _repository.downloadWbwLanguage(
          wbwFile,
          onProgress,
          cancelToken,
        ));
  }
}
