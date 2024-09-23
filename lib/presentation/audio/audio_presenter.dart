import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/src/scrollable_positioned_list.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/scroll_controller_manager.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/audio_surah_and_ayah_selection_type_enum.dart';
import 'package:quran_majeed/domain/service/audio_service.dart';
import 'package:quran_majeed/domain/use_cases/audio/add_to_playlist_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/clear_playlist_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/create_audio_file_path_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/download_and_save_audio_location_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/fetch_audio_files_and_verse_timings_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/get_audio_path_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/is_surah_audio_available_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/pause_playback_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/play_surah_audio_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/play_verse_with_delay_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/resume_playback_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/seek_audio_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/stop_audio_use_case.dart';
import 'package:quran_majeed/presentation/audio/audio_ui_state.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/data/sealed_classes/surah_ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/audio_play_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/online_audio_play_bottom_sheet.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/select_surah_ayah_bottom_sheet.dart';

class AudioPresenter extends BasePresenter<AudioUIState> {
  final IsSurahAudioAvailableUseCase _isSurahAudioAvailableUseCase;
  final PlayVerseWithDelayUseCase _playVerseWithDelayUseCase;
  final DownloadAndSaveAudioLocationUseCase
      _downloadAndSaveAudioLocationUseCase;
  final PlaySurahAudioUseCase _playSurahAudioUseCase;
  final GetAudioPathUseCase _getAudioPathUseCase;
  final AddToPlaylistUseCase _addToPlaylistUseCase;
  final FetchAudioFilesAndVerseTimingsUseCase
      _fetchAudioFilesAndVerseTimingsUseCase;
  final SeekAudioUseCase _seekAudioUseCase;
  final ClearPlaylistUseCase _clearPlaylistUseCase;
  final CreateAudioFilePathUseCase _createAudioFilePathUseCase;
  final StopAudioUseCase _stopAudioUseCase;
  final PausePlaybackUseCase _pausePlaybackUseCase;
  final ResumePlaybackUseCase _resumePlaybackUseCase;
  late final AyahPresenter _ayahPresenter = locate<AyahPresenter>();
  late final ReciterPresenter reciterPresenter = locate<ReciterPresenter>();

  AudioPresenter(
    this._isSurahAudioAvailableUseCase,
    this._downloadAndSaveAudioLocationUseCase,
    this._playVerseWithDelayUseCase,
    this._playSurahAudioUseCase,
    this._getAudioPathUseCase,
    this._addToPlaylistUseCase,
    this._seekAudioUseCase,
    this._clearPlaylistUseCase,
    this._createAudioFilePathUseCase,
    this._stopAudioUseCase,
    this._pausePlaybackUseCase,
    this._resumePlaybackUseCase,
    this._fetchAudioFilesAndVerseTimingsUseCase,
  );

  final Obs<AudioUIState> uiState = Obs(AudioUIState.empty());
  AudioUIState get currentUiState => uiState.value;

  @override
  Future<void> onInit() async {
    await initializeData();
    super.onInit();
  }

  @override
  dispose() {
    uiState.close();
    AudioPlayerService.instance.dispose();
    super.dispose();
  }

  Future<void> initializeData() async {
    initializeAudioListeners();
  }

  void selectSurahOrAyah(int id, SelectionType type, {bool isSurah = true}) {
    final String? surahName = isSurah ? CacheData.surahsCache[id].nameEn : null;

    // Validation for end Surah/Ayah selection
    if (type == SelectionType.end &&
        !isValidEndSurahAyahSelection(id, isSurah)) {
      addUserMessage(
          "End Surah/Ayah cannot be before the Start Surah/Ayah. Please select a valid End Surah/Ayah.");
      return;
    }
    // Update the UI state based on selection type
    updateUIStateForSurahAyahSelection(id, type, isSurah, surahName);
  }

  void onAudioPlayOnline() {
    uiState.value = currentUiState.copyWith(
        isOnlinePlaying: !currentUiState.isOnlinePlaying!);
  }

