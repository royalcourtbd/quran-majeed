import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/tafseer/tafseer_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/translation_and_tafseer/translation_tafseer_remote_data_source.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/data/service/database/tafseer/tafseer_database.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_unique_tafseer_use_case.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';

class TafseerRepositoryImpl implements TafseerRepository {
  final TafseerLocalDataSource tafseerLocalDataSource;
  final TranslationAndTafseerRemoteDataSource remoteDataSource;
  final LocalCacheService localCacheService;
  final GetUniqueTafseerUseCase getUniqueTafseerUseCase;

  TafseerRepositoryImpl(
    this.tafseerLocalDataSource,
    this.remoteDataSource,
    this.localCacheService,
    this.getUniqueTafseerUseCase,
  );

  @override
  Future<Set<String>> getSelectedTafseers() async {
    final selectedTafseersSerialised =
        localCacheService.getData(key: CacheKeys.selectedTafseer);
    if (selectedTafseersSerialised == null) return {};
    final Set<String> selectedTafseers =
        Set<String>.from(jsonDecode(selectedTafseersSerialised));

    // Check if the default tafseer should be included
    final bool includeDefault =
        localCacheService.getData(key: CacheKeys.includeDefaultTafseer) ?? true;
    if (includeDefault && !selectedTafseers.contains('en_kathir')) {
      selectedTafseers.add('en_kathir');
    }

    return selectedTafseers;
  }

  @override
  Future<void> saveSelectedTafseers(Set<String> selectedTafseers) async {
    final serialisedString = jsonEncode(selectedTafseers.toList());
    await localCacheService.saveData(
        key: CacheKeys.selectedTafseer, value: serialisedString);

    // Update the flag for including the default tafseer
    final bool includeDefault = selectedTafseers.contains('en_kathir');
    await localCacheService.saveData(
        key: CacheKeys.includeDefaultTafseer, value: includeDefault);
  }

  @override
  Future<Map<int, Map<int, String>>> selectTafseer({
    required TTDbFileModel file,
    required int surahID,
    required TafseerType tafseerType,
  }) async {
    final String dbPath = await getDatabaseFilePath(file.fileName);
    final database = TafseerDatabase(File(dbPath));
    try {
      Map<int, Map<int, String>> result = {};
      switch (tafseerType) {
        case TafseerType.common:
          final List<CommonTafseerTableData> tafseer =
              await tafseerLocalDataSource.getCommonTafseerData(
                  surahID: surahID, database: database);
          result = _convertCommonTafseerToMap(tafseer);
          break;
        case TafseerType.unique:
          final List<UniqueTafseerTableData> tafseer =
              await _getUniqueTafseerData(database, surahID);
          result = _convertUniqueTafseerToMap(tafseer, surahID);
          break;
      }
      return result;
    } finally {
      await database.close();
      await TafseerDatabase.waitForClose(dbPath);
    }
  }

  Map<int, Map<int, String>> _convertCommonTafseerToMap(
      List<CommonTafseerTableData> tafseer) {
    Map<int, Map<int, String>> result = {};
    for (var item in tafseer) {
      if (item.suraId != null && item.ayahId != null) {
        result.putIfAbsent(item.suraId!, () => {}).putIfAbsent(item.ayahId!,
            () => item.tafsirText ?? "No tafseer is found for this ayah");
      }
    }
    return result;
  }

  Map<int, Map<int, String>> _convertUniqueTafseerToMap(
      List<UniqueTafseerTableData> tafseer, int surahId) {
    Map<int, Map<int, String>> result = {};
    for (var item in tafseer) {
      for (int ayahId = item.start!; ayahId <= item.end!; ayahId++) {
        result.putIfAbsent(surahId, () => {}).putIfAbsent(ayahId,
            () => item.tafsirText ?? "No tafseer is found for this ayah");
      }
    }
    return result;
  }

