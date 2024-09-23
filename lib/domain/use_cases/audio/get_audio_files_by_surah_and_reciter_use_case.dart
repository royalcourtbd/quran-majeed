import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class GetAudioFilesBySurahAndReciterUseCase extends BaseUseCase<AudioFile> {
  final AudioRepository _audioRepository;

  GetAudioFilesBySurahAndReciterUseCase(this._audioRepository, super.errorMessageHandler);

  Future<AudioFile> execute({
    required int surahNumber,
    required Reciter reciter,
  }) {
    return getRight(
        () async => await _audioRepository.getAudioFilesBySurahAndReciter(surahNumber: surahNumber, reciter: reciter));
  }
}
