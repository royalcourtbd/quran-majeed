import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class AddToPlaylistUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  AddToPlaylistUseCase(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, void>> execute({
    required String audioPath,
    required String title,
  }) {
    return mapResultToEither(() => _audioRepository.addToPlayl1ist(audioPath: audioPath, title: title));
  }
}
