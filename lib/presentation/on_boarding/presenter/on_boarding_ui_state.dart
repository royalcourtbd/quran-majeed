import 'package:equatable/equatable.dart';
import 'package:quran_majeed/core/base/base_ui_state.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/presentation/on_boarding/model/language_model.dart';

class OnBoardingUiState extends BaseUiState {
  const OnBoardingUiState({
    required this.progressMessage,
    required this.progressValue,
    required this.isFirstTime,
    required super.isLoading,
    required super.userMessage,
    required this.screenList,
    required this.languages,
    required this.selectedLanguageIndex,
    required this.isNotificationEnabled,
    required this.showNotificationWarning,
  });

  factory OnBoardingUiState.empty() => OnBoardingUiState(
        progressMessage: "",
        progressValue: 0,
        isLoading: false,
        userMessage: "",
        isFirstTime: true,
        screenList: onBoardingScreenList,
        languages: LanguageModel(languages: []),
        selectedLanguageIndex: 0,
        isNotificationEnabled: false,
        showNotificationWarning: false,
      );

  final String progressMessage;
  final double progressValue;
  final bool isFirstTime;
  final List<OnBoardingScreen> screenList;
  final LanguageModel languages;
  final int selectedLanguageIndex;
  final bool isNotificationEnabled;
  final bool showNotificationWarning;

  OnBoardingUiState copyWith({
    String? progressMessage,
    double? progressValue,
    bool? isLoading,
    String? userMessage,
    bool? isFirstTime,
    LanguageModel? languages,
    int? selectedLanguageIndex,
    bool? isNotificationEnabled,
    bool? showNotificationWarning,
  }) {
    return OnBoardingUiState(
      progressMessage: progressMessage ?? this.progressMessage,
      progressValue: progressValue ?? this.progressValue,
      isLoading: isLoading ?? super.isLoading,
      userMessage: userMessage ?? super.userMessage,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      screenList: onBoardingScreenList,
      languages: languages ?? this.languages,
      selectedLanguageIndex: selectedLanguageIndex ?? this.selectedLanguageIndex,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
      showNotificationWarning: showNotificationWarning ?? this.showNotificationWarning,
    );
  }

  @override
  List<Object?> get props => [
        progressMessage,
        progressValue,
        isFirstTime,
        super.isLoading,
        super.userMessage,
        screenList,
        languages,
        selectedLanguageIndex,
      ];
}

const List<OnBoardingScreen> onBoardingScreenList = [
  OnBoardingScreen(
    iconSvgPath: SvgPath.icSplashShowFeature,
    title: "Exciting Features in Quran App",
    description:
        "We have added many exciting new features like multiple translations, tafseers, audio, and many more. Let's explore them.",
  ),
  OnBoardingScreen(
    iconSvgPath: SvgPath.icSplashNotification,
    title: "We will send you some important notifications",
    description: "Please allow notification for Daily Ayah Reminder, Important Notices, and Update Reminder.",
  ),
 
  OnBoardingScreen(
    iconSvgPath: SvgPath.icSplashLoading,
    title: "Please Wait Sometime",
    description: "We are optimazing this app based on your selected language, please wait sometime",
  ),
];

class OnBoardingScreen extends Equatable {
  const OnBoardingScreen({
    required this.iconSvgPath,
    required this.title,
    required this.description,
  });

  final String iconSvgPath;
  final String title;
  final String description;

  @override
  List<Object?> get props => [iconSvgPath, title, description];

  static const int featureMentionScreenIndex = 0;
  static const int noticeAskingScreenIndex = 1;
  static const int databaseLoadingIndex = 2;
}