  Future<List<UniqueTafseerTableData>> _getUniqueTafseerData(
      TafseerDatabase database, int surahId) async {
    return getUniqueTafseerUseCase.execute(
        surahId: surahId, database: database);
  }

  @override
  List<String> getAvailableTafseers() {
    final availableeTafseersSerialised =
        localCacheService.getData(key: CacheKeys.availableTafseer) ?? "[]";
    return _convertSerialisedStringToAvailableeTafseers(
        availableeTafseersSerialised);
  }

  @override
  Future<void> saveAvailableTafseers(
      {required Set<String> availableTafseers, required String newItem}) async {
    availableTafseers.add(newItem);
    final serialisedString = jsonEncode(availableTafseers.toList());
    await localCacheService.saveData(
        key: CacheKeys.availableTafseer, value: serialisedString);
  }

  @override
  Future<void> deleteAvailableTafseer({required TTDbFileModel file}) async {
    final availableeTafseersSerialised =
        localCacheService.getData(key: CacheKeys.availableTafseer);
    if (availableeTafseersSerialised == null) return;
    final List<String> availableeTafseers =
        _convertSerialisedStringToAvailableeTafseers(
            availableeTafseersSerialised);
    availableeTafseers.remove(file.fileName);
    final String serialisedString = jsonEncode(availableeTafseers);
    await localCacheService.saveData(
        key: CacheKeys.availableTafseer, value: serialisedString);
  }

  @override
  Future<void> deleteTafseerDatabase({required String fileName}) async {
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
  Future<void> saveAvailableItemsCount(int count) async {
    await localCacheService.saveData(
        key: 'available_items_count_tafseer', value: count.toString());
  }

  @override
  Future<int> fetchAvailableItemsCount() async {
    final countString =
        localCacheService.getData(key: 'available_items_count_tafseer');
    return countString != null
        ? int.parse(countString)
        : 20; // default to 20 if not found
  }

  @override
  Future<void> moveDefaultTafseerDbToInternalStorage(
      {required String fileName}) async {
    const String assetPath = "assets/database";
    final String dbPath = "$assetPath/$fileName.db";
    final File dbFile = await getDatabaseFile(fileName: fileName);
    await moveDatabaseFromAssetToInternal(file: dbFile, assetPath: dbPath);
    localCacheService.saveData(
        key: CacheKeys.isFirstTimeInTafseerPage, value: "false");
  }

  List<String> _convertSerialisedStringToAvailableeTafseers(
          String serialisedString) =>
      jsonDecode(serialisedString).cast<String>();

  @override
  Future<Map<int, Map<int, String>>> getTafseer({
    required TTDbFileModel file,
    void Function(int percentage)? onProgress,
    required int surahID,
    required TafseerType tafseerType,
    required CancelToken cancelToken,
  }) async {
    final File dbFile = File(await getDatabaseFilePath(file.fileName));

    if (!await dbFile.exists() && !cancelToken.isCancelled) {
      await _downloadDatabaseFile(
          fileName: file.fileName,
          downloadLink: file.link,
          onProgress: onProgress!,
          cancelToken: cancelToken);
    }
    return await selectTafseer(
        file: file, surahID: surahID, tafseerType: tafseerType);
  }

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
      logErrorStatic(
          "Error downloading database file: $e", "TafseerRepositoryImpl");
    }
  }

  @override
  Future<bool> isFirstTimeInTafseerPage() {
    final isFirstTime =
        localCacheService.getData(key: CacheKeys.isFirstTimeInTafseerPage);
    return Future.value(isFirstTime == null);
  }

  @override
  Future<void> saveSelectedTabIndex(int index) async {
    await localCacheService.saveData(
        key: CacheKeys.selectedTafseerTabIndex, value: index.toString());
  }

  @override
  Future<int> getSelectedTabIndex() async {
    final selectedTabIndex =
        localCacheService.getData(key: CacheKeys.selectedTafseerTabIndex);
    return selectedTabIndex == null ? 0 : int.parse(selectedTabIndex);
  }
}
