import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/use_cases/translation/delete_available_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/delete_translation_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/fetch_available_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_default_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_downloaded_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_non_default_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_selected_translations_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_translation_and_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_available_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_available_translation_items_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_selected_translations_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/select_translation_use_case.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_ui_state.dart';

class TranslationPresenter extends BasePresenter<TranslationUiState> {
  TranslationPresenter(
    this._getNonDefaultTranslationUseCase,
    this._getDefaultTranslationUseCase,
    this._getTranslationAndTafseerUseCase,
    this._getDownloadedTranslationsUseCase,
    this._saveAvailableTranslationItemsUseCase,
    this._selectTranslationUseCase,
    this._deleteTranslationDatabaseUseCase,
    this._deleteAvailableTranslationUseCase,
    this._getSelectedTranslationsUseCase,
    this._saveSelectedTranslationsUseCase,
    this._saveAvailableItemsCountUseCase,
    this._fetchAvailableItemsCountUseCase,
  );

  final Obs<TranslationUiState> uiState = Obs(TranslationUiState.empty());

  TranslationUiState get currentUiState => uiState.value;

  final GetNonDefaultTranslationUseCase _getNonDefaultTranslationUseCase;
  final GetDefaultTranslationUseCase _getDefaultTranslationUseCase;
  final GetTranslationAndTafseerUseCase _getTranslationAndTafseerUseCase;
  final GetDownloadedTranslationsUseCase _getDownloadedTranslationsUseCase;
  final SaveAvailableTranslationItemsUseCase
      _saveAvailableTranslationItemsUseCase;
  final SelectTranslationUseCase _selectTranslationUseCase;
  final DeleteTranslationDatabaseUseCase _deleteTranslationDatabaseUseCase;
  final DeleteAvailableTranslationUseCase _deleteAvailableTranslationUseCase;
  final GetSelectedTranslationsUseCase _getSelectedTranslationsUseCase;
  final SaveSelectedTranslationsUseCase _saveSelectedTranslationsUseCase;
  final SaveAvailableItemsCountUseCase _saveAvailableItemsCountUseCase;
  final FetchAvailableItemsCountUseCase _fetchAvailableItemsCountUseCase;
  final TextEditingController searchController = TextEditingController();
  final Map<String, CancelToken> _cancelTokens = {};

  @override
  Future<void> onInit() async {
    await initializeData();
    super.onInit();
  }

  Future<void> initializeData() async {
    uiState.value = uiState.value.copyWith(isLoading: true);

    try {
      await _loadTranslationData();

      await _fetchAndSetAvailableTranslations();

      await _fetchAndSetSelectedTranslations();

      // Set the totalAvailableToDownloadItemsCount based on the stored count

      final int availableItemsCount =
          await _fetchAvailableItemsCountUseCase.execute();

      uiState.value = uiState.value
          .copyWith(totalAvailableToDownloadItemsCount: availableItemsCount);
    } catch (e) {
      uiState.value = uiState.value.copyWith(
          userMessage: "Initialization failed: ${e.toString()}",
          isLoading: false);
    }
  }

  CancelToken _addCancelToken(TTDbFileModel file) {
    final CancelToken cancelToken = CancelToken();
    _cancelTokens[file.fileName] = cancelToken;
    return cancelToken;
  }

  void cancelDownload() {
    _cancelTokens[currentUiState.activeDownloadId]?.cancel();
  }

  Future<void> _fetchAndSetSelectedTranslations() async {
    final Set<String> selectedTranslationFileNames =
        await _getSelectedTranslationsUseCase.execute();
    List<TTDbFileModel> selectedItems = [];

    if (selectedTranslationFileNames.isEmpty) {
      // Set default translation if none selected
      final TTDbFileModel? defaultTranslation = _getDefaultTranslation();
      if (defaultTranslation != null) {
        selectedItems.add(defaultTranslation);
        await _loadTranslation(defaultTranslation);
        await _saveSelectedTranslationsUseCase
            .execute({defaultTranslation.fileName});
      }
    } else {
      for (String fileName in selectedTranslationFileNames) {
        TTDbFileModel? fileModel = currentUiState.jsonData.trans.values
            .expand((models) => models)
            .firstWhereOrNull((model) => model.fileName == fileName);

        if (fileModel != null) {
          selectedItems.add(fileModel);
          await _loadTranslation(fileModel);
        }
      }
    }

    uiState.value = uiState.value.copyWith(selectedItems: selectedItems);
    await updateSelectedTranslationsCache();
  }

