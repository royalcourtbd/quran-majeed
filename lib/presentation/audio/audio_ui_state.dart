import 'package:dio/dio.dart';
import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class AudioUIState extends BaseUiState {
  final bool isPlaying;
  final bool isDownloading;
  final bool isPaused;
  final bool showPlayerControls;
  final int downloadProgress;
  final int selectedAyahIndex;
  final String? selectedStartSurahName;
  final String? selectedEndSurahName;
  final int? selectedSurahIndex;
  final int? selectedStartSurahId;
  final int? selectedStartAyahId;
  final int? selectedEndSurahId;
  final int? selectedEndAyahId;
  final int? ayahNumbers;
  final int ayahRepeatNumber;
  final int ayahDelayNumber;
  final Duration? currentPlayTime;
  final Duration? totalDuration;
  final int? currentlyPlayingSurahIndex;
  final int? currentlyPlayingAyahIndex;
  final List<int>? currentSurahIdsInPlaylist;
  final bool? showDownloadCard;
  final bool? isOnlinePlaying;
  final bool ayahRepetitionTriggered;
  final int? lastProcessedAyahIndex;
  final CancelToken? downloadCancelToken;
  final Reciter selectedReciter;
  final bool seekingBarTapped;

  const AudioUIState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedReciter,
    this.isPlaying = false,
    this.isDownloading = false,
    this.isPaused = false,
    this.selectedAyahIndex = 0,
    this.showPlayerControls = false,
    this.downloadProgress = 0,
    this.selectedStartSurahName,
    this.selectedEndSurahName,
    this.selectedStartSurahId,
    this.selectedStartAyahId,
    this.selectedEndSurahId,
    this.selectedEndAyahId,
    this.selectedSurahIndex,
    this.ayahNumbers,
    this.ayahRepeatNumber = 0,
    this.ayahDelayNumber = 0,
    this.currentPlayTime,
    this.totalDuration,
    this.currentlyPlayingSurahIndex,
    this.currentlyPlayingAyahIndex,
    this.currentSurahIdsInPlaylist,
    this.showDownloadCard,
    this.isOnlinePlaying,
    this.ayahRepetitionTriggered = false, // Initialize as false
    this.lastProcessedAyahIndex,
    this.downloadCancelToken,
    this.seekingBarTapped = false,
  });

  factory AudioUIState.empty() {
    return const AudioUIState(
      isLoading: false,
      userMessage: null,
      isPlaying: false,
      selectedAyahIndex: 0,
      showPlayerControls: false,
      isDownloading: false,
      isPaused: false,
      downloadProgress: 0,
      selectedEndSurahName: 'Al-Faatiha',
      selectedStartSurahName: 'Al-Faatiha',
      selectedStartSurahId: 1,
      selectedStartAyahId: 1,
      selectedEndSurahId: 1,
      selectedEndAyahId: 7,
      selectedSurahIndex: 0,
      ayahNumbers: 7,
      ayahRepeatNumber: 0,
      ayahDelayNumber: 0,
      currentPlayTime: Duration.zero,
      totalDuration: Duration.zero,
      currentlyPlayingSurahIndex: 1,
      currentlyPlayingAyahIndex: 1,
      currentSurahIdsInPlaylist: [],
      showDownloadCard: false,
      isOnlinePlaying: false,
      ayahRepetitionTriggered: false, // Keep as false in empty state
      lastProcessedAyahIndex: null,
      downloadCancelToken: null,
      selectedReciter: Reciter(id: 4, name: 'Mishari Rashid al-`Afasy'),
      seekingBarTapped: false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        selectedAyahIndex,
        isPlaying,
        isPaused,
        showPlayerControls,
        isDownloading,
        downloadProgress,
        selectedStartSurahName,
        selectedEndSurahName,
        selectedStartSurahId,
        selectedStartAyahId,
        selectedEndSurahId,
        selectedEndAyahId,
        selectedSurahIndex,
        ayahNumbers,
        ayahRepeatNumber,
        ayahDelayNumber,
        currentPlayTime,
        totalDuration,
        currentlyPlayingSurahIndex,
        currentlyPlayingAyahIndex,
        currentSurahIdsInPlaylist,
        showDownloadCard,
        isOnlinePlaying,
        ayahRepetitionTriggered,
        lastProcessedAyahIndex,
        downloadCancelToken,
        selectedReciter,
        seekingBarTapped,
      ];

  AudioUIState copyWith({
    bool? isLoading,
    String? userMessage,
    bool? isPlaying,
    int? selectedAyahIndex,
    bool? isDownloading,
    bool? isPaused,
    bool? showPlayerControls,
    int? downloadProgress,
    String? selectedStartSurahName,
    String? selectedEndSurahName,
    int? selectedStartSurahId,
    int? selectedStartAyahId,
    int? selectedEndSurahId,
    int? selectedEndAyahId,
    int? selectedSurahIndex,
    int? ayahNumbers,
    int? ayahRepeatNumber,
    int? ayahDelayNumber,
    Duration? currentPlayTime,
    Duration? totalDuration,
    int? currentlyPlayingSurahIndex,
    int? currentlyPlayingAyahIndex,
    List<int>? currentSurahIdsInPlaylist,
    bool? showDownloadCard,
    bool? isOnlinePlaying,
    bool? ayahRepetitionTriggered,
    int? lastProcessedAyahIndex,
    CancelToken? downloadCancelToken,
    Reciter? selectedReciter,
    bool? seekingBarTapped,
  }) {
    return AudioUIState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      isPlaying: isPlaying ?? this.isPlaying,
      selectedAyahIndex: selectedAyahIndex ?? this.selectedAyahIndex,
      isDownloading: isDownloading ?? this.isDownloading,
      isPaused: isPaused ?? this.isPaused,
      showPlayerControls: showPlayerControls ?? this.showPlayerControls,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      selectedStartSurahName: selectedStartSurahName ?? this.selectedStartSurahName,
      selectedEndSurahName: selectedEndSurahName ?? this.selectedEndSurahName,
      selectedStartSurahId: selectedStartSurahId ?? this.selectedStartSurahId,
      selectedStartAyahId: selectedStartAyahId ?? this.selectedStartAyahId,
      selectedEndSurahId: selectedEndSurahId ?? this.selectedEndSurahId,
      selectedEndAyahId: selectedEndAyahId ?? this.selectedEndAyahId,
      selectedSurahIndex: selectedSurahIndex ?? this.selectedSurahIndex,
      ayahNumbers: ayahNumbers ?? this.ayahNumbers,
      ayahRepeatNumber: ayahRepeatNumber ?? this.ayahRepeatNumber,
      ayahDelayNumber: ayahDelayNumber ?? this.ayahDelayNumber,
      currentPlayTime: currentPlayTime ?? this.currentPlayTime,
      totalDuration: totalDuration ?? this.totalDuration,
      currentlyPlayingSurahIndex: currentlyPlayingSurahIndex ?? this.currentlyPlayingSurahIndex,
      currentlyPlayingAyahIndex: currentlyPlayingAyahIndex ?? this.currentlyPlayingAyahIndex,
      currentSurahIdsInPlaylist: currentSurahIdsInPlaylist ?? this.currentSurahIdsInPlaylist,
      showDownloadCard: showDownloadCard ?? this.showDownloadCard,
      isOnlinePlaying: isOnlinePlaying ?? this.isOnlinePlaying,
      ayahRepetitionTriggered: ayahRepetitionTriggered ?? this.ayahRepetitionTriggered,
      lastProcessedAyahIndex: lastProcessedAyahIndex ?? this.lastProcessedAyahIndex,
      downloadCancelToken: downloadCancelToken ?? this.downloadCancelToken,
      selectedReciter: selectedReciter ?? this.selectedReciter,
      seekingBarTapped: seekingBarTapped ?? this.seekingBarTapped,
    );
  }
}
