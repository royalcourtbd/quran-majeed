import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/delete_available_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/delete_tafseer_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/determine_if_its_first_time_in_tafseer_page.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/fetch_available_tafseer_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_default_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_downloaded_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_selected_tab_index_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_selected_tafseers_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_available_tafseer_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_available_tafseer_items_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_selected_tab_index_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_selected_tafseers_use_case.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_page_ui_state.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/create_note_bottom_sheet.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/note_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/tafseer_copy_bottom_sheet.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class TafseerPresenter extends BasePresenter<TafseerPageUiState>
    with GetTickerProviderStateMixin {
  final GetDownloadedTafseerUseCase _getDownloadedTafseersUseCase;
  final GetSelectedTafseersUseCase _getSelectedTafseersUseCase;
  final GetTafseerUseCase _getTafseerUseCase;
  final SaveSelectedTafseersUseCase _saveSelectedTafseersUseCase;
  final DeleteTafseerDatabaseUseCase _deleteTafseerDatabaseUseCase;
  final DeleteAvailableTafseerUseCase _deleteAvailableTafseerUseCase;
  final SaveAvailableTafseerItemsUseCase _saveAvailableTafseersUseCase;
  final GetDefaultTafseerUseCase _getDefaultTafseerUseCase;
  final DetermineIfItsFirstTimeInTafseerPage
      _determineIfItsFirstTimeInTafseerPage;
  final SaveSelectedTabIndexUseCase _saveSelectedTabIndexUseCase;
  final GetSelectedTabIndexUseCase _getSelectedTabIndexUseCase;
  final SaveAvailableTafseerItemsCountUseCase _saveAvailableItemsCountUseCase;
  final FetchAvailableTafseerItemsCountUseCase _fetchAvailableItemsCountUseCase;
  late TabController tabController;
  final Map<String, CancelToken> _cancelTokens = {};
  final Map<String, Map<int, Map<int, String>>> _tafseerCache = {};

  TafseerPresenter(
    this._getDownloadedTafseersUseCase,
    this._getSelectedTafseersUseCase,
    this._getTafseerUseCase,
    this._saveSelectedTafseersUseCase,
    this._deleteTafseerDatabaseUseCase,
    this._deleteAvailableTafseerUseCase,
    this._saveAvailableTafseersUseCase,
    this._getDefaultTafseerUseCase,
    this._determineIfItsFirstTimeInTafseerPage,
    this._saveSelectedTabIndexUseCase,
    this._getSelectedTabIndexUseCase,
    this._saveAvailableItemsCountUseCase,
    this._fetchAvailableItemsCountUseCase,
  ) {
    tabController = TabController(length: 2, vsync: this);
    _addTabControllerListener();
  }

  void updateTabController(int length) {
    tabController.dispose();
    tabController = TabController(length: length, vsync: this);
    _addTabControllerListener();
  }

  void _addTabControllerListener() {
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        onTafseerSelected(tabController.index, 1);
      }
    });
  }

  Future<void> _saveSelectedTabIndex(int index) async {
    await _saveSelectedTabIndexUseCase.execute(index);
  }

  final Obs<TafseerPageUiState> uiState = Obs(TafseerPageUiState.empty());
  TafseerPageUiState get currentUiState => uiState.value;
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode contentFocusNode = FocusNode();
  final TranslationPresenter _translationPresenter =
      locate<TranslationPresenter>();
  final TextEditingController searchController = TextEditingController();
  final PageController pageController = PageController();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<List<TTDbFileModel>> _loadSelectedTafseers(int surahID) async {
    final selectedTafseerFileNames =
        await _getSelectedTafseersUseCase.execute();
    List<TTDbFileModel> selectedItems = [];
    for (String fileName in selectedTafseerFileNames) {
      TTDbFileModel? fileModel = uiState.value.availableItems
          .firstWhereOrNull((model) => model.fileName == fileName);
      if (fileModel != null) {
        selectedItems.add(fileModel);
        await handleTafseerSelection(fileModel, surahID);
      }
    }
    return selectedItems;
  }

  Future<TTDbFileModel?> _getDefaultTafseer() async {
    return uiState.value.availableItems
        .firstWhereOrNull((item) => item.fileName == 'en_kathir');
  }

  Future<void> _ensureDefaultTafseerSelected(int surahID) async {
    if (uiState.value.selectedItems.isEmpty) {
      final defaultTafseer = await _getDefaultTafseer();
      if (defaultTafseer != null) {
        await toggleSelection(file: defaultTafseer, surahID: surahID);
      }
    }
  }

  @override
  void onClose() {
    // Dispose the TabController when the presenter is closed
    tabController.dispose();
    super.onClose();
  }

  TTJsonModel get jsonData => _translationPresenter.jsonData;

  Future<void> onClickTafseerCopyButton(BuildContext context) async {
    await TafseerCopyBottomSheet.show(context: context);
  }

