import 'package:quran_majeed/core/base/base_ui_state.dart';

class DuaUiState extends BaseUiState {
  const DuaUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory DuaUiState.empty() => const DuaUiState(
        isLoading: false,
        userMessage: "",
      );

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
      ];

  DuaUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return DuaUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
