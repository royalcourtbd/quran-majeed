import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class DeleteAudioBySurahAndReciter extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  DeleteAudioBySurahAndReciter(this._audioRepository, super.errorMessageHandler);

  Future<Either<String, void>> execute({
    required int surahId,
    required Reciter reciter,
  }) {
    return mapResultToEither(() => _audioRepository.deleteAudioFilesBySurahAndReciter(
          surahNumber: surahId,
          reciter: reciter,
        ));
  }
}