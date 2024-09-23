import 'package:quran_majeed/core/base/base_ui_state.dart';

import '../../../domain/entities/memorization/mermoization_entity.dart';

class MemorizationUiState extends BaseUiState {
  const MemorizationUiState({
    required super.isLoading,
    required super.userMessage,
    required this.showNotification,
    required this.memorizations,
    required this.isPlaying,
    this.memorizationCreatingItem,
  });

  factory MemorizationUiState.empty() {
    return MemorizationUiState(
      isLoading: true,
      userMessage: null,
      showNotification: false,
      memorizations: const [],
      isPlaying: false,
      memorizationCreatingItem: MemorizationEntity(),
    );
  }

  final bool showNotification;
  final List<MemorizationEntity> memorizations;
  final MemorizationEntity? memorizationCreatingItem;
  final bool isPlaying;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        showNotification,
        memorizationCreatingItem,
        memorizations,
        isPlaying,
      ];

  MemorizationUiState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? showNotification,
    List<MemorizationEntity>? memorizations,
    MemorizationEntity? memorizationCreatingItem,
    bool? isPlaying,
  }) {
    return MemorizationUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
      showNotification: showNotification ?? this.showNotification,
      memorizations: memorizations ?? this.memorizations,
      memorizationCreatingItem:
          memorizationCreatingItem ?? this.memorizationCreatingItem,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
