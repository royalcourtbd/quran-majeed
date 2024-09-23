import 'package:quran_majeed/core/base/base_ui_state.dart';

class MainPageUiState extends BaseUiState {
  const MainPageUiState({
    required this.currentIndex,
    required super.isLoading,
    required super.userMessage,
  });

  factory MainPageUiState.empty() {
    return const MainPageUiState(
      currentIndex: 0,
      userMessage: null,
      isLoading: true,
    );
  }

  final int currentIndex;

  @override
  List<Object?> get props => [
        currentIndex,
        userMessage,
        isLoading,
      ];

  MainPageUiState copyWith({
    int? currentIndex,
    String? errorMessage,
    bool? isLoading,
  }) {
    return MainPageUiState(
      currentIndex: currentIndex ?? this.currentIndex,
      userMessage: errorMessage ?? userMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
