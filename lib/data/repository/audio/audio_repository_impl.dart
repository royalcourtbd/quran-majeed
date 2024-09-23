import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/audio/audio_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/audio/audio_remote_data_source.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';
import 'package:path/path.dart' as p;
import 'package:quran_majeed/domain/service/audio_service.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioLocalDataSource _audioLocalDataSource;
  final AudioRemoteDataSource _audioRemoteDataSource;

  AudioRepositoryImpl(this._audioLocalDataSource, this._audioRemoteDataSource);

  @override
  Future<void> downloadAudioFiles({
    required int surahID,
    required Reciter reciter,
    void Function(int percentage)? onProgress,
    required CancelToken cancelToken,
  }) async {
    if (!cancelToken.isCancelled) {
      final String audioFile = CacheData.audioFiles[surahID]!.audioLink;
      await _downloadSurahAudio(audioFile, surahID, reciter,
          (percentage) => onProgress?.call(percentage), cancelToken);
    }
  }

  @override
  Future<void> persistSurahAudioPath({
    required List<int> surahs,
    required Reciter reciter,
  }) async {
    String directoryPath = await getApplicationDirectoryPath();

    for (int surah in surahs) {
      final String generatedPath =
          await generateAudioFilePath(surah: surah, reciter: reciter);
      final String savePath = p.join(directoryPath, generatedPath);
      await _audioLocalDataSource.persistSurahAudioPath(
          surah, reciter, savePath);
    }
  }

  @override
  Future<AudioFile> getAudioFilesBySurahAndReciter({
    required int surahNumber,
    required Reciter reciter,
  }) async {
    return await _audioLocalDataSource.getAudioFilesBySurahAndReciter(
        surahNumber, reciter);
  }

  Future<void> _downloadSurahAudio(
    String url,
    int surah,
    Reciter reciter,
    void Function(int percentage)? onProgress,
    CancelToken? cancelToken,
  ) async {
    try {
      String filePath =
          await generateAudioFilePath(surah: surah, reciter: reciter);
      await _audioRemoteDataSource.fetchAndDownloadAudio(
        url: url,
        filePath: filePath,
        onProgress: onProgress!,
        cancelToken: cancelToken,
      );
      await _audioLocalDataSource.persistSurahAudioPath(
          surah, reciter, filePath);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return;
      }
      logErrorStatic('Error in _downloadSurahAudio: $e', 'AudioRepositoryImpl');
    }
  }

  @override
  Future<void> deleteAudioFilesBySurahAndReciter({
    required int surahNumber,
    required Reciter reciter,
  }) async {
    final String audioPath =
        await generateAudioFilePath(surah: surahNumber, reciter: reciter);
    await _audioLocalDataSource.deleteAudioFilesBySurahAndReciter(
        surahNumber, reciter, audioPath);
  }

  @override
  Future<String> generateAudioFilePath(
      {required int surah, required Reciter reciter}) async {
    String directoryPath = p.join('audio', reciter.name);
    return p.join(directoryPath, '$surah.mp3');
  }

  @override
  Future<String> getAudioPath(
      {required int surah, required Reciter reciter}) async {
    return await _audioLocalDataSource.fetchLocalAudioPath(surah, reciter);
  }

  @override
  Future<bool> isSurahAudioAvailable(
          {required int surahNumber, required Reciter reciter}) =>
      _audioLocalDataSource.checkIfSurahAudioDownloaded(surahNumber, reciter);

  @override
  Future<List<VerseTiming>> getVerseTimings({
    required int surahID,
    required int reciterID,
  }) async {
    try {
      List<VerseTiming> verseTimings = await _audioLocalDataSource
          .getVerseTimingsBySurahId(reciterID, surahID);
      return verseTimings;
    } catch (e) {
      logErrorStatic('Error in getVerseTimings: $e', 'AudioRepositoryImpl');
      rethrow;
    }
  }

  @override
  Future<void> playVerseWithDelay(
      VerseTiming verseTiming, Duration delay) async {
    try {
      await AudioPlayerService.playVerseAfterDelay(verseTiming, delay);
    } catch (e) {
      logErrorStatic('Error in playVerseWithDelay: $e', 'AudioRepositoryImpl');
      rethrow;
    }
  }

  @override
  Future<void> playSurahPlaylist() async {
    await AudioPlayerService.startPlaylistPlayback();
  }

  @override
  Future<void> seekAudio(Duration position) async {
    await AudioPlayerService.seekAudioPosition(position);
  }

  @override
  Future<void> addToPlayl1ist({
    required String audioPath,
    required String title,
  }) async {
    await AudioPlayerService.enqueueAudioToPlaylist(
      audioPath: audioPath,
      title: title,
    );
  }

  @override
  Future<void> clearPlaylist() async {
    await AudioPlayerService.clearPlaylist();
  }

  @override
  Future<void> stopAudio() async {
    await AudioPlayerService.stopPlayback();
    await AudioPlayerService.clearPlaylist();
  }

  @override
  Future<void> pausePlayback() async {
    await AudioPlayerService.pausePlayback();
  }

  @override
  Future<void> resumePlayback() async {
    await AudioPlayerService.resumePlayback();
  }
}