  TTDbFileModel? _getDefaultTranslation() {
    return currentUiState.jsonData.trans.values
        .expand((models) => models)
        .firstWhereOrNull((model) => model.fileName == 'en_sahih');
  }

  Future<void> _loadTranslation(TTDbFileModel file) async {
    final bool isDefaultTranslation =
        ['bn_bayaan', 'en_sahih'].contains(file.fileName);
    if (isDefaultTranslation) {
      await _getDefaultTranslationUseCase.execute(file);
    } else {
      await _getNonDefaultTranslationUseCase.execute(
        file: file,
        cancelToken: _addCancelToken(file),
      );
    }
  }

  Future<void> updateSelectedTranslationsCache() async {
    final Set<String> selectedTranslations =
        currentUiState.selectedItems.map((e) => e.fileName).toSet();
    await _saveSelectedTranslationsUseCase.execute(selectedTranslations);
  }

  Future<void> _loadTranslationData() async {
    final Either<String, TTJsonModel> result =
        await _getTranslationAndTafseerUseCase.execute();
    result.fold(
        (failure) => uiState.value = uiState.value.copyWith(
              userMessage: failure,
              isLoading: false,
            ), (jsonData) {
      List<double> totalSize = [];
      for (MapEntry<String, List<TTDbFileModel>> entry
          in jsonData.trans.entries) {
        double sizes = 0.0;
        for (TTDbFileModel model in entry.value) {
          sizes += double.parse(model.size);
        }
        totalSize.add(double.parse(sizes.toStringAsFixed(2)));
      }
      return uiState.value = uiState.value.copyWith(
        jsonData: jsonData,
        isLoading: false,
        totalSizes: totalSize,
      );
    });
  }

  TTJsonModel get jsonData => currentUiState.jsonData;

  bool isAlreadyDownloaded(TTDbFileModel model) {
    return currentUiState.availableItems
        .any((item) => item.fileName == model.fileName);
  }

  Future<void> _fetchAndSetAvailableTranslations() async {
    final List<String> currentAvailableTranslations =
        await _getDownloadedTranslationsUseCase.execute();
    final Set<String> availableTranslationsSet =
        currentAvailableTranslations.toSet();

    if (uiState.value.jsonData.trans.isNotEmpty) {
      _updateAvailableAndDownloadableItems(availableTranslationsSet);
    } else {
      uiState.value = uiState.value.copyWith(
          userMessage: "No translation data available.", isLoading: false);
    }
  }

  bool isShowDeleteButton(TTDbFileModel file) {
    return !['bn_bayaan', 'en_sahih'].contains(file.fileName);
  }

  Future<void> deleteItem(TTDbFileModel file) async {
    try {
      await _deleteTranslationDatabaseUseCase.execute(fileName: file.fileName);
      await removeTranslationFromAvailableList(file);
      final List<TTDbFileModel> newList =
          List<TTDbFileModel>.from(currentUiState.availableItems)..remove(file);
      toggleSelection(file: file);

      _updateAvailableAndDownloadableItems(
          (await _getDownloadedTranslationsUseCase.execute()).toSet());
      uiState.value = currentUiState.copyWith(
        availableItems: newList,
        selectedItems: currentUiState.selectedItems
            .where((element) => element.fileName != file.fileName)
            .toList(),
      );
      // Increment the available items count
      uiState.value = uiState.value.copyWith(
          totalAvailableToDownloadItemsCount:
              uiState.value.totalAvailableToDownloadItemsCount + 1);
      // Save the updated count
      await _saveAvailableItemsCountUseCase
          .execute(uiState.value.totalAvailableToDownloadItemsCount);
      _updateAvailableAndDownloadableItems(
          (await _getDownloadedTranslationsUseCase.execute()).toSet());
    } catch (e) {
      logErrorStatic("Error deleting translation: $e", "TranslationPresenter");
    }
  }