  void updateUIStateForSurahAyahSelection(
      int id, SelectionType type, bool isSurah, String? surahName) {
    if (type == SelectionType.start && isSurah) {
      uiState.value = currentUiState.copyWith(
        selectedSurahIndex: id,
        ayahNumbers: CacheData.surahsCache[id].totalAyah,
        selectedStartSurahId: id + 1,
        selectedEndSurahId: id + 1,
        selectedEndAyahId: CacheData.surahsCache[id].totalAyah,
        selectedStartSurahName: surahName,
        selectedEndSurahName: surahName,
      );
    } else if (type == SelectionType.start && !isSurah) {
      uiState.value = currentUiState.copyWith(
        selectedStartAyahId: id + 1,
        selectedEndAyahId: id + 1,
        selectedAyahIndex: id,
      );
    } else if (type == SelectionType.end && isSurah) {
      uiState.value = currentUiState.copyWith(
        selectedEndSurahId: id + 1,
        ayahNumbers: CacheData.surahsCache[id].totalAyah,
        selectedSurahIndex: id,
        selectedEndSurahName: surahName,
      );
    } else if (type == SelectionType.end && !isSurah) {
      uiState.value = currentUiState.copyWith(
        selectedEndAyahId: id + 1,
        selectedAyahIndex: id,
      );
    }
  }

  bool isValidEndSurahAyahSelection(int id, bool isSurah) {
    if (isSurah) {
      return id >= currentUiState.selectedStartSurahId! - 1;
    } else {
      if (currentUiState.selectedEndSurahId ==
          currentUiState.selectedStartSurahId) {
        return id >= currentUiState.selectedStartAyahId! - 1;
      }
      return true;
    }
  }

  void onSelectSurah(
    int surahIndex,
  ) {
    if (currentUiState.selectedStartSurahId != surahIndex) {
      uiState.value = currentUiState.copyWith(
        selectedStartAyahId: 1,
      );
    }
  }

  void updateAyahRepeatNumber(int ayahRepeatNumber) {
    uiState.value = uiState.value.copyWith(
      ayahRepeatNumber: ayahRepeatNumber,
    );
  }

  void updateAyahDelayNumber(int ayahDelayNumber) {
    uiState.value = uiState.value.copyWith(
      ayahDelayNumber: ayahDelayNumber,
    );
  }

  Future<void> seekAudio(double seekPercent) async {
    uiState.value = uiState.value.copyWith(seekingBarTapped: true);
    final Duration seekToDuration = Duration(
      milliseconds:
          (currentUiState.totalDuration!.inMilliseconds * seekPercent).round(),
    );

    await _seekAudioUseCase.execute(seekDuration: seekToDuration);
    uiState.value = uiState.value.copyWith(seekingBarTapped: false);
  }

  Future<void> onSelectSurahButtonClicked(
      BuildContext context, String bottomSheetTitle) async {
    final SelectionType selectionType =
        bottomSheetTitle == 'Start' ? SelectionType.start : SelectionType.end;
    await SelectSurahAyahBottomSheet.show(
      context: context,
      presenter: SurahAyahPresenter.audio(locate<AudioPresenter>()),
      bottomSheetTitle:
          '${context.l10n.select} $bottomSheetTitle ${context.l10n.surahAndAyah}',
      isDoneButtonEnabled: true,
      isJumpToAyahBottomSheet: false,
      onSurahSelected: (surahId) =>
          selectSurahOrAyah(surahId, selectionType, isSurah: true),
      onAyahSelected: (ayahId) =>
          selectSurahOrAyah(ayahId, selectionType, isSurah: false),
      onSubmit: () => context.navigatorPop(),
    );
  }

  void displayAudioPlayerUI() async {
    await onSurahSelected(
      startSurah: currentUiState.selectedStartSurahId!,
      endSurah: currentUiState.selectedEndSurahId!,
    );
  }

