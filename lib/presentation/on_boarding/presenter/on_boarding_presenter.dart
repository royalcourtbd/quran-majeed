import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/splash/splash_screen.dart';
import 'package:quran_majeed/core/external_libs/throttle_service.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/ui_helper.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/service/notification_service.dart';
import 'package:quran_majeed/domain/use_cases/info/determine_first_run.dart';
import 'package:quran_majeed/domain/use_cases/info/save_first_time.dart';
import 'package:quran_majeed/domain/use_cases/info/set_up_app.dart';
import 'package:quran_majeed/presentation/main_page/ui/main_page.dart';
import 'package:quran_majeed/presentation/on_boarding/model/language_model.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_ui_state.dart';
import 'package:quran_majeed/presentation/settings/services/theme_service_presentable.dart';

class OnBoardingPresenter extends BasePresenter<OnBoardingUiState> {
  OnBoardingPresenter(
    this._determineFirstRun,
    this._setUpApp,
    this._saveFirstTime,
  );

  final DetermineFirstRun _determineFirstRun;
  final PageController pageController = PageController();
  final SetUpAppUseCase _setUpApp;
  final SaveFirstTimeUseCase _saveFirstTime;

  static const Duration _pageTransitionAnimationDuration =
      Duration(milliseconds: 250);

  OnBoardingUiState get currentUiState => uiState.value;

  final Obs<OnBoardingUiState> uiState = Obs(OnBoardingUiState.empty());

  @override
  Future<void> onInit() async {
    _setUpApp.listenable(warmUpOnly: true);
    await loadLanguageList();
    await SplashScreen.hide();

    super.onInit();
  }

  Future<void> goToNextPage() async {
    await pageController.nextPage(
      duration: _pageTransitionAnimationDuration,
      curve: Curves.easeIn,
    );
  }

  void showNotificationWarningMessage() {
    uiState.value = uiState.value.copyWith(showNotificationWarning: true);
  }

  Future<void> onNotificationPermissionGranted() async {
    uiState.value = uiState.value.copyWith(
      isNotificationEnabled: true,
      showNotificationWarning: false,
    );
  }

  bool isScreenBeforeNoticeAskingScreen(screenIndex) => screenIndex == 1;
  Future<void> onTapNextButton() async {
    if (isScreenBeforeNoticeAskingScreen(pageController.page!.toInt())) {
      final NotificationService notificationService =
          locate<NotificationService>();
      await notificationService.askNotificationPermission(
        onGrantedOrSkippedForNow: () {
          onNotificationPermissionGranted();
          goToNextPage();
        },
        onDenied: showNotificationWarningMessage,
      );
      return;
    }
    goToNextPage();
  }

  Future<void> goToHomePage(BuildContext context) async {
    Throttle.throttle(
      "go_to_home_throttle",
      1.inSeconds,
      () async {
        final MainPage quranHomePage = await Future.microtask(() => MainPage());

        if (context.mounted) {
          await context.navigatorPushReplacement(quranHomePage);
        }
      },
    );
  }

  Future<void> onScreenChanges(int screenIndex, BuildContext context) async {
    final bool isDbLoadingScreen =
        screenIndex == OnBoardingScreen.databaseLoadingIndex;
    if (isDbLoadingScreen) {
      await UiHelper.doOnPageLoaded(
        () => setUpApplication(onComplete: () => goToHomePage(context)),
      );
    }
  }

  Future<void> fetchAndListenToData(BuildContext context) async {
    await Future<void>.delayed(580.inMilliseconds);
    final bool isFirstTime = await determineIfFirstTime();
    if (!isFirstTime && context.mounted) await goToHomePage(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<bool> determineIfFirstTime() async {
    await toggleLoading(loading: true);
    final bool isFirstTime = await _determineFirstRun.execute();
    uiState.value = uiState.value.copyWith(isFirstTime: isFirstTime);
    await toggleLoading(loading: false);
    await ThemeServicePresentable.loadCurrentTheme(isFirstTime: isFirstTime);

    if (isFirstTime) {
      await SplashScreen.hide();
      return true;
    }
    return false;
  }

  Future<void> doneWithFirstTime() async {
    await toggleLoading(loading: true);
    await _saveFirstTime.execute();
    uiState.value = uiState.value.copyWith(isFirstTime: false);
    await toggleLoading(loading: false);
  }

  Future<void> setUpApplication({required VoidCallback onComplete}) async {
    await toggleLoading(loading: true);
    _setUpApp
        .listenable()
        .listen((res) => _handleSetUpAppResult(res, onComplete));
    await toggleLoading(loading: false);
  }

  ///TODO: Demo Code, Ui Korar jonno kora hoisilo, eta remove kore abar korte hobe
  Future<void> loadLanguageList() async {
    final String response =
        await rootBundle.loadString('assets/jsonFile/languages_list.json');
    final data = LanguageModel.fromJson(json.decode(response));
    uiState.value = currentUiState.copyWith(languages: data);
  }

  void selectLanguage(int index) {
    uiState.value = currentUiState.copyWith(selectedLanguageIndex: index);
  }

  Future<void> _handleSetUpAppResult(
    Either<String, (double, String)> result,
    VoidCallback onComplete,
  ) async {
    await result.fold(addUserMessage, (progressMessageRecord) async {
      final (progress, message) = progressMessageRecord;
      await _updatedCurrentProgress(
        message: message,
        progress: progress,
      );
      if (progress == 100) {
        await doneWithFirstTime();
        onComplete();
      }
    });
  }

  Future<void> _updatedCurrentProgress({
    required String message,
    required double progress,
  }) async {
    uiState.value = uiState.value
        .copyWith(progressMessage: message, progressValue: progress);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = uiState.value.copyWith(isLoading: loading);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value =
        uiState.value.copyWith(userMessage: message, isLoading: false);
    await Future<void>.delayed(112.inMilliseconds);
    uiState.value = uiState.value.copyWith(userMessage: "", isLoading: false);
  }
}
