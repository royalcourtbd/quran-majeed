import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

class DailyAyahUiState extends BaseUiState {
  const DailyAyahUiState({
    required super.isLoading,
    required super.userMessage,
    required this.surahID,
    required this.ayahID,
    required this.wordByWordEntity,
  });

  final int surahID;
  final int ayahID;
  final List<WordByWordEntity>? wordByWordEntity;

  factory DailyAyahUiState.empty() {
    return const DailyAyahUiState(
      isLoading: true,
      userMessage: null,
      surahID: 1,
      ayahID: 1,
      wordByWordEntity:[]
    );
  }

  @override
  List<Object?> get props => [
        userMessage,
        isLoading,
        surahID,
        ayahID,
        wordByWordEntity,
      ];

  DailyAyahUiState copyWith({
    String? errorMessage,
    bool? isLoading,
    int? surahID,
    int? ayahID,
    List<WordByWordEntity>? wordByWordEntity,
  }) {
    return DailyAyahUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: errorMessage ?? userMessage,
      surahID: surahID ?? this.surahID,
      ayahID: ayahID ?? this.ayahID,
      wordByWordEntity: wordByWordEntity ?? this.wordByWordEntity,
    );
  }
}
