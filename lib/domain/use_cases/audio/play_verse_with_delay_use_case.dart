import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';

class PlayVerseWithDelayUseCase extends BaseUseCase<void> {
  final AudioRepository _audioRepository;

  PlayVerseWithDelayUseCase(this._audioRepository, super.errorMessageHandler);

  Future<void> execute(int audioFileId, String verseKey, Duration delay) async {
    try {
      final List<VerseTiming> timings = await _audioRepository.getVerseTimings(
          reciterID: audioFileId,
        surahID: audioFileId);
      final VerseTiming verseTiming = timings.firstWhere((timing) => timing.ayah.toString() == verseKey);
      await _audioRepository.playVerseWithDelay(verseTiming, delay);
    } on Exception catch (e) {
      return logErrorStatic('Error in playVerseWithDelay: $e', 'PlayVerseWithDelayUseCase');
    }
  }
}