  void _updateAvailableAndDownloadableItems(
      Set<String> availableTranslationsSet) {
    final List<TTDbFileModel> downloadedModels = uiState
        .value.jsonData.trans.values
        .expand((models) => models)
        .where((model) => availableTranslationsSet.contains(model.fileName))
        .toList();

    uiState.value = uiState.value.copyWith(
        availableItems: downloadedModels,
        downloadableItems: _getDownloadableTranslations(
            uiState.value.jsonData.trans, downloadedModels),
        isLoading: false);
  }

  List<MapEntry<String, List<TTDbFileModel>>> _getDownloadableTranslations(
      Map<String, List<TTDbFileModel>> allTranslations,
      List<TTDbFileModel> downloadedModels) {
    final List<TTDbFileModel> allItems =
        allTranslations.values.expand((models) => models).toList();
    final Set<String> downloadedFileNames =
        downloadedModels.map((item) => item.fileName).toSet();
    final List<TTDbFileModel> downloadableItems = allItems
        .where((model) => !downloadedFileNames.contains(model.fileName))
        .toList();

    return allTranslations.entries
        .map((entry) => MapEntry(
            entry.key,
            entry.value
                .where((model) => downloadableItems.contains(model))
                .toList()))
        .toList();
  }

  bool isFileDownloading(String fileId) {
    return currentUiState.isDownloading &&
        currentUiState.activeDownloadId == fileId;
  }

  bool isTranslationSelected(TTDbFileModel file) {
    return currentUiState.selectedItems.contains(file);
  }

  /// Initiates download for a single translation or all translations by language.
  ///
  /// - If a [file] is provided, downloads that specific translation.
  /// - If a [languageKey] is provided, downloads all translations for that language.
  Future<void> initiateDownload(
      {TTDbFileModel? file, String? languageKey}) async {
    if (currentUiState.isDownloading) {
      if (file != null && currentUiState.activeDownloadId == file.fileName) {
        cancelDownload();
        return addUserMessage("Download Cancelled.");
      } else {
        return addUserMessage(
            "Please wait for the current download to finish.");
      }
    } else if (file != null) {
      return _downloadAndLoadTranslation(file);
    } else if (languageKey != null) {
      return _downloadTranslationsByLanguage(languageKey);
    } else {
      logErrorStatic("initiateDownload called without required parameters",
          "TranslationPresenter");
    }
  }

  Future<void> showComingSoonMessage() async {
    await addUserMessage("Coming Soon");
  }

  Future<void> _downloadAndLoadTranslation(TTDbFileModel file) async {
    try {
      uiState.value = uiState.value.copyWith(
        isDownloading: true,
        activeDownloadId: file.fileName,
      );

      await _getNonDefaultTranslationUseCase
          .execute(
              file: file,
              cancelToken: _addCancelToken(file),
              onProgress: (percentage) {
                uiState.value =
                    uiState.value.copyWith(downloadProgress: percentage);
              })
          .whenComplete(() async {
        if (!_cancelTokens[file.fileName]!.isCancelled) {
          await addTranslationToAvailableList(file.fileName);
          // Decrement the available items count
          uiState.value = uiState.value.copyWith(
              totalAvailableToDownloadItemsCount:
                  uiState.value.totalAvailableToDownloadItemsCount - 1);
          // Save the updated count
          await _saveAvailableItemsCountUseCase
              .execute(uiState.value.totalAvailableToDownloadItemsCount);
          // Call the update method to ensure the UI state is refreshed
          final List<String> currentAvailableTranslations =
              await _getDownloadedTranslationsUseCase.execute();
          _updateAvailableAndDownloadableItems(
              currentAvailableTranslations.toSet());
        }
      });
    } catch (e) {
      logErrorStatic("Error loading translation: $e", "TranslationPresenter");
    } finally {
      uiState.value = uiState.value.copyWith(
          isDownloading: false, activeDownloadId: null, downloadProgress: 0);
    }
  }

