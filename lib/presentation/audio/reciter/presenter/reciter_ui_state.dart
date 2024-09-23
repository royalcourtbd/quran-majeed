import 'package:dio/dio.dart';
import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class ReciterUiState extends BaseUiState {
  final List<Reciter>? availableRecitersForDownload;
  final List<Reciter>? downloadedReciters;
  final Map<int, int>? downloadedSurahCounts;
  final Reciter selectedReciter;
  final int? selectedReciterIndex;
  final bool? isDownloading;
  final int? currentDownloadingSurahIndex;
  final int? downloadProgress;
  final Map<int, List<int>>? reciterSurahIds;
  final bool? checkBoxVisible;
  final Object? isSelected;
  final CancelToken? downloadCancelToken;
  final Reciter defaultReciter;
  final int selectedReciterId;
  final bool isDefaultReciterDownloaded;

  const ReciterUiState({
    required super.isLoading,
    required super.userMessage,
    required this.availableRecitersForDownload,
    required this.downloadedReciters,
    required this.downloadedSurahCounts,
    required this.checkBoxVisible,
    required this.isSelected,
    required this.selectedReciter,
    required this.selectedReciterIndex,
    required this.isDownloading,
    required this.currentDownloadingSurahIndex,
    required this.downloadProgress,
    required this.reciterSurahIds,
    required this.downloadCancelToken,
    required this.defaultReciter,
    required this.selectedReciterId,
    required this.isDefaultReciterDownloaded,
  });

  factory ReciterUiState.empty() {
    return const ReciterUiState(
      isLoading: true,
      userMessage: null,
      availableRecitersForDownload: null,
      downloadedReciters: null,
      downloadedSurahCounts: null,
      checkBoxVisible: false,
      isSelected: false,
      selectedReciter: Reciter(
        id: 7,
        name: 'Mishary Rashid Alafasy',
      ),
      selectedReciterIndex: null,
      isDownloading: false,
      currentDownloadingSurahIndex: 0,
      downloadProgress: 0,
      reciterSurahIds: null,
      downloadCancelToken: null,
      defaultReciter: Reciter(id: 7, name: 'Mishary Rashid Alafasy'),
      selectedReciterId: 7,
      isDefaultReciterDownloaded: false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        availableRecitersForDownload,
        downloadedReciters,
        downloadedSurahCounts,
        checkBoxVisible,
        isSelected,
        selectedReciter,
        selectedReciterIndex,
        isDownloading,
        currentDownloadingSurahIndex,
        downloadProgress,
        reciterSurahIds,
        downloadCancelToken,
        defaultReciter,
        selectedReciterId,
        isDefaultReciterDownloaded,
      ];

  ReciterUiState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Reciter>? availableRecitersForDownload,
    List<Reciter>? downloadedReciters,
    Map<int, int>? downloadedSurahCounts,
    bool? checkBoxVisible,
    Object? isSelected,
    Reciter? selectedReciter,
    int? selectedReciterIndex,
    bool? isDownloading,
    int? currentDownloadingSurahIndex,
    int? downloadProgress,
    Map<int, List<int>>? reciterSurahIds,
    CancelToken? downloadCancelToken,
    Reciter? defaultReciter,
    int? selectedReciterId,
    bool? isDefaultReciterDownloaded,
  }) {
    return ReciterUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
      availableRecitersForDownload: availableRecitersForDownload ?? this.availableRecitersForDownload,
      downloadedSurahCounts: downloadedSurahCounts ?? this.downloadedSurahCounts,
      downloadedReciters: downloadedReciters ?? this.downloadedReciters,
      checkBoxVisible: checkBoxVisible ?? this.checkBoxVisible,
      isSelected: isSelected ?? this.isSelected,
      selectedReciter: selectedReciter ?? this.selectedReciter,
      selectedReciterIndex: selectedReciterIndex ?? this.selectedReciterIndex,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      currentDownloadingSurahIndex: currentDownloadingSurahIndex ?? this.currentDownloadingSurahIndex,
      reciterSurahIds: reciterSurahIds ?? this.reciterSurahIds,
      downloadCancelToken: downloadCancelToken ?? this.downloadCancelToken,
      defaultReciter: defaultReciter ?? this.defaultReciter,
      selectedReciterId: selectedReciterId ?? this.selectedReciterId,
      isDefaultReciterDownloaded: isDefaultReciterDownloaded ?? this.isDefaultReciterDownloaded,
    );
  }
}
