import 'package:dio/dio.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

abstract class AudioRepository {
  Future<void> downloadAudioFiles({
    required int surahID,
    required Reciter reciter,
    void Function(int percentage)? onProgress,
    required CancelToken cancelToken,
  });

  Future<String> generateAudioFilePath({required int surah, required Reciter reciter});

  Future<void> deleteAudioFilesBySurahAndReciter({
    required int surahNumber,
    required Reciter reciter,
  });

  Future<void> persistSurahAudioPath({
    required List<int> surahs,
    required Reciter reciter,
  });
  Future<bool> isSurahAudioAvailable({
    required int surahNumber,
    required Reciter reciter,
  });
  Future<List<VerseTiming>> getVerseTimings({
    required int surahID,
    required int reciterID,
  });
  Future<void> playSurahPlaylist();

  Future<void> playVerseWithDelay(
    VerseTiming verseTiming,
    Duration delay,
  );
  Future<String> getAudioPath({
    required int surah,
    required Reciter reciter,
  });
  Future<void> addToPlayl1ist({
    required String audioPath,
    required String title,
  });

  Future<AudioFile> getAudioFilesBySurahAndReciter({
    required int surahNumber,
    required Reciter reciter,
  });
  Future<void> seekAudio(Duration position);
  Future<void> clearPlaylist();
  Future<void> stopAudio();
  Future<void> pausePlayback();
  Future<void> resumePlayback();
}
