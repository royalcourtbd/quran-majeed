import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';

class TranslationUiState extends BaseUiState {
   final String activeDownloadId;
  final bool isDownloading;
  final bool isAllFilesDownloading;
  final int downloadProgress;
  final TTJsonModel jsonData;
  final List<TTDbFileModel> availableItems;
  final List<TTDbFileModel> selectedItems;
  final List<MapEntry<String, List<TTDbFileModel>>> downloadableItems;
  final int totalAvailableToDownloadItemsCount;
  final List<double> totalSizes;


  const TranslationUiState({
    required this.activeDownloadId,
    required this.jsonData,
    required this.availableItems,
    required this.selectedItems,
    required this.downloadableItems,
    required this.isDownloading,
    required this.downloadProgress,
    required super.isLoading,
    required super.userMessage,
    required this.totalAvailableToDownloadItemsCount,
    required this.totalSizes,
    required this.isAllFilesDownloading,
  });

  factory TranslationUiState.empty() {
    return TranslationUiState(
      userMessage: '',
      isLoading: false,
      activeDownloadId: '',
      isDownloading: false,
      downloadProgress: 0,
      jsonData: TTJsonModel.empty(),
      availableItems: const <TTDbFileModel>[],
      selectedItems: const <TTDbFileModel>[],
      downloadableItems: const <MapEntry<String, List<TTDbFileModel>>>[],
      totalAvailableToDownloadItemsCount: 0,
      totalSizes: const <double>[],
      isAllFilesDownloading: false,
    );
  }

 

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
        activeDownloadId,
        isDownloading,
        downloadProgress,
        jsonData,
        availableItems,
        selectedItems,
        downloadableItems,
        totalAvailableToDownloadItemsCount,
        totalSizes,
        isAllFilesDownloading,
      ];

  TranslationUiState copyWith({
    String? userMessage,
    bool? isLoading,
    String? activeDownloadId,
    bool? isDownloading,
    int? downloadProgress,
    TTJsonModel? jsonData,
    List<TTDbFileModel>? availableItems,
    List<TTDbFileModel>? selectedItems,
   List<MapEntry<String, List<TTDbFileModel>>>? downloadableItems,
    int? totalAvailableToDownloadItemsCount,
    List<double>? totalSizes,
     bool? isAllFilesDownloading,
  }) {
    return TranslationUiState(
      userMessage: userMessage ?? this.userMessage,
      isLoading: isLoading ?? this.isLoading,
      activeDownloadId: activeDownloadId ?? this.activeDownloadId,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      jsonData: jsonData ?? this.jsonData,
      availableItems: availableItems ?? this.availableItems,
      selectedItems: selectedItems ?? this.selectedItems,
      downloadableItems: downloadableItems ?? this.downloadableItems,
      totalAvailableToDownloadItemsCount:
          totalAvailableToDownloadItemsCount ?? this.totalAvailableToDownloadItemsCount,
      totalSizes: totalSizes ?? this.totalSizes,
      isAllFilesDownloading: isAllFilesDownloading ?? this.isAllFilesDownloading,
    );
  }
}
