import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class PausePlaybackUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  PausePlaybackUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, void>> execute() {
    return mapResultToEither(() => _audioRepository.pausePlayback());
  }
}