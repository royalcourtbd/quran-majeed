import 'dart:convert';
import 'dart:io';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';

class AudioLocalDataSource {
  final LocalCacheService _localCacheService;
  final QuranDatabase _quranDatabase;

  AudioLocalDataSource(this._localCacheService, this._quranDatabase);

  Future<bool> checkIfSurahAudioDownloaded(int surah, Reciter reciter) async {
    try {
      final String key = _generateStorageKey(surah, reciter);
      final String? filePath = _localCacheService.getData(key: key);
      return filePath != null;
    } catch (e) {
      logErrorStatic(
          'Error in isSurahAudioDownloaded: $e', 'AudioLocalDataSource');
      return false;
    }
  }

  Future<void> deleteAudioFilesBySurahAndReciter(
      int surahId, Reciter reciter, String audioPath) async {
    try {
      String directoryPath = await getApplicationDirectoryPath();
      String filePath = "$directoryPath/$audioPath";
      await File(filePath).delete();
      final String key = _generateStorageKey(surahId, reciter);
      await _localCacheService.deleteData(key: key);
    } catch (e) {
      logErrorStatic('Error in deleteAudioFilesBySurahAndReciter: $e',
          'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<void> saveSelectedReciter(Reciter reciter) async {
    try {
      const String key = 'selected_reciter';
      final String value = jsonEncode(reciter.toJson());
      await _localCacheService.saveData(key: key, value: value);
    } catch (e) {
      logErrorStatic(
          'Error in saveSelectedReciter: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<void> saveReciterWithSurahId(int surahId, Reciter reciter,
      {bool isDelete = false}) async {
    try {
      final String key = 'reciter_${reciter.id}_surah_ids';
      String? data = _localCacheService.getData(key: key);
      List<int> existingSurahIds = [];

      if (data != null) {
        existingSurahIds = List<int>.from(jsonDecode(data));
      }

      if (isDelete) {
        existingSurahIds.remove(surahId);
      } else if (!existingSurahIds.contains(surahId)) {
        existingSurahIds.add(surahId);
      }

      await _localCacheService.saveData(
          key: key, value: jsonEncode(existingSurahIds));
    } catch (e) {
      logErrorStatic(
          'Error in saveReciterWithSurahId: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<List<int>> getSurahIdsForReciter(Reciter reciter) async {
    try {
      final String key = 'reciter_${reciter.id}_surah_ids';
      String? data = _localCacheService.getData(key: key);

      // Check if there is existing data
      if (data != null) {
        // Decode the JSON string into a list of integers
        List<dynamic> decodedList = jsonDecode(data);
        List<int> surahIds =
            decodedList.map((e) => int.parse(e.toString())).toList();
        return surahIds;
      } else {
        // Return an empty list if there is no data
        return [];
      }
    } catch (e) {
      logErrorStatic(
          'Error in getSurahIdsForReciter: $e', 'AudioLocalDataSource');
      return []; // Optionally, you might choose to rethrow or handle the error differently
    }
  }

  Future<Reciter> getSelectedReciter() async {
    try {
      const String key = 'selected_reciter';
      final String? value = _localCacheService.getData(key: key);
      if (value != null) {
        return Reciter.fromJson(jsonDecode(value));
      }
      return const Reciter(
          id: 7,
          name:
              'Mishary Rashid Alafasy'); // Return default reciter if none is selected
    } catch (e) {
      logErrorStatic('Error in getSelectedReciter: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<void> saveDownloadCount(int reciterId, int count) async {
    try {
      final String key = 'downloadCount_$reciterId';
      await _localCacheService.saveData(key: key, value: count.toString());
    } catch (e) {
      logErrorStatic('Error in saveDownloadCount: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<void> saveRecitersList(List<Reciter> reciters) async {
    try {
      const String key = 'reciters_list';
      final String value =
          jsonEncode(reciters.map((reciter) => reciter.toJson()).toList());
      await _localCacheService.saveData(key: key, value: value);
    } catch (e) {
      logErrorStatic('Error in saveRecitersList: $e', 'AudioLocalDataSource');
    }
  }

  Future<List<Reciter>> loadRecitersList() async {
    try {
      const String key = 'reciters_list';
      final String? value = _localCacheService.getData(key: key);
      if (value != null) {
        List<dynamic> jsonData = jsonDecode(value);
        return jsonData.map((data) => Reciter.fromJson(data)).toList();
      }
      return [];
    } catch (e) {
      logErrorStatic('Error in loadRecitersList: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<void> persistSurahAudioPath(
      int surah, Reciter reciter, String filePath) async {
    try {
      final String key = _generateStorageKey(surah, reciter);
      await _localCacheService.saveData(key: key, value: filePath);
    } catch (e) {
      logErrorStatic(
          'Error in persistSurahAudioPath: $e', 'AudioLocalDataSource');
    }
  }

  Future<String> fetchLocalAudioPath(int surah, Reciter reciter) async {
    try {
      final String key = _generateStorageKey(surah, reciter);
      return _localCacheService.getData(key: key);
    } catch (e) {
      logErrorStatic('Error in getAudioPath: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  String _generateStorageKey(int surah, Reciter reciter) {
    return 'audio_${reciter.name}_$surah';
  }

  Future<void> removeAudioFileFromCache(int surah, Reciter reciter) async {
    try {
      final String key = _generateStorageKey(surah, reciter);
      await _localCacheService.deleteData(key: key);
    } catch (e) {
      logErrorStatic('Error in deleteAudioFile: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<AudioFile> getAudioFilesBySurahAndReciter(
      int surahId, Reciter reciter) async {
    try {
      return await _quranDatabase.getAudioFilesBySurahAndReciter(
          surahId, reciter.id);
    } catch (e) {
      logErrorStatic('Error in getAudioFilesBySurahAndReciter: $e',
          'AudioLocalDataSource');
      rethrow;
    }
  }

  Future<List<VerseTiming>> getVerseTimingsBySurahId(
      int reciterID, int surahID) async {
    try {
      return await _quranDatabase.getVerseTimingsBySurahId(reciterID, surahID);
    } catch (e) {
      logErrorStatic(
          'Error in getVerseTimingsByAudioFileId: $e', 'AudioLocalDataSource');
      rethrow;
    }
  }
}
