import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class CreateAudioFilePathUseCase extends BaseUseCase<String> {
  final AudioRepository _audioRepository;

  CreateAudioFilePathUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, String>> execute({required int surah, required Reciter reciter}) {
    return mapResultToEither(() => _audioRepository.generateAudioFilePath(surah: surah, reciter: reciter));
  }
}