  String getSelectedReciterName() {
    return reciterPresenter.currentUiState.selectedReciter.name;
  }

  Future<void> onClickAudioButton(
      BuildContext context, isFromAyahDetail) async {
    await AudioPlayBottomSheet.show(
      context: context,
      isFromAyahDetail: isFromAyahDetail,
    );
  }

  Future<void> onClickOnlineAudioPlayButton(BuildContext context) async {
    await OnlineAudioPlayBottomSheet.show(
      context: context,
    );
  }

  Future<void> resumePlayback() async {
    await _resumePlaybackUseCase.execute();
    uiState.value = uiState.value.copyWith(isPlaying: true, isPaused: false);
  }

  void initializeAudioListeners() {
    AudioPlayerService.instance.durationStream.listen((duration) {
      uiState.value = uiState.value.copyWith(totalDuration: duration);
    }).onError((error) {
      logError("Error in durationStream: $error");
    });

    AudioPlayerService.instance.playerStateStream
        .listen((PlayerState playbackState) {
      uiState.value = currentUiState.copyWith(isPlaying: playbackState.playing);
      if (!currentUiState.isDownloading) {
        final double newHeight = playbackState.playing
            ? kBottomNavigationBarHeight + 12.percentWidth
            : kBottomNavigationBarHeight + 5.percentWidth;
        _ayahPresenter.setBottomNavigationBarHeight(newHeight);
      }
    }).onError((error) {
      logError("Error in playerStateStream: $error");
    });

    listenToCurrentIndex();
  }

  void listenToCurrentIndex() {
    AudioPlayerService.instance.currentIndexStream.listen((currentIndex) {
      if (currentIndex != null && currentUiState.isPlaying) {
        scrollToPage(currentIndex: currentIndex);
      }
    }).onError((error) {
      logError("Error in currentIndexStream: $error");
    });
  }

