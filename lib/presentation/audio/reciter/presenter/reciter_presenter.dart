import 'package:dio/dio.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/use_cases/audio/delete_audio_by_surah_and_reciter.dart';
import 'package:quran_majeed/domain/use_cases/audio/download_and_save_audio_location_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/fetch_audio_files_and_verse_timings_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/get_surah_ids_for_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/manage_reciters_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/manage_selected_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/save_download_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/get_reciters_from_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/save_reciter_with_surah_id_use_case.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_ui_state.dart';

class ReciterPresenter extends BasePresenter<ReciterUiState> {
  final GetRecitersFromDatabaseUseCase _getRecitersFromDatabaseUseCase;
  final DownloadAndSaveAudioLocationUseCase _downloadAndSaveAudioLocationUseCase;
  final ManageRecitersUseCase _manageRecitersUseCase;
  final SaveDownloadCountUseCase _saveDownloadCountUseCase;
  final ManageSelectedReciterUseCase _manageSelectedReciterUseCase;
  final SaveReciterWithSurahIdUseCase _saveReciterWithSurahIdUseCase;
  final GetSurahIdsForReciterUseCase _getSurahIdsForReciterUseCase;
  final FetchAudioFilesAndVerseTimingsUseCase _fetchAudioFilesAndVerseTimingsUseCase;
  final DeleteAudioBySurahAndReciter _deleteAudioBySurahAndReciter;

  ReciterPresenter(
    this._getRecitersFromDatabaseUseCase,
    this._downloadAndSaveAudioLocationUseCase,
    this._manageRecitersUseCase,
    this._saveDownloadCountUseCase,
    this._manageSelectedReciterUseCase,
    this._saveReciterWithSurahIdUseCase,
    this._getSurahIdsForReciterUseCase,
    this._fetchAudioFilesAndVerseTimingsUseCase,
    this._deleteAudioBySurahAndReciter,
  );

  final Obs<ReciterUiState> uiState = Obs(ReciterUiState.empty());

  ReciterUiState get currentUiState => uiState.value;

  Future<void> downloadSurahAudio(int surahIndex, Reciter reciter) async {
    if (currentUiState.isDownloading!) {
      cancelDownload();
      return;
    }

    _initializeDownloadProcess();
    await fetchAudioFilesAndVerseTimings([surahIndex], reciter);
    updateUiState(isDownloading: true, currentDownloadingSurahIndex: surahIndex);
    final result = await _downloadAndSaveAudioLocationUseCase.execute(
      surahID: surahIndex,
      reciter: reciter,
      onProgress: updateDownloadProgress,
      cancelToken: currentUiState.downloadCancelToken!,
    );

    await result.fold(
      (failure) => processDownloadFailure(),
      (_) async {
        if (!currentUiState.downloadCancelToken!.isCancelled) {
          await processDownloadSuccess(reciter);
          await loadDownloadCounts(); // Reload counts after successful download
        }
      },
    );
  }

  Future<void> deleteAudioFilesBySurahAndReciter({required int surahId, required Reciter reciter}) async {
    final result = await _deleteAudioBySurahAndReciter.execute(
      surahId: surahId,
      reciter: reciter,
    );
    await result.fold(
      (failure) async => await addUserMessage(failure),
      (_) async {
        await addUserMessage('Audio deleted successfully');
        await updateDownloadCountsAndReciters(reciter, surahId, isDelete: true);
      },
    );
  }

  void updateDownloadProgress(int percentage) {
    updateUiState(downloadProgress: percentage);
  }

  Future<void> processDownloadFailure() async {
    addUserMessage('Failed to download surah');
    updateUiState(isDownloading: false);
  }

  Future<void> processDownloadSuccess(Reciter reciter) async {
    addUserMessage('Surah downloaded successfully');
    await updateDownloadCountsAndReciters(reciter, currentUiState.currentDownloadingSurahIndex!);
    updateUiState(isDownloading: false, downloadProgress: 0);
  }

  void _initializeDownloadProcess() {
    uiState.value = currentUiState.copyWith(downloadCancelToken: CancelToken());
  }

  void cancelDownload() {
    if (currentUiState.downloadCancelToken != null && !currentUiState.downloadCancelToken!.isCancelled) {
      currentUiState.downloadCancelToken!.cancel("Download canceled");
      // Reset the token immediately after cancellation
      uiState.value = uiState.value.copyWith(
        isDownloading: false,
        downloadProgress: 0,
        currentDownloadingSurahIndex: null,
        downloadCancelToken: null,
      );
    }
  }

  Future<void> fetchAudioFilesAndVerseTimings(List<int> totalSurahs, Reciter reciter) async {
    await _fetchAudioFilesAndVerseTimingsUseCase.execute(totalSurahs, reciter);
  }

