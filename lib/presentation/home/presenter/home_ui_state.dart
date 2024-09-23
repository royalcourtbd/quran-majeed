import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/data/model_class/home_category_model.dart';
import 'package:quran_majeed/domain/entities/notification/announcement_entity.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';

class HomeUiState extends BaseUiState {
  const HomeUiState({
    required this.homeCategoryList,
    required this.surahList,
    required super.isLoading,
    required super.userMessage,
        required this.announcement,
    required this.tabButtonCurrentIndex,
  });

  factory HomeUiState.empty() {
    return HomeUiState(
      surahList: const [],
      userMessage: null,
      isLoading: true,
      homeCategoryList: const [],
      announcement: AnnouncementEntity.empty(),
      tabButtonCurrentIndex: 0,
    );
  }

  final List<HomeCategoryModel> homeCategoryList;
  final List<SurahEntity> surahList;
    final AnnouncementEntity announcement;
  final int tabButtonCurrentIndex;

  @override
  List<Object?> get props => [
        homeCategoryList,
        userMessage,
        surahList,
        isLoading,
        announcement,
        tabButtonCurrentIndex,
      ];

  HomeUiState copyWith({
    List<HomeCategoryModel>? homeCategoryList,
    List<SurahEntity>? surahList,
    String? errorMessage,
    bool? isLoading,
    bool? isFirstTime,
      AnnouncementEntity? announcement,
    int? tabButtonCurrentIndex,
  }) {
    return HomeUiState(
      homeCategoryList: homeCategoryList ?? this.homeCategoryList,
      surahList: surahList ?? this.surahList,
      userMessage: errorMessage ?? userMessage,
      isLoading: isLoading ?? this.isLoading,
    announcement: announcement ?? this.announcement,
      tabButtonCurrentIndex: tabButtonCurrentIndex ?? this.tabButtonCurrentIndex,
    );
  }
}
