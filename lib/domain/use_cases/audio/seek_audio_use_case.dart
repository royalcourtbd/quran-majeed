import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class SeekAudioUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  SeekAudioUseCase(this._audioRepository, super.errorMessageHandler);

  Future<void> execute({
    required Duration seekDuration,
  }) {
    return getRight(() async => await _audioRepository.seekAudio(
          seekDuration,
        ));
  }
}