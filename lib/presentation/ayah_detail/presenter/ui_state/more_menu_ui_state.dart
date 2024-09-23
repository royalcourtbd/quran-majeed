
import 'package:quran_majeed/core/base/base_ui_state.dart';

class MoreMenuUiState extends BaseUiState {
  const MoreMenuUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory MoreMenuUiState.empty() => const MoreMenuUiState(
        isLoading: false,
        userMessage: "",
      );

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  MoreMenuUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return MoreMenuUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
