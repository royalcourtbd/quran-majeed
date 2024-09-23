import 'package:quran_majeed/core/base/base_ui_state.dart';

class MusafPageUiState extends BaseUiState {
  const MusafPageUiState({
    required super.isLoading,
    required super.userMessage,
  });

  @override

  List<Object?> get props => [];

  factory MusafPageUiState.empty() {
    return const MusafPageUiState(
      isLoading: false,
      userMessage: null,
    );
  }

  MusafPageUiState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return MusafPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
    );
  }
}
