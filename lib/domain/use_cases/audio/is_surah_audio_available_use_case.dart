import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class IsSurahAudioAvailableUseCase extends BaseUseCase<bool> {
  final AudioRepository _audioRepository;

  IsSurahAudioAvailableUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, bool>> execute({
    required int surahNumber,
    required Reciter reciter,
  }) {
    return mapResultToEither(() => _audioRepository.isSurahAudioAvailable(
          surahNumber: surahNumber,
          reciter: reciter,
        ));
  }
}