  Future<void> updateDownloadCountsAndReciters(Reciter reciter, int surahId, {bool isDelete = false}) async {
    Map<int, int> currentCounts = Map<int, int>.from(currentUiState.downloadedSurahCounts ?? {});
    List<int> surahIds = await _getSurahIdsForReciterUseCase.call(reciter);

    if (isDelete) {
      surahIds.remove(surahId);
    } else if (!surahIds.contains(surahId)) {
      surahIds.add(surahId);
    }

    int newCount = surahIds.length;
    currentCounts[reciter.id] = newCount;
    await _saveDownloadCountUseCase.saveDownloadCount(reciter.id, newCount);
    await _saveReciterWithSurahIdUseCase.call(surahId, reciter, isDelete: isDelete);

    if (reciter.id == currentUiState.defaultReciter.id && !isDelete) {
      await checkDefaultReciterDownloadStatus();
    }

    await loadReciterSurahIds();
    List<Reciter> updatedReciters = await _updateAndSaveRecitersList(reciter);
    updateUiState(downloadedReciters: updatedReciters, downloadedSurahCounts: currentCounts);
  }

  String getImagePath(String reciterName) {
    return 'assets/images/non_svg/img_qari/${reciterName.splitMapJoin(
      RegExp(r'\s+'),
      onMatch: (m) => '_',
      onNonMatch: (n) => n,
    )}.png';
  }

  void updateUiState({
    bool? isDownloading,
    int? currentDownloadingSurahIndex,
    int? downloadProgress,
    List<Reciter>? downloadedReciters,
    Map<int, int>? downloadedSurahCounts,
  }) {
    uiState.value = uiState.value.copyWith(
      isDownloading: isDownloading,
      currentDownloadingSurahIndex: currentDownloadingSurahIndex,
      downloadProgress: downloadProgress,
      downloadedReciters: downloadedReciters,
      downloadedSurahCounts: downloadedSurahCounts,
    );
  }

  int getCurrentDownloadCount(Reciter reciter) => uiState.value.downloadedSurahCounts?[reciter.id] ?? 0;

  Future<void> downloadAllSurahs(Reciter reciter) async {
    updateUiState(isDownloading: true);
    int totalSurahs = 114;
    List<String> errors = [];
    _initializeDownloadProcess();

    for (int surahIndex = 1; surahIndex <= totalSurahs; surahIndex++) {
      if (currentUiState.downloadCancelToken!.isCancelled) break;
      await fetchAudioFilesAndVerseTimings([surahIndex], reciter);
      updateUiState(currentDownloadingSurahIndex: surahIndex);
      final result = await _downloadAndSaveAudioLocationUseCase.execute(
        surahID: surahIndex,
        reciter: reciter,
        onProgress: (percentage) => updateOverallProgress(surahIndex, percentage, totalSurahs),
        cancelToken: currentUiState.downloadCancelToken!,
      );

      result.fold(
        (failure) => errors.add("Surah $surahIndex: $failure"),
        (_) async => await updateDownloadCountsAndReciters(reciter, currentUiState.currentDownloadingSurahIndex!),
      );
    }

    if (errors.isNotEmpty) {
      addUserMessage("Errors occurred during download: ${errors.join(', ')}");
    } else {
      addUserMessage('All surahs downloaded successfully!');
    }

    updateUiState(isDownloading: false, downloadProgress: 0, currentDownloadingSurahIndex: 0);
  }

  void updateOverallProgress(int surahIndex, int percentage, int totalSurahs) {
    int progress = ((surahIndex / totalSurahs) * 100).toInt() + (percentage ~/ totalSurahs);
    updateUiState(downloadProgress: progress);
  }

  Future<List<Reciter>> _updateAndSaveRecitersList(Reciter downloadedReciter) async {
    final List<Reciter> currentReciters = currentUiState.downloadedReciters ?? [];

    // Check if the reciter already exists in the list
    final int existingIndex = currentReciters.indexWhere((Reciter r) => r.id == downloadedReciter.id);

    if (existingIndex != -1) {
      // Reciter already exists, update its data
      currentReciters[existingIndex] = downloadedReciter;
    } else {
      // Add the new reciter to the list
      currentReciters.add(downloadedReciter);
    }

    // Save the updated list to local storage
    await _manageRecitersUseCase.saveRecitersList(currentReciters);

    return currentReciters;
  }

  void toggleCheckBoxVisibility() {
    final bool newState = !currentUiState.checkBoxVisible!;
    uiState.value = currentUiState.copyWith(
      checkBoxVisible: newState,
      isSelected: newState ? currentUiState.isSelected : {},
    );
  }

  void selectSurah(int index) {
    if (currentUiState.checkBoxVisible!) {
      final isSelectedSet = Set<int>.from(currentUiState.isSelected as Set<int>);
      isSelectedSet.contains(index) ? isSelectedSet.remove(index) : isSelectedSet.add(index);
      uiState.value = currentUiState.copyWith(isSelected: isSelectedSet);
      // isSelectedSet.isEmpty ? showDownlaod.value = false : showDownlaod.value = true;
    }
  }

  Future<void> loadDownloadCounts() async {
    try {
      Map<int, int> downloadCounts = {};
      List<Reciter> allReciters = [
        ...?uiState.value.downloadedReciters,
        ...?uiState.value.availableRecitersForDownload
      ];
      for (Reciter reciter in allReciters) {
        List<int> surahIds = await _getSurahIdsForReciterUseCase.call(reciter);
        downloadCounts[reciter.id] = surahIds.length;
      }
      uiState.value = currentUiState.copyWith(downloadedSurahCounts: downloadCounts);
    } catch (e) {
      addUserMessage("Failed to load download counts: $e");
    }
  }

  Future<void> selectReciter({required Reciter reciter, required int index}) async {
    uiState.value = currentUiState.copyWith(
      selectedReciterId: reciter.id,
      selectedReciterIndex: index,
      selectedReciter: reciter,
    );
    await saveSelectedReciter(reciter);

    // Notify AudioPresenter about the change
    final AudioPresenter audioPresenter = locate<AudioPresenter>();
    await audioPresenter.onReciterChanged(reciter);
  }

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  @override
  Future<void> onInit() async {
    await toggleLoading(loading: true);
    await getReciters();
    await loadDownloadedRecitersAndUpdateUI();
    await loadDownloadCounts();
    await loadReciterSurahIds();
    await getSelectedReciter();
    await checkDefaultReciterDownloadStatus();
    await toggleLoading(loading: false);
    super.onInit();
  }

  Future<void> checkDefaultReciterDownloadStatus() async {
    final result = await _getSurahIdsForReciterUseCase.call(currentUiState.defaultReciter);
    final bool isDownloaded = result.isNotEmpty;
    uiState.value = currentUiState.copyWith(isDefaultReciterDownloaded: isDownloaded);
    if (isDownloaded) {
      await _moveDefaultReciterToDownloaded();
    }
  }

  Future<void> _moveDefaultReciterToDownloaded() async {
    final List<Reciter> updatedDownloadedReciters = List.from(currentUiState.downloadedReciters!);
    updatedDownloadedReciters.insert(0, currentUiState.defaultReciter);

    final List<Reciter> updatedAvailableReciters = currentUiState.availableRecitersForDownload!
        .where((reciter) => reciter.id != currentUiState.defaultReciter.id)
        .toList();

    uiState.value = currentUiState.copyWith(
      downloadedReciters: updatedDownloadedReciters,
      availableRecitersForDownload: updatedAvailableReciters,
    );
  }

  Future<void> loadDownloadedRecitersAndUpdateUI() async {
    final List<Reciter> reciters = await _manageRecitersUseCase.loadRecitersList();
    uiState.value = currentUiState.copyWith(downloadedReciters: reciters);
  }

  Future<void> loadReciterSurahIds() async {
    try {
      final reciters = await _getRecitersFromDatabaseUseCase.call(); // Get all reciters
      final Map<int, List<int>> reciterSurahIds = {
        for (var reciter in reciters) reciter.id: await _getSurahIdsForReciterUseCase.call(reciter)
      };
      uiState.value = uiState.value.copyWith(reciterSurahIds: reciterSurahIds);
    } catch (e) {
      addUserMessage("Failed to load Reciter Surah IDs: $e");
    }
  }

  Future<void> getReciters() async {
    final List<Reciter> reciters = await _getRecitersFromDatabaseUseCase.call();

    uiState.value = currentUiState.copyWith(availableRecitersForDownload: reciters);
  }

  Future<void> saveSelectedReciter(Reciter reciter) async {
    await _manageSelectedReciterUseCase.saveSelectedReciter(reciter);
  }

  Future<void> getSelectedReciter() async {
    final Reciter reciter = await _manageSelectedReciterUseCase.getSelectedReciter();
    uiState.value = currentUiState.copyWith(
      defaultReciter: reciter,
      selectedReciterId: reciter.id,
    );
  }

  Future<void> saveReciterWithSurahId(int surahId, Reciter reciter) async {
    await _saveReciterWithSurahIdUseCase.call(surahId, reciter);
    uiState.value = currentUiState.copyWith(reciterSurahIds: {
      ...?currentUiState.reciterSurahIds,
      reciter.id: [surahId]
    });
  }
}
