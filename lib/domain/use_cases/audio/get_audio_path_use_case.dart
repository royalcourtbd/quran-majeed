import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class GetAudioPathUseCase extends BaseUseCase<String> {
  final AudioRepository _audioRepository;

  GetAudioPathUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, String>> execute({
    required int surah,
    required Reciter reciter,
  }) async {
    return mapResultToEither(() async => await _audioRepository.getAudioPath(
          surah: surah,
          reciter: reciter,
        ));
  }
}