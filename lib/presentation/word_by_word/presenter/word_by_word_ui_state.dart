import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';

class WordByWordUiState extends BaseUiState {
  final List<WbwDbFileModel> availableLanguages;
  final List<String> downloadedLanguages;
  final String selectedLanguage;
   final bool isDownloading;
  final String? activeDownloadId;
  final int downloadProgress;

  const WordByWordUiState({
    required this.availableLanguages,
    required this.downloadedLanguages,
    required this.selectedLanguage,
  required this.isDownloading,
    this.activeDownloadId,
    required this.downloadProgress,
    super.isLoading = false,
    super.userMessage,
  });

  factory WordByWordUiState.empty() {
    return const WordByWordUiState(
      availableLanguages: [],
      downloadedLanguages: ['English', 'Bangla'],
      selectedLanguage: 'English',
      isLoading: false,
       isDownloading: false,
      activeDownloadId: null,
      downloadProgress: 0,
    );
  }

  @override
  List<Object?> get props => [
        availableLanguages,
        downloadedLanguages,
        selectedLanguage,
          isDownloading,
        activeDownloadId,
        downloadProgress,
        isLoading,
        userMessage,
      ];

  WordByWordUiState copyWith({
    List<WbwDbFileModel>? availableLanguages,
    List<String>? downloadedLanguages,
    String? selectedLanguage,
      bool? isDownloading,
    String? activeDownloadId,
    int? downloadProgress,
    bool? isLoading,
    String? userMessage,
  }) {
    return WordByWordUiState(
      availableLanguages: availableLanguages ?? this.availableLanguages,
      downloadedLanguages: downloadedLanguages ?? this.downloadedLanguages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
           isDownloading: isDownloading ?? this.isDownloading,
      activeDownloadId: activeDownloadId ?? this.activeDownloadId,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}