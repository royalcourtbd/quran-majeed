import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';

class TafseerPageUiState extends BaseUiState {
  final String activeDownloadId;
  final List<TTDbFileModel> availableItems;
  final List<TTDbFileModel> selectedItems;
  final List<MapEntry<String, List<TTDbFileModel>>> downloadableItems;
  final bool isDownloading;
  final bool isAllFilesDownloading;
  final bool isTabChanged;
  final int downloadProgress;
  final int totalAvailableToDownloadItemsCount;
  final List<double> totalSizes;
  final int activeTabIndex;
  final Map<int, Map<int, String>>? activeTafseerData;

  const TafseerPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.activeDownloadId,
    required this.availableItems,
    required this.selectedItems,
    required this.downloadableItems,
    required this.isDownloading,
    required this.downloadProgress,
    required this.totalAvailableToDownloadItemsCount,
    required this.totalSizes,
    required this.isAllFilesDownloading,
    required this.isTabChanged,
    required this.activeTabIndex,
    this.activeTafseerData,
  });

  factory TafseerPageUiState.empty() {
    return const TafseerPageUiState(
      isLoading: true,
      userMessage: null,
      activeDownloadId: '',
      availableItems: [],
      selectedItems: [],
      downloadableItems: [],
      isDownloading: false,
      downloadProgress: 0,
      totalAvailableToDownloadItemsCount: 0,
      totalSizes: [],
      isAllFilesDownloading: false,
      activeTabIndex: 0,
      isTabChanged: false,
      activeTafseerData: null,
    );
  }

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
        activeDownloadId,
        availableItems,
        selectedItems,
        downloadableItems,
        isDownloading,
        downloadProgress,
        totalAvailableToDownloadItemsCount,
        totalSizes,
        isAllFilesDownloading,
        activeTabIndex,
        isTabChanged,
        activeTafseerData,
      ];

  TafseerPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    String? activeDownloadId,
    List<TTDbFileModel>? availableItems,
    List<TTDbFileModel>? selectedItems,
    List<MapEntry<String, List<TTDbFileModel>>>? downloadableItems,
    bool? isDownloading,
    int? downloadProgress,
    int? totalAvailableToDownloadItemsCount,
    List<double>? totalSizes,
    bool? isAllFilesDownloading,
    int? activeTabIndex,
    bool? isTabChanged,
    Map<int, Map<int, String>>? activeTafseerData,
  }) {
    return TafseerPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      activeDownloadId: activeDownloadId ?? this.activeDownloadId,
      availableItems: availableItems ?? this.availableItems,
      selectedItems: selectedItems ?? this.selectedItems,
      downloadableItems: downloadableItems ?? this.downloadableItems,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      totalAvailableToDownloadItemsCount: totalAvailableToDownloadItemsCount ?? this.totalAvailableToDownloadItemsCount,
      totalSizes: totalSizes ?? this.totalSizes,
      isAllFilesDownloading: isAllFilesDownloading ?? this.isAllFilesDownloading,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      isTabChanged: isTabChanged ?? this.isTabChanged,
      activeTafseerData: activeTafseerData ?? this.activeTafseerData,
    );
  }
}