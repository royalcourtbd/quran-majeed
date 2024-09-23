import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

import 'package:quran_majeed/domain/use_cases/audio/get_audio_files_by_surah_and_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/get_verse_timings_use_case.dart';

class FetchAudioFilesAndVerseTimingsUseCase extends BaseUseCase<void> {
  final GetAudioFilesBySurahAndReciterUseCase _getAudioFilesBySurahAndReciterUseCase;
  final GetVerseTimingsUseCase _getVerseTimingsUseCase;

  FetchAudioFilesAndVerseTimingsUseCase(
      this._getAudioFilesBySurahAndReciterUseCase, this._getVerseTimingsUseCase, super.errorMessageHandler);

  Future<Either<String, void>> execute(List<int> surahs, Reciter reciter) async {
    return mapResultToEither(() async {
      for (int surah in surahs) {
        if (CacheData.audioFiles[surah] == null) {
          AudioFile audioFile =
              await _getAudioFilesBySurahAndReciterUseCase.execute(surahNumber: surah, reciter: reciter);

          CacheData.audioFiles[surah] = audioFile;
          if (CacheData.verseTimings['${audioFile.reciterId}-${audioFile.surahId}'] == null) {
            CacheData.verseTimings['${audioFile.reciterId}-${audioFile.surahId}'] =
                await _getVerseTimingsUseCase.execute(reciterID:audioFile.reciterId,surahID: audioFile.surahId);
          }
        }
      }
    });
  }
}