//TODO: Implement the onClickNoteOption method in tafseer page
  Future<void> onClickNoteOption(BuildContext context) async {
    await NoteOptionBottomSheet.show(
      context: context,
      onRemove: () async {},
    );
  }

  String getSurahName({required int surahId, required String currentLanguage}) {
    final surah = CacheData.surahsCache[surahId - 1];
    switch (currentLanguage) {
      case 'bn':
        return surah.nameBn;
      case 'ar':
        return surah.name;
      default:
        return surah.nameEn;
    }
  }

  Future<void> initializeData({required int surahID}) async {
    await _initializeDataAsync(surahID: surahID);
  }

  Future<void> _initializeDataAsync({required int surahID}) async {
    try {
      uiState.value = uiState.value.copyWith(isLoading: true);
      await _loadDefaultTafseerForOnce();
      await _loadTafseerData();

      await _fetchAndSetAvailableTafseers();
      await _fetchAndSetSelectedTafseers();
      await _ensureDefaultTafseerSelected(surahID);
      await _loadSelectedTabIndex(surahID);

      final int availableItemsCount =
          await _fetchAvailableItemsCountUseCase.execute();
      final List<TTDbFileModel> selectedItems =
          await _loadSelectedTafseers(surahID);

      await preloadTafseerData(surahID);
      await loadSurahTafseer(surahID: surahID);

      uiState.value = uiState.value.copyWith(
        isLoading: false,
        selectedItems: selectedItems,
        totalAvailableToDownloadItemsCount: availableItemsCount,
        activeTafseerData: selectedItems.isNotEmpty
            ? _tafseerCache[selectedItems.first.fileName]
            : null,
      );

      tabController =
          TabController(length: selectedItems.length + 1, vsync: this);
      _addTabControllerListener();

      await Future.microtask(() => onTafseerSelected(0, surahID));
    } catch (e) {
      uiState.value = uiState.value.copyWith(isLoading: false);
    }
  }

  Future<void> _loadSelectedTabIndex(int surahID) async {
    final selectedIndex = await _getSelectedTabIndexUseCase.execute();
    await onTafseerSelected(selectedIndex, surahID);
    tabController.animateTo(selectedIndex);
  }

  Future<void> preloadTafseerData(int surahID) async {
    for (var item in currentUiState.selectedItems) {
      if (!_tafseerCache.containsKey(item.fileName)) {
        await handleTafseerSelection(item, surahID);
      }
    }
  }

  Future<void> onTafseerSelected(int index, int surahID) async {
    if (index < currentUiState.selectedItems.length) {
      uiState.value =
          uiState.value.copyWith(isTabChanged: true, isLoading: true);
      await handleTafseerSelection(
          currentUiState.selectedItems[index], surahID);
      uiState.value = uiState.value.copyWith(
        activeTabIndex: index,
        isLoading: false,
        activeTafseerData:
            _tafseerCache[currentUiState.selectedItems[index].fileName],
      );
      await _saveSelectedTabIndex(tabController.index);
      tabController.animateTo(index);
    }
  }

  String getSelectedTafsirFileLanguage() {
    if (currentUiState.selectedItems.isEmpty ||
        currentUiState.selectedItems.length <= currentUiState.activeTabIndex) {
      return ''; // Return an empty string or a default value if the condition is met
    }
    return currentUiState.selectedItems[currentUiState.activeTabIndex].language;
  }

  Future<void> closeTab(int index, int surahID) async {
    if (index < currentUiState.selectedItems.length) {
      final List<TTDbFileModel> updatedList =
          List<TTDbFileModel>.from(currentUiState.selectedItems);
      updatedList.removeAt(index);
      uiState.value = currentUiState.copyWith(selectedItems: updatedList);
      updateTabController(updatedList.length + 1);
      final newIndex = (index == 0 || updatedList.isEmpty) ? 0 : index - 1;
      await onTafseerSelected(newIndex, surahID);
      await updateSelectedTafseersCache();
    }
  }

  String getTafsirText(int surahID, int ayahID) {
    final Map<String, Map<int, Map<int, String>>> tafsirCache =
        CacheData.tafseerCache;
    if (currentUiState.selectedItems.isEmpty ||
        tabController.index >= currentUiState.selectedItems.length) {
      return 'No tafseer is found for this ayah';
    }
    final String selectedFileName =
        currentUiState.selectedItems[tabController.index].fileName;
    final String? tafsirText = tafsirCache[selectedFileName]?[surahID]?[ayahID];
    return (getSelectedTafsirFileLanguage() == 'Arabic'
            ? tafsirText ?? 'No tafseer is found for this ayah'
            : formatArabicText(tafsirText.toString()))
        .toString();
  }

  bool isAlreadyDownloaded(TTDbFileModel model) {
    return currentUiState.availableItems
        .any((item) => item.fileName == model.fileName);
  }

  bool isShowDeleteButton(TTDbFileModel file) {
    return !['bn_fmazid', 'en_kathir'].contains(file.fileName);
  }

  Future<void> deleteItem(TTDbFileModel file) async {
    try {
      await _deleteTafseerDatabaseUseCase.execute(fileName: file.fileName);
      await removeTafseerFromAvailableList(file);

      final List<TTDbFileModel> newAvailableItems =
          List<TTDbFileModel>.from(currentUiState.availableItems)..remove(file);
      final List<TTDbFileModel> newSelectedItems =
          List<TTDbFileModel>.from(currentUiState.selectedItems)
            ..removeWhere((item) => item.fileName == file.fileName);

      uiState.value = currentUiState.copyWith(
        availableItems: newAvailableItems,
        selectedItems: newSelectedItems,
      );

      // Update tab controller
      updateTabController(newSelectedItems.length + 1);

      // Increment the available items count
      uiState.value = uiState.value.copyWith(
          totalAvailableToDownloadItemsCount:
              uiState.value.totalAvailableToDownloadItemsCount + 1);

      // Save the updated count
      await _saveAvailableItemsCountUseCase
          .execute(uiState.value.totalAvailableToDownloadItemsCount);

      // Update selected tafseers cache
      await updateSelectedTafseersCache();
    } catch (e) {
      logErrorStatic("Error deleting tafseer: $e", "TafseerPresenter");
    }
  }

  void _updateAvailableAndDownloadableItems(Set<String> availableTafseersSet) {
    final List<TTDbFileModel> downloadedModels = jsonData.tafsir.values
        .expand((models) => models)
        .where((model) => availableTafseersSet.contains(model.fileName))
        .toList();

    uiState.value = uiState.value.copyWith(
      availableItems: downloadedModels,
      downloadableItems:
          _getDownloadableTafseers(jsonData.tafsir, downloadedModels),
    );
  }

  Future<void> removeTafseerFromAvailableList(TTDbFileModel file) async {
    final List<String> currentAvailableTafseers =
        await _getDownloadedTafseersUseCase.execute();

    final Set<String> availableTafseersSet = currentAvailableTafseers.toSet()
      ..remove(file.fileName);

    await _deleteAvailableTafseerUseCase.execute(file: file);
    _updateAvailableAndDownloadableItems(availableTafseersSet);
  }

  String formatArabicText(String input) {
    return input.splitMapJoin(
      RegExp(r"[(|\u0600-\u06EF ]+[\u0600-\u06EF|)]+"),
      onMatch: (m) {
        if (m.group(0)!.length > 10) {
          return '<longer><br>${m.group(0)}<br></longer>';
        } else {
          return '<span>${m.group(0)}</span>';
        }
      },
    ).replaceAll("""

""", '<br>');
  }

  Future<void> toggleSelection(
      {required TTDbFileModel file, int? surahID}) async {
    List<TTDbFileModel> updatedList =
        List<TTDbFileModel>.from(uiState.value.selectedItems);
    bool isSelected = updatedList.any((item) => item.fileName == file.fileName);

    if (isSelected && updatedList.length > 1) {
      updatedList.removeWhere((item) => item.fileName == file.fileName);
      _tafseerCache.remove(file.fileName);
      CacheData.tafseerCache.remove(file.fileName);
    } else if (!isSelected && updatedList.length < 5) {
      updatedList.add(file);
    } else if (isSelected && updatedList.length == 1) {
      addUserMessage("At least one tafseer must be selected.");
      return;
    } else if (updatedList.length >= 5) {
      addUserMessage("Maximum of 5 tafseers can be selected.");
      return;
    }

    uiState.value = uiState.value.copyWith(selectedItems: updatedList);
    updateTabController(updatedList.length + 1);
    if (!isSelected && surahID != null) {
      await handleTafseerSelection(file, surahID);
    }

    if (tabController.index >= updatedList.length) {
      tabController.animateTo(updatedList.length - 1);
    }

    if (surahID != null) {
      await onTafseerSelected(tabController.index, surahID);
    }

    await updateSelectedTafseersCache();
  }

  Future<void> showComingSoonMessage() async {
    await addUserMessage("Coming Soon");
  }

  Future<void> loadSurahTafseer({required int surahID}) async {
    uiState.value = uiState.value.copyWith(isLoading: true);
    try {
      for (var item in currentUiState.selectedItems) {
        final Either<String, Map<int, Map<int, String>>> result =
            await _getTafseerUseCase.execute(
          file: item,
          surahID: surahID,
          tafseerType: _determineTafseerType(item),
          cancelToken: _addCancelToken(item),
        );
        result.fold(
          (error) {
            addUserMessage(error);
            logErrorStatic("Error loading tafseer: $error", "TafseerPresenter");
          },
          (tafseerData) {
            if (tafseerData.isNotEmpty) {
              CacheData.tafseerCache[item.fileName] = tafseerData;
            } else {
              addUserMessage("No tafseer data available for ${item.name}");
            }
          },
        );
      }
    } catch (e) {
      logErrorStatic("Error loading surah tafseer: $e", "TafseerPresenter");
      addUserMessage("Failed to load surah tafseer. Please try again.");
    } finally {
      uiState.value = uiState.value.copyWith(isLoading: false);
    }
  }

  Future<void> handleTafseerSelection(TTDbFileModel file, int surahID) async {
    try {
      if (!_tafseerCache.containsKey(file.fileName) ||
          CacheData.tafseerCache[file.fileName] == null) {
        final Either<String, Map<int, Map<int, String>>> result =
            await _getTafseerUseCase.execute(
          file: file,
          surahID: surahID,
          tafseerType: _determineTafseerType(file),
          cancelToken: _addCancelToken(file),
        );
        result.fold(
          (error) {
            addUserMessage(error);
          },
          (tafseerData) {
            _tafseerCache[file.fileName] = tafseerData;
            CacheData.tafseerCache[file.fileName] = tafseerData;
          },
        );
      }
      uiState.value = uiState.value.copyWith(
        activeTafseerData: _tafseerCache[file.fileName],
      );
    } catch (e) {
      logErrorStatic("Error loading tafseer: $e", "TafseerPresenter");
      addUserMessage("Failed to load tafseer. Please try again.");
      uiState.value = uiState.value.copyWith(isLoading: false);
    }
  }

  TafseerType _determineTafseerType(TTDbFileModel file) {
    return ['bn_tafsir_kathir_mujibor', 'bn_fmazid', 'bn_kathir']
            .contains(file.fileName)
        ? TafseerType.unique
        : TafseerType.common;
  }

  Future<void> _fetchAndSetSelectedTafseers() async {
    final Set<String> selectedTafseerFileNames =
        await _getSelectedTafseersUseCase.execute();
    List<TTDbFileModel> selectedItems = [];

    for (String fileName in selectedTafseerFileNames) {
      TTDbFileModel? fileModel = jsonData.tafsir.values
          .expand((models) => models)
          .firstWhereOrNull((model) => model.fileName == fileName);

      if (fileModel != null) {
        selectedItems.add(fileModel);
      }
    }

    uiState.value = uiState.value.copyWith(selectedItems: selectedItems);
    await updateSelectedTafseersCache();
  }

  bool isSelected(TTDbFileModel file) {
    return currentUiState.selectedItems.contains(file);
  }

  Future<void> updateSelectedTafseersCache() async {
    final Set<String> selectedTafseers =
        uiState.value.selectedItems.map((e) => e.fileName).toSet();
    await _saveSelectedTafseersUseCase.execute(selectedTafseers);
  }

  Future<void> _loadDefaultTafseerForOnce() async {
    final bool isFirstTime =
        await _determineIfItsFirstTimeInTafseerPage.execute();

    if (!isFirstTime) return;
    List<String> defaultTafseers = ['bn_fmazid', 'en_kathir'];
    for (String fileName in defaultTafseers) {
      try {
        await _getDefaultTafseerUseCase
            .execute(fileName: fileName)
            .whenComplete(() async {
          await addTafseerToAvailableList(fileName);
          final List<String> currentAvailableTaafseers =
              await _getDownloadedTafseersUseCase.execute();

          _updateAvailableAndDownloadableItems(
              currentAvailableTaafseers.toSet());
        });
      } catch (e) {
        logErrorStatic("Error loading tafseer: $e", "TafseerPresenter");
      }
    }
  }

  Future<void> _loadTafseer(TTDbFileModel file) async {
    try {
      final bool isUniqueTafseer = [
        'bn_tafsir_kathir_mujibor',
        'bn_fmazid',
        'bn_kathir'
      ].contains(file.fileName);
      uiState.value = uiState.value
          .copyWith(isDownloading: true, activeDownloadId: file.fileName);
      CancelToken cancelToken = _addCancelToken(file);
      await _getTafseerUseCase
          .execute(
              file: file,
              surahID: 1,
              cancelToken: cancelToken,
              tafseerType:
                  isUniqueTafseer ? TafseerType.unique : TafseerType.common,
              onProgress: (percentage) => uiState.value =
                  uiState.value.copyWith(downloadProgress: percentage))
          .whenComplete(() async {
        if (!_cancelTokens[file.fileName]!.isCancelled) {
          await addTafseerToAvailableList(file.fileName);
          final List<String> currentAvailableTaafseers =
              await _getDownloadedTafseersUseCase.execute();
          _updateAvailableAndDownloadableItems(
              currentAvailableTaafseers.toSet());

          // Decrement the available items count
          uiState.value = uiState.value.copyWith(
              totalAvailableToDownloadItemsCount:
                  uiState.value.totalAvailableToDownloadItemsCount - 1);
          // Save the updated count
          await _saveAvailableItemsCountUseCase
              .execute(uiState.value.totalAvailableToDownloadItemsCount);
        }
      });
    } catch (e) {
      if (CancelToken.isCancel(
        e as DioException,
      )) {
        addUserMessage("Download cancelled");
      } else {
        logErrorStatic("Error loading tafseer: $e", "TafseerPresenter");
      }
    } finally {
      _cancelTokens.remove(file.fileName);
      uiState.value = uiState.value.copyWith(
          isDownloading: false, activeDownloadId: null, downloadProgress: 0);
    }
  }

  Future<void> addTafseerToAvailableList(String fileName) async {
    final List<String> currentAvailableTafseers =
        await _getDownloadedTafseersUseCase.execute();
    final Set<String> availableTafseersSet = currentAvailableTafseers.toSet()
      ..add(fileName);
    await _saveAvailableTafseersUseCase.execute(
        availableTafseers: availableTafseersSet, newItem: fileName);
    _updateAvailableAndDownloadableItems(availableTafseersSet);
  }

  Future<void> _fetchAndSetAvailableTafseers() async {
    final List<String> currentAvailableTafseers =
        await _getDownloadedTafseersUseCase.execute();
    final Set<String> availableTafseersSet = currentAvailableTafseers.toSet();

    if (jsonData.tafsir.isNotEmpty) {
      _updateAvailableAndDownloadableItems(availableTafseersSet);
    } else {
      uiState.value =
          uiState.value.copyWith(userMessage: "No tafseer data available.");
    }
  }

  CancelToken _addCancelToken(TTDbFileModel file) {
    final CancelToken cancelToken = CancelToken();
    _cancelTokens[file.fileName] = cancelToken;
    return cancelToken;
  }

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
      return _loadTafseer(file);
    } else if (languageKey != null) {
      return _downloadTafseersByLanguage(languageKey);
    } else {
      logErrorStatic("Invalid download request", "TafseerPresenter");
    }
  }

  Future<void> _downloadTafseersByLanguage(String languageKey) async {
    uiState.value = uiState.value.copyWith(isAllFilesDownloading: true);
    List<TTDbFileModel> modelsToDownload = jsonData.tafsir[languageKey] ?? [];

    for (var model in modelsToDownload) {
      if (!isAlreadyDownloaded(model)) {
        await _loadTafseer(model);
      }
    }
    uiState.value = uiState.value.copyWith(isAllFilesDownloading: false);
  }

  List<MapEntry<String, List<TTDbFileModel>>> _getDownloadableTafseers(
      Map<String, List<TTDbFileModel>> allTafseers,
      List<TTDbFileModel> downloadedModels) {
    final List<TTDbFileModel> allItems =
        allTafseers.values.expand((models) => models).toList();
    final Set<String> downloadedFileNames =
        downloadedModels.map((model) => model.fileName).toSet();
    final List<TTDbFileModel> downloadableItems = allItems
        .where((model) => !downloadedFileNames.contains(model.fileName))
        .toList();

    return allTafseers.entries
        .map((entry) => MapEntry(
            entry.key,
            entry.value
                .where((model) => downloadableItems.contains(model))
                .toList()))
        .toList();
  }

  void cancelDownload() {
    _cancelTokens[currentUiState.activeDownloadId]?.cancel();
  }

  bool isFileDownloading(String fileId) {
    return currentUiState.isDownloading &&
        currentUiState.activeDownloadId == fileId;
  }

  Future<void> _loadTafseerData() async {
    if (currentUiState.totalSizes.isNotEmpty) return;

    List<double> totalSize = [];
    for (MapEntry<String, List<TTDbFileModel>> entry
        in jsonData.tafsir.entries) {
      double sizes = 0.0;
      for (TTDbFileModel model in entry.value) {
        sizes += double.parse(model.size);
      }
      totalSize.add(double.parse(sizes.toStringAsFixed(2)));
    }
    // Simulating the calculation time, replace with actual calculation
    uiState.value = uiState.value.copyWith(
      totalSizes: totalSize,
    );
  }

  bool isTafseerSelected(TTDbFileModel file) {
    return false;
  }

  int getTotalItemsCount(
      List<MapEntry<String, List<TTDbFileModel>>> totalItems) {
    return 0;
  }

  Future<void> onClickNoteCreate(BuildContext context, bool isEditNote) async {
    await CreateNoteBottomSheet.show(
      context: context,
      isEditNot: isEditNote,
    );
  }

  Future<void> onClickTafseerPageMoreButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    required bool isDirectButtonVisible,
    required bool isAddMemorizationButtonVisible,
    required bool idAddCollectionButtonVisible,
  }) async {
    await MoreOptionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      isDirectButtonVisible: true,
      isAddMemorizationButtonVisible: false,
      idAddCollectionButtonVisible: true,
      isFromTafseer: true,
    );
  }

  @override
  Future<void> addUserMessage(String message) async {
    showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = uiState.value.copyWith(isLoading: loading);
  }
}

enum TafseerType {
  unique,
  common,
}
