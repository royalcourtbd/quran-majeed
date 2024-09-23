import 'package:quran_majeed/core/base/base_ui_state.dart';

class SearchUiState extends BaseUiState {
  const SearchUiState({
    required super.isLoading,
    required super.userMessage,
    required this.searchInGroupValue,
    required this.searchHistoryGroupValue,
  });

  factory SearchUiState.empty() {
    return const SearchUiState(
      userMessage: null,
      isLoading: true,
      searchInGroupValue: 0,
      searchHistoryGroupValue: '',
    );
  }
//create your variables here
  final int searchInGroupValue;
  final String searchHistoryGroupValue;

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
        searchInGroupValue,
        searchHistoryGroupValue,
      ];

  SearchUiState copyWith({
    String? errorMessage,
    bool? isLoading,
    int? searchGroupValue,
    String? searchHistoryGroupValue,
  }) {
    return SearchUiState(
      userMessage: errorMessage ?? userMessage,
      isLoading: isLoading ?? this.isLoading,
      searchInGroupValue: searchGroupValue ?? searchInGroupValue,
      searchHistoryGroupValue:
          searchHistoryGroupValue ?? this.searchHistoryGroupValue,
    );
  }
}
