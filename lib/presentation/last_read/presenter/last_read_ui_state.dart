import 'package:quran_majeed/core/base/base_ui_state.dart';

import '../../../domain/entities/last_read_entity.dart';

class LastReadUiState extends BaseUiState {
  const LastReadUiState({
    required super.isLoading,
    required super.userMessage,
    required this.lastReadList,
    required this.checkBox,
    required this.isSelected,
  });

  factory LastReadUiState.empty() {
    return const LastReadUiState(
      isLoading: true,
      userMessage: null,
      lastReadList: [],
      checkBox: false,
      isSelected: {},
    );
  }

  final List<LastReadEntity> lastReadList;
  final bool checkBox;
  final Set isSelected;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        lastReadList,
        checkBox,
        isSelected,
      ];

  LastReadUiState copyWith({
    List<LastReadEntity>? lastReadList,
    bool? isLoading,
    String? errorMessage,
    bool? checkBox,
    Set? isSelected,
  }) {
    return LastReadUiState(
      lastReadList: lastReadList ?? this.lastReadList,
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
      checkBox: checkBox ?? this.checkBox,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
