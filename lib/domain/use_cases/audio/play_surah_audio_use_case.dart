import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class PlaySurahAudioUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  PlaySurahAudioUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, void>> execute() {
    return mapResultToEither(() => _audioRepository.playSurahPlaylist());
  }
}