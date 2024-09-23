import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class GetVerseTimingsUseCase extends BaseUseCase<List<VerseTiming>> {
  final AudioRepository _audioRepository;

  GetVerseTimingsUseCase(this._audioRepository, super.errorMessageHandler);

  Future<List<VerseTiming>> execute({
    required int surahID,
    required int reciterID,
  }) {
    return getRight(() async => await _audioRepository.getVerseTimings(
          reciterID:reciterID,
          surahID: surahID,
        ));
  }
}
