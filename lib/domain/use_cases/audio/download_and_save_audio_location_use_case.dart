import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class DownloadAndSaveAudioLocationUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  DownloadAndSaveAudioLocationUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, void>> execute({
    required int surahID,
    required Reciter reciter,
    void Function(int percentage)? onProgress,
   required CancelToken cancelToken,
  }) async {
    return mapResultToEither(() async => await _audioRepository.downloadAudioFiles(
          surahID: surahID,
          reciter: reciter,
          onProgress: onProgress,
          cancelToken: cancelToken,
        ));
  }
}