  Future<void> _downloadTranslationsByLanguage(String languageKey) async {
    List<TTDbFileModel> modelsToDownload =
        currentUiState.jsonData.trans[languageKey] ?? [];
    uiState.value = uiState.value.copyWith(isAllFilesDownloading: true);
    for (var model in modelsToDownload) {
      if (!isAlreadyDownloaded(model)) {
        await _downloadAndLoadTranslation(model);
      }
    }
    uiState.value = uiState.value.copyWith(isAllFilesDownloading: false);
  }

  String getTranslationText(String fileName, int surahID, int ayahIndex) {
    return CacheData.translationList[fileName]?[surahID]?[ayahIndex] ??
        "Translation not available";
  }

  bool isSelected(TTDbFileModel file) {
    return currentUiState.selectedItems.contains(file);
  }

  // Method to get translations not yet downloaded for a given language
  List<TTDbFileModel> getUndownloadedTranslationsForLanguage(
      String languageKey) {
    // Assuming `jsonData` contains all available translations
    // and `currentUiState` knows about all downloaded ones
    List<TTDbFileModel> allTranslationsForLanguage =
        currentUiState.jsonData.trans[languageKey] ?? [];
    return allTranslationsForLanguage
        .where((model) => !isAlreadyDownloaded(model))
        .toList();
  }

  void toggleSelection({required TTDbFileModel file, int? surahID}) async {
    // Toggle selection status
    bool isSelected = currentUiState.selectedItems.contains(file);
    List<TTDbFileModel> updatedList =
        List<TTDbFileModel>.from(currentUiState.selectedItems);

    if (isSelected) {
      // Deselect if already selected
      updatedList.remove(file);
      CacheData.translationList.remove(file.fileName);
    } else if (updatedList.length < 3) {
      // Add to selection if limit not reached
      updatedList.add(file);
      await handleTranslationSelection(file);
    } else {
      // Inform user about the selection limit
      addUserMessage("Maximum of 3 translations can be selected.");
      return; // Early return to avoid unnecessary state update
    }

    // Update UI state
    uiState.value = uiState.value.copyWith(selectedItems: updatedList);
    await updateSelectedTranslationsCache(); // Update the cache with the new selection
  }

  Future<void> handleTranslationSelection(TTDbFileModel file) async {
    // Process translation selection based on whether it's a default translation
    final bool isDefaultTranslation =
        ['bn_bayaan', 'en_sahih'].contains(file.fileName);
    if (isDefaultTranslation) {
      await _getDefaultTranslationUseCase.execute(file);
    } else {
      await _selectTranslation(
          file: file); // Use your existing repository method
    }
  }

  Future<void> _selectTranslation({required TTDbFileModel file}) async {
    final Either<String, void> result =
        await _selectTranslationUseCase.execute(file: file);
    result.fold(
      (failure) => uiState.value = uiState.value.copyWith(userMessage: failure),
      (_) => uiState.value = uiState.value
          .copyWith(userMessage: "Translation selected successfully."),
    );
  }

  Future<void> addTranslationToAvailableList(String newItem) async {
    final List<String> currentAvailableTranslations =
        await _getDownloadedTranslationsUseCase.execute();
    final Set<String> availableTranslationsSet =
        currentAvailableTranslations.toSet()..add(newItem);
    await _saveAvailableTranslationItemsUseCase.execute(
        availableTranslations: availableTranslationsSet, newItem: newItem);
    _updateAvailableAndDownloadableItems(availableTranslationsSet);
  }

  Future<void> removeTranslationFromAvailableList(TTDbFileModel file) async {
    final List<String> currentAvailableTranslations =
        await _getDownloadedTranslationsUseCase.execute();

    final Set<String> availableTranslationsSet =
        currentAvailableTranslations.toSet()..remove(file.fileName);

    await _deleteAvailableTranslationUseCase.execute(file: file);
    _updateAvailableAndDownloadableItems(availableTranslationsSet);
  }

  bool isDefaultTranslation(String fileName) {
    return !['bn_bayaan', 'en_sahih'].contains(fileName);
  }

  @override
  Future<void> addUserMessage(String message) async =>
      showMessage(message: message);
  @override
  Future<void> toggleLoading({required bool loading}) async =>
      uiState.value = uiState.value.copyWith(isLoading: loading);
}
