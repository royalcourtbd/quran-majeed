import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';

class SettingsUiState extends BaseUiState {
  const SettingsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.settingsState,
    required this.selectedIndex,
  });

  factory SettingsUiState.empty() {
    return const SettingsUiState(
      isLoading: false,
      userMessage: null,
      settingsState: null,
      selectedIndex: 0,
    );
  }

  final SettingsStateEntity? settingsState;
  final int? selectedIndex;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        settingsState,
        selectedIndex,
      ];

  SettingsUiState copyWith({
    SettingsStateEntity? settingsState,
    bool? isLoading,
    String? errorMessage,
    int? selectedIndex,
  }) {
    return SettingsUiState(
      settingsState: settingsState ?? this.settingsState,
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
