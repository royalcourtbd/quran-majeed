import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/word_by_word/word_by_word_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/word_by_word/word_by_word_remote_data_source.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/data/mappers/word_by_word_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/database/word_by_word/word_by_word_database.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';

import '../service/running_compute.dart';

class WordByWordRepositoryImpl extends WordByWordRepository {
  final WbwRemoteDataSource _remoteDataSource;
  final LocalCacheService _localCacheService;

  final WordbyWordLocalDataSource _wordByWordLocalDataSource;

  WordByWordRepositoryImpl(
    this._remoteDataSource,
    this._localCacheService,
    this._wordByWordLocalDataSource,
  );

  final int _maxCacheSize = 5;
  final Map<int, List<WordByWordEntity>> _cache = {};
  final Map<int, Map<int, List<WordByWordEntity>>> _ayahcache = {};
  final Queue<int> _cacheOrder = Queue();

  @override
  Future<WbwJsonModel> getAvailableWbwLanguages() async {
    return await _wordByWordLocalDataSource.loadWbwData();
  }

  @override
  Future<List<String>> getDownloadedWbwLanguages() async {
    final downloadedWbwLanguages = _localCacheService.getData(key: CacheKeys.downloadedWbwLanguages);
    return downloadedWbwLanguages != null
        ? List<String>.from(jsonDecode(downloadedWbwLanguages))
        : ['Bangla', 'English']; // Default languages
  }

  @override
  Future<void> downloadWbwLanguage(
    WbwDbFileModel wbwFile,
    void Function(int) onProgress,
    CancelToken cancelToken,
  ) async {
    try {
      await _remoteDataSource.downloadWbwDatabase(
        url: wbwFile.link,
        fileName: wbwFile.name,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );
      await _addToDownloadedWbwLanguages(wbwFile.name);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        throw Exception("Download cancelled");
      }
      throw Exception("Failed to download Word by Word database");
    }
  }

  Future<void> _loadWbwDataToCache(String fileName) async {
    final dbFile = File(await getDatabaseFilePath(fileName));
    final database = WordByWordDatabase(dbFile);
    try {
      final List<WordByWordTableData> wordsData = await database.getWordByWordFromDB();

      _addToWordByWordCache(fileName: fileName, wordByWordData: wordsData);
    } finally {
      await database.close();
    }
  }

  void _addToWordByWordCache({required String fileName, required List<WordByWordTableData> wordByWordData}) {
    final Map<int, Map<int, List<WordByWordTableData>>> structuredData = {};
    for (var entity in wordByWordData) {
      structuredData.putIfAbsent(entity.sura, () => {}).putIfAbsent(entity.ayah, () => []).add(entity);
    }

    CacheData.wordByWordCache[fileName] = structuredData;
  }

  @override
  Future<void> deleteWbwLanguage(WbwDbFileModel file) async {
    await _wordByWordLocalDataSource.deleteWbwDatabase(file: file);
    await _removeFromDownloadedWbwLanguages(file.name);
  }

  @override
  Future<void> setSelectedWbwLanguage(String fileName) async {
    await _loadWbwDataToCache(fileName);
    await _localCacheService.saveData(key: CacheKeys.selectedWbwLanguage, value: fileName);
  }

  @override
  Future<String> getSelectedWbwLanguage() async {
    return _localCacheService.getData(key: CacheKeys.selectedWbwLanguage) ?? 'English';
  }

  Future<void> _addToDownloadedWbwLanguages(String fileName) async {
    final List<String> currentDownloaded = await getDownloadedWbwLanguages();
    currentDownloaded.add(fileName);
    await _localCacheService.saveData(
      key: CacheKeys.downloadedWbwLanguages,
      value: jsonEncode(currentDownloaded),
    );
  }

  Future<void> _removeFromDownloadedWbwLanguages(String fileName) async {
    final List<String> currentDownloaded = await getDownloadedWbwLanguages();
    currentDownloaded.remove(fileName);
    await _localCacheService.saveData(
      key: CacheKeys.downloadedWbwLanguages,
      value: jsonEncode(currentDownloaded),
    );
  }

  @override
  Future<List<WordByWordEntity>> getWordsForSurah(int surahNumber) async {
    if (_cache.containsKey(surahNumber)) {
      _cacheOrder.remove(surahNumber);
      _cacheOrder.addFirst(surahNumber);
      return _cache[surahNumber]!;
    }

    final List<WordByWordEntity> words = await _fetchAndProcessWordsForSurah(surahNumber);
    _cache[surahNumber] = words;
    _cacheOrder.addFirst(surahNumber);

    if (_cacheOrder.length > _maxCacheSize) {
      final int oldestSurah = _cacheOrder.removeLast();
      _cache.remove(oldestSurah);
    }

    return words;
  }

  @override
  Future<List<WordByWordEntity>> getWordsForSpecificAyah(int surahNumber, int ayahNumber) async {
    if (_ayahcache.containsKey(surahNumber) && _ayahcache[surahNumber]![ayahNumber] != null) {
      return _ayahcache[surahNumber]![ayahNumber]!;
    }
    final Map<String, List<dynamic>> rawData =
        await _wordByWordLocalDataSource.getWordsByWordForSpecificAyah(surahNumber, ayahNumber);
    final List<WordByWordDatabaseTableData> processedData = await compute(_processWordDataForAyah, rawData);
    final List<WordByWordEntity> wordByWordEntity = await processedData.toWordByWordListEntity();

    _ayahcache.putIfAbsent(
        surahNumber,
        () => {
              ayahNumber: wordByWordEntity,
            });
    return wordByWordEntity;
  }

  static List<WordByWordDatabaseTableData> _processWordDataForAyah(Map<String, List<dynamic>> rawData) {
    return rawData['words']!.map((data) => WordByWordDatabaseTableData.fromJson(data as Map<String, dynamic>)).toList();
  }

  Future<List<WordByWordEntity>> _fetchAndProcessWordsForSurah(int surahNumber) async {
    final List<Map<String, dynamic>> rawData = await _wordByWordLocalDataSource.getWordsByWordForSurah(surahNumber);
    final List<WordByWordDatabaseTableData> processedData = await compute(_processWordData, rawData);
    return processedData.toWordByWordListEntity();
  }

  static List<WordByWordDatabaseTableData> _processWordData(List<dynamic> rawData) {
    return rawData.map((data) => WordByWordDatabaseTableData.fromJson(data as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> preloadAdjacentSurahs(int currentSurah) async {
    final List<int> surahs = [currentSurah - 1, currentSurah + 1];
    for (final int surah in surahs) {
      if (surah > 0 && surah <= 114 && !_cache.containsKey(surah)) {
        await getWordsForSurah(surah);
      }
    }
  }
}