  void scrollToPage({int currentIndex = 0}) {
    final List<int>? currentSurahIdsInPlaylist =
        currentUiState.currentSurahIdsInPlaylist;

    if (currentSurahIdsInPlaylist != null &&
        currentIndex < currentSurahIdsInPlaylist.length) {
      final int surahId = currentSurahIdsInPlaylist[currentIndex];
      final int pageIndex = surahId - 1;
      _ayahPresenter.pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void initializePositionListener() {
    AudioPlayerService.instance.positionStream.listen((position) async {
      uiState.value = uiState.value.copyWith(currentPlayTime: position);
      if (currentUiState.isPlaying) {
        await _updateCurrentSurahAndAyah(position);
        await _stopPlayingWhenEndOfPlaylist(position);
      }
    });
  }

  Future<void> _stopPlayingWhenEndOfPlaylist(Duration position) async {
    final AudioFile? audioFileId =
        CacheData.audioFiles[currentUiState.selectedEndSurahId];
    if (audioFileId != null) {
      final List<VerseTiming> verseTimings = CacheData
          .verseTimings['${audioFileId.reciterId}-${audioFileId.surahId}']!;

      if (verseTimings.isEmpty) return;

      final int lastAyahNumber = verseTimings.last.ayah;
      final int lastTime = verseTimings.last.time;

      if (!specialReciters()) {
        if (position.inMilliseconds >= lastTime &&
            currentUiState.currentlyPlayingAyahIndex == lastAyahNumber) {
          await _stopAudioUseCase.execute();
        }
      }
    }
  }

  bool specialReciters() {
    return [2, 4, 8, 14, 20, 24, 25]
        .contains(currentUiState.selectedReciter.id);
  }

  Future<void> _scrollToCurrentAyah() async {
    final int pageIndex = _ayahPresenter.pageController.page!.round();
    final ItemScrollController scrollController =
        ScrollControllerManager().getScrollController(pageIndex);

    if (scrollController.isAttached &&
        scrollController.scrollController!.offset <
            scrollController.scrollController!.position.maxScrollExtent &&
        currentUiState.currentlyPlayingSurahIndex == pageIndex + 1) {
      if (currentUiState.currentlyPlayingAyahIndex ==
              currentUiState.selectedStartAyahId! ||
          currentUiState.seekingBarTapped) {
        jumpToCurrentAyah(currentUiState.currentlyPlayingAyahIndex!);
      } else {
        if (!(specialReciters() &&
            currentUiState.currentlyPlayingAyahIndex == 0)) {
          await scrollController.scrollTo(
            index: currentUiState.currentlyPlayingAyahIndex! - 1,
            duration:
                const Duration(milliseconds: 100), // Smooth scroll duration
            curve: Curves.easeInOut, // Smooth scroll animation curve
          );
        }
      }
    }
  }

  void jumpToCurrentAyah(int ayah) {
    final int pageIndex = _ayahPresenter.pageController.page!.round();
    final ItemScrollController scrollController =
        ScrollControllerManager().getScrollController(pageIndex);
    scrollController.jumpTo(
      index: ayah - 1,
    );
  }

  Future<void> _updateCurrentSurahAndAyah(
    Duration position,
  ) async {
    final int currentMillis = position.inMilliseconds;
    final int? currentIndex = AudioPlayerService.instance.currentIndex;
    final List<int>? currentSurahIdsInPlaylist =
        currentUiState.currentSurahIdsInPlaylist;
    final AudioFile? audioFileId =
        currentSurahIdsInPlaylist != null && currentIndex != null
            ? CacheData.audioFiles[currentSurahIdsInPlaylist[currentIndex]]
            : null;

    if (audioFileId != null) {
      final List<VerseTiming> verseTimings = CacheData
          .verseTimings['${audioFileId.reciterId}-${audioFileId.surahId}']!;
      VerseTiming? currentVerse = verseTimings
          .firstWhereOrNull((verseTiming) => currentMillis <= verseTiming.time);

      if (currentVerse != null) {
        final int surahId = currentVerse.surahId;
        final int ayahNumber =
            specialReciters() ? currentVerse.ayah - 1 : currentVerse.ayah;

        uiState.value = uiState.value.copyWith(
          currentlyPlayingSurahIndex: surahId,
          currentlyPlayingAyahIndex: ayahNumber,
          currentPlayTime: position,
        );

        await _scrollToCurrentAyah();
        // if (currentUiState.lastProcessedAyahIndex != ayahNumber &&
        //     isEndOfCurrentAyah(currentMillis, verseTimings, ayahNumber)) {
        //   await repeatAyahs(
        //     uiState.value.ayahRepeatNumber,
        //     uiState.value.ayahDelayNumber,
        //     verseTimings,
        //   );
        // }
      }
    }
  }

  bool isEndOfCurrentAyah(
      int currentMillis, List<VerseTiming> verseTimings, int ayahIndex) {
    final VerseTiming? currentAyahTiming =
        verseTimings.firstWhereOrNull((vt) => vt.ayah == ayahIndex);
    if (currentAyahTiming == null) return false;

    final VerseTiming? nextAyahTiming =
        verseTimings.firstWhereOrNull((vt) => vt.ayah == ayahIndex + 1);

    return currentMillis >= (currentAyahTiming.time) &&
        (nextAyahTiming == null || currentMillis < nextAyahTiming.time);
  }

  Duration getDurationOfAyah(List<VerseTiming> verseTimings, int ayahIndex) {
    final VerseTiming ayah =
        verseTimings.firstWhere((element) => element.ayah == ayahIndex);
    return Duration(milliseconds: ayah.time);
  }

  Future<void> repeatAyahs(
      int times, int delayInSeconds, List<VerseTiming> verseTimings) async {
    for (int ayahIndex = 0; ayahIndex < verseTimings.length; ayahIndex++) {
      Duration startOfAyah = getStartOfAyah(verseTimings, ayahIndex);
      Duration endOfAyah = getDurationOfAyah(verseTimings, ayahIndex);
      Duration ayahDuration = endOfAyah - startOfAyah;

      for (int i = 0; i < times; i++) {
        await AudioPlayerService.instance.seek(startOfAyah);
        await AudioPlayerService.instance.play();
        // Wait for ayah to finish playing
        await Future.delayed(ayahDuration);
        await AudioPlayerService.instance.pause();
        // Reset to beginning of the ayah for the next repetition
        await AudioPlayerService.instance.seek(startOfAyah);
        // Additional delay between repetitions, if specified
        if (delayInSeconds > 0) {
          await Future.delayed(Duration(seconds: delayInSeconds));
        }
      }
      // After repeating, set the last processed ayah index
      uiState.value = uiState.value.copyWith(lastProcessedAyahIndex: ayahIndex);
    }
  }

  Duration getStartOfAyah(List<VerseTiming> verseTimings, int ayahIndex) {
    final VerseTiming ayah =
        verseTimings.firstWhere((element) => element.ayah == ayahIndex);
    return Duration(milliseconds: ayah.time);
  }

  void cancelDownload() {
    if (currentUiState.downloadCancelToken != null &&
        !currentUiState.downloadCancelToken!.isCancelled) {
      currentUiState.downloadCancelToken!.cancel("Download canceled by user");
      uiState.value = uiState.value.copyWith(isDownloading: false);
      _ayahPresenter.setBottomNavigationBarHeight(
          kBottomNavigationBarHeight + 5.percentWidth);
    }
  }

  Future<void> pauseAudio() async {
    await _pausePlaybackUseCase.execute();
    uiState.value = uiState.value.copyWith(isPlaying: false, isPaused: true);
    _ayahPresenter.setBottomNavigationBarHeight(
        kBottomNavigationBarHeight + 12.percentWidth);
  }

  Future<void> stopAudio() async {
    try {
      if (AudioPlayerService.instance.playing) {
        await _stopAudioUseCase.execute();
      }
    } catch (e) {
      // Log the error or handle it as needed
      logError("Error stopping audio: ${e.toString()}");
    }

    // Update the UI state after stopping
    uiState.value = uiState.value.copyWith(
      currentlyPlayingSurahIndex: null,
      currentlyPlayingAyahIndex: null,
      currentPlayTime: Duration.zero,
      isPlaying: false,
      showPlayerControls: false,
      lastProcessedAyahIndex: null,
    );

    // Remove event listeners
    removeAudioListeners();
    _ayahPresenter.setBottomNavigationBarHeight(
        kBottomNavigationBarHeight + 5.percentWidth);
  }

  void removeAudioListeners() {
    AudioPlayerService.instance.durationStream.listen(null).cancel();
    AudioPlayerService.instance.playerStateStream.listen(null).cancel();
    AudioPlayerService.instance.currentIndexStream.listen(null).cancel();
    AudioPlayerService.instance.positionStream.listen(null).cancel();
  }

  String getSuranNameFromId(int surahId) =>
      CacheData.surahsCache[surahId - 1].nameEn;

  Future<void> playAudio() async {
    try {
      _playSurahAudioUseCase.execute();

      Duration startTimestamp = await getAyahStartTimestamp(
          currentUiState.selectedStartSurahId!,
          currentUiState.selectedStartAyahId!);

      await AudioPlayerService.instance.seek(startTimestamp);

      uiState.value = uiState.value.copyWith(
        isPlaying: true,
        showPlayerControls: true,
      );
      // Check if the currently playing Surah is not the current index
      if (uiState.value.currentlyPlayingSurahIndex !=
          _ayahPresenter.pageController.page!.round() + 1) {
        // Call scrollToPage method
        scrollToPage();
      }
    } catch (e) {
      addUserMessage("Error playing audio: ${e.toString()}");
      logError("Error in playAudio: ${e.toString()}");
    }
  }

  Future<Duration> getAyahStartTimestamp(int surahId, int ayahId) async {
    if (specialReciters() && ayahId == 1) {
      return Duration.zero;
    } else {
      final AudioFile? audioFileId = CacheData.audioFiles[surahId];
      if (audioFileId != null) {
        final List<VerseTiming> verseTimings = CacheData
            .verseTimings['${audioFileId.reciterId}-${audioFileId.surahId}']!;
        final VerseTiming ayah =
            verseTimings.firstWhere((element) => element.ayah == ayahId);
        return Duration(milliseconds: ayah.time);
      }
    }
    return Duration.zero;
  }

  Future<void> playPauseAudio() async {
    if (currentUiState.isPlaying) {
      await pauseAudio();
    } else {
      await resumePlayback();
    }
  }

  Future<String> fetchSurahAudioPath(int surah, Reciter reciter) async {
    final Either<String, String> audioPath =
        await _getAudioPathUseCase.execute(surah: surah, reciter: reciter);
    return audioPath.fold((l) => '', (r) => r);
  }

  Future<void> clearPlaylist() async {
    await _clearPlaylistUseCase.execute();
  }

  Future<void> onSurahSelected({
    required int startSurah,
    required int endSurah,
  }) async {
    final Reciter selectedReciter = currentUiState.selectedReciter;

    List<int> totalSurahs = List<int>.generate(
        endSurah - startSurah + 1, (index) => startSurah + index);
    uiState.value = currentUiState.copyWith(
        isDownloading: true, downloadCancelToken: CancelToken());
    _ayahPresenter.setBottomNavigationBarHeight(
        kBottomNavigationBarHeight + 22.percentWidth);

    await clearPlaylist();

    final List<int> surahsToDownload =
        await _getSurahsToDownload(startSurah, endSurah, selectedReciter);
    await fetchAudioFilesAndVerseTimings(totalSurahs, selectedReciter);

    await _downloadSurahs(surahsToDownload, selectedReciter);
    if (!_isCancelled()) {
      await addToPlaylist(totalSurahs, selectedReciter);

      uiState.value = currentUiState.copyWith(
          isDownloading: false, downloadCancelToken: null);
      _ayahPresenter.setBottomNavigationBarHeight(
          kBottomNavigationBarHeight + 5.percentWidth);
      await playAudio();
    }
  }

  Future<List<int>> _getSurahsToDownload(
      int startSurah, int endSurah, Reciter reciter) async {
    List<int> surahsToDownload = <int>[];
    List<Future> checks = [];

    for (int surah = startSurah; surah <= endSurah; surah++) {
      checks.add(_isSurahAudioAvailableUseCase
          .execute(surahNumber: surah, reciter: reciter)
          .then((result) => result.fold((l) => addUserMessage(l), (r) {
                if (!r) surahsToDownload.add(surah);
              })));
    }

    await Future.wait(checks);
    return surahsToDownload;
  }

  Future<void> fetchAudioFilesAndVerseTimings(
      List<int> totalSurahs, Reciter reciter) async {
    await _fetchAudioFilesAndVerseTimingsUseCase.execute(totalSurahs, reciter);
  }

  Future<void> _downloadSurahs(
      List<int> surahsToDownload, Reciter reciter) async {
    for (int surah in surahsToDownload) {
      if (_isCancelled()) break;

      await _downloadAndSaveAudioLocationUseCase.execute(
        surahID: surah,
        reciter: reciter,
        onProgress: (percentage) => uiState.value =
            currentUiState.copyWith(downloadProgress: percentage),
        cancelToken: currentUiState.downloadCancelToken!,
      );

      if (_isCancelled()) break;

      await reciterPresenter.updateDownloadCountsAndReciters(reciter, surah);
    }
  }

  Future<void> onReciterChanged(Reciter reciter) async {
    uiState.value = currentUiState.copyWith(selectedReciter: reciter);
    await clearPlaylist();
    // Reset any necessary audio states
    uiState.value = currentUiState.copyWith(
      isPlaying: false,
      currentlyPlayingSurahIndex: null,
      currentlyPlayingAyahIndex: null,
      currentPlayTime: Duration.zero,
    );
  }

  Future<void> seekToPreviousAyah() async {
    if (currentUiState.isPaused && !currentUiState.isPlaying) return;

    if (currentUiState.currentlyPlayingAyahIndex != null &&
        currentUiState.currentlyPlayingAyahIndex! > 1) {
      final int? currentIndex = AudioPlayerService.instance.currentIndex;
      final List<int>? currentSurahIdsInPlaylist =
          currentUiState.currentSurahIdsInPlaylist;
      final AudioFile? audioFileId =
          currentSurahIdsInPlaylist != null && currentIndex != null
              ? CacheData.audioFiles[currentSurahIdsInPlaylist[currentIndex]]
              : null;
      if (audioFileId != null) {
        final List<VerseTiming> verseTimings = CacheData
            .verseTimings['${audioFileId.reciterId}-${audioFileId.surahId}']!;
        final VerseTiming previousAyah = verseTimings.firstWhere(
          (element) =>
              element.ayah == currentUiState.currentlyPlayingAyahIndex! - 1,
        );
        await AudioPlayerService.instance
            .seek(Duration(milliseconds: previousAyah.time));
      }
    }
  }

  Future<void> seekToNextAyah() async {
    if (currentUiState.isPaused && !currentUiState.isPlaying)
      return; // Disable button if paused

    final int? currentIndex = AudioPlayerService.instance.currentIndex;
    final List<int>? currentSurahIdsInPlaylist =
        currentUiState.currentSurahIdsInPlaylist;
    final AudioFile? audioFileId =
        currentSurahIdsInPlaylist != null && currentIndex != null
            ? CacheData.audioFiles[currentSurahIdsInPlaylist[currentIndex]]
            : null;
    if (audioFileId != null) {
      final List<VerseTiming> verseTimings = CacheData
          .verseTimings['${audioFileId.reciterId}-${audioFileId.surahId}']!;
      final VerseTiming? nextAyah = verseTimings.firstWhereOrNull(
        (element) =>
            element.ayah == currentUiState.currentlyPlayingAyahIndex! + 1,
      );
      if (nextAyah != null) {
        await AudioPlayerService.instance
            .seek(Duration(milliseconds: nextAyah.time));
      }
    }
  }

  Future<void> addToPlaylist(List<int> totalSurahs, Reciter reciter) async {
    final String directoryPath = await getApplicationDirectoryPath();
    for (int surah in totalSurahs) {
      final Either<String, String> result = await _createAudioFilePathUseCase
          .execute(surah: surah, reciter: reciter);
      final String location = result.fold((l) => '', (r) => r);
      final String fileSaveLocation = "$directoryPath/$location";
      final isFileExists = await doesFileExist(fileSaveLocation);
      if (isFileExists) {
        await _addToPlaylistUseCase.execute(
            audioPath: fileSaveLocation,
            title: CacheData.surahsCache[surah - 1].nameEn);
        uiState.value = currentUiState.copyWith(
          currentSurahIdsInPlaylist: [
            ...currentUiState.currentSurahIdsInPlaylist!,
            surah
          ],
        );
      }
    }
  }

  bool _isCancelled() {
    return currentUiState.downloadCancelToken != null &&
        currentUiState.downloadCancelToken!.isCancelled;
  }

  Future<void> onSelectVerseForDelayedPlay(
      int audioFileId, String verseKey, Duration delay) async {
    await _playVerseWithDelayUseCase.execute(audioFileId, verseKey, delay);
  }

  @override
  Future<void> addUserMessage(String message) async =>
      showMessage(message: message);

  @override
  Future<void> toggleLoading({required bool loading}) async =>
      uiState.value = uiState.value.copyWith(isLoading: loading);
}
