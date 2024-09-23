import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/translation_and_tafseer/translation_tafseer_remote_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/translation/translation_local_data_source.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/data/service/database/translation/translation_database.dart';
import 'package:quran_majeed/domain/entities/translation_entity.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  final TranslationLocalDataSource localDataSource;
  final TranslationAndTafseerRemoteDataSource remoteDataSource;
  final LocalCacheService _localCacheService;

  TranslationRepositoryImpl(
      this.localDataSource, this.remoteDataSource, this._localCacheService);

  Future<void> _downloadDatabaseFile({
    required String fileName,
    required String downloadLink,
    required void Function(int percentage) onProgress,
    required CancelToken cancelToken,
  }) async {
    try {
      await remoteDataSource.downloadDatabase(
        fileName: fileName,
        url: downloadLink,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) return;
      logErrorStatic("Error downloading file: $e", "TranslationRepositoryImpl");
    }
  }

  @override
  Future<void> getNonDefaultTranslation({
    required TTDbFileModel file,
    void Function(int percentage)? onProgress,
    required CancelToken cancelToken,
  }) async {
    final dbFile = File(await getDatabaseFilePath(file.fileName));

    if (!await dbFile.exists()) {
      await _downloadDatabaseFile(
        fileName: file.fileName,
        downloadLink: file.link,
        onProgress: onProgress!,
        cancelToken: cancelToken,
      );
    } else {
      await selectTranslation(file: file);
    }
  }

  @override
  Future<void> selectTranslation({required TTDbFileModel file}) async {
    final dbFile = File(await getDatabaseFilePath(file.fileName));
    try {
      final database = TranslationDatabase(dbFile);
      try {
        final List<TranslationEntity> verses = await database.getAllVerses();
        _addToTranslationCache(filename: file.fileName, translations: verses);
      } finally {
        await database.close();
      }
    } catch (e) {
      logErrorStatic(
          "Error accessing database: $e", "TranslationRepositoryImpl");
      rethrow;
    }
  }

  void _addToTranslationCache(
      {required List<TranslationEntity> translations,
      required String filename}) {
    if (CacheData.translationList.entries.length >= 3) {
      showMessage(message: "Cannot Select More than Three Languages");
      return;
    }

    // Initialize a structure to accumulate surahs and their ayahs
    Map<int, Map<int, String>> surahsAndAyahs = {};

    for (var translation in translations) {
      // Ensure the surah exists in the structure, or initialize its ayahs map
      surahsAndAyahs.putIfAbsent(translation.surah!, () => {});

      // Add or update the ayah within the specific surah
      surahsAndAyahs[translation.surah!]!.putIfAbsent(
          translation.ayah!,
          () =>
              translation.translation ?? "No translation found for this ayah");
    }

    // Update the cache with the structured translations for the filename
    CacheData.translationList[filename] = surahsAndAyahs;
  }

  @override
  Future<void> saveSelectedTranslations(
      Set<String> selectedTranslations) async {
    final serializedData = jsonEncode(selectedTranslations.toList());
    await _localCacheService.saveData(
        key: CacheKeys.selectedTranslations, value: serializedData);
  }

  @override
  Future<Set<String>> getSelectedTranslations() async {
    final serializedData =
        _localCacheService.getData(key: CacheKeys.selectedTranslations);
    if (serializedData != null) {
      List<dynamic> dataList = jsonDecode(serializedData);
      return Set.from(dataList.cast<String>());
    } else {
      return {};
    }
  }

  @override
  Future<void> getDefaultTranslation(TTDbFileModel file) async {
    final language = file.language == 'English' ? 'en' : 'bn';
    try {
      List<TranslationEntity> result =
          await localDataSource.getDefaultTranslationData(language: language);
      _addToTranslationCache(filename: file.fileName, translations: result);
    } catch (e) {
      logErrorStatic(
          "Error accessing database: $e", "TranslationRepositoryImpl");
    }
  }

  @override
  Future<void> deleteTranslationDatabase({required String fileName}) async {
    final dbFile = File(await getDatabaseFilePath(fileName));
    if (await dbFile.exists()) {
      try {
        await dbFile.delete();
      } catch (e) {
        logErrorStatic(
            "Error deleting database: $e", "TranslationRepositoryImpl");
        rethrow;
      }
    }
  }

  @override
  Future<List<String>> getAvailableTranslations() async {
    final availableTranslationsSerialised =
        _localCacheService.getData(key: CacheKeys.availableTranslations);
    return availableTranslationsSerialised != null
        ? _convertSerialisedStringToAvailableTranslations(
            availableTranslationsSerialised)
        : ['en_sahih', 'bn_bayaan'];
  }

  @override
  Future<void> saveAvailableTranslations(
      {required Set<String> availableTranslations,
      required String newItem}) async {
    availableTranslations.add(newItem);
    final serialisedString = jsonEncode(availableTranslations.toList());
    await _localCacheService.saveData(
        key: CacheKeys.availableTranslations, value: serialisedString);
  }

  @override
  Future<void> deleteAvailableTranslation({required TTDbFileModel file}) async {
    final availableTranslationsSerialised =
        _localCacheService.getData(key: CacheKeys.availableTranslations);
    if (availableTranslationsSerialised != null) {
      final availableTranslations =
          _convertSerialisedStringToAvailableTranslations(
              availableTranslationsSerialised);
      availableTranslations.remove(file.fileName);
      final serialisedString = jsonEncode(availableTranslations);
      await _localCacheService.saveData(
          key: CacheKeys.availableTranslations, value: serialisedString);
    }
  }

  List<String> _convertSerialisedStringToAvailableTranslations(
          String serialisedString) =>
      jsonDecode(serialisedString).cast<String>();

  @override
  Future<void> saveAvailableItemsCount(int count) async {
    await _localCacheService.saveData(
        key: 'available_items_count', value: count.toString());
  }

  @override
  Future<int> fetchAvailableItemsCount() async {
    final countString =
        _localCacheService.getData(key: 'available_items_count');

    return countString != null
        ? int.parse(countString)
        : 81; // default to 81 if not found
  }
}
