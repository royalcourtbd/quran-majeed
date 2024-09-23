import 'package:quran_majeed/core/base/base_ui_state.dart';

class ShaneNuzulUiState extends BaseUiState {
  const ShaneNuzulUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory ShaneNuzulUiState.empty() {
    return const ShaneNuzulUiState(
      isLoading: true,
      userMessage: null,
    );
  }

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
      ];

  ShaneNuzulUiState copyWith({
    String? userMessage,
    bool? isLoading,
  }) {
    return ShaneNuzulUiState(
      userMessage: userMessage ?? userMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
