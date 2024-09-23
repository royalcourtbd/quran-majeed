import 'package:cancellation_token/cancellation_token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/use_cases/info/close_announcement.dart';
import 'package:quran_majeed/domain/use_cases/notification/schedule_notification.dart';
import 'package:quran_majeed/domain/use_cases/settings/get_setting_use_case.dart';
import 'package:quran_majeed/domain/use_cases/settings/update_setting_use_case.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_ui_state.dart';
import 'package:quran_majeed/presentation/settings/services/theme_service_presentable.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

import 'package:synchronized/synchronized.dart';

class SettingsPresenter extends BasePresenter<SettingsUiState> {
  SettingsPresenter(
    this._getSettingsState,
    this._updateSettings,
    this._closeAnnouncement,
    this._scheduleNotification,
  );

  RxInt languageSelectIndex = 1.obs;
  final GetSettingsStateUseCase _getSettingsState;

  final Obs<SettingsUiState> uiState = Obs(SettingsUiState.empty());

  final UpdateSettingsUseCase _updateSettings;

  @override
  Future<void> onReady() async {
    fixStatusBarColor();
    super.onReady();
    await _fetchCurrentSettingsState();
  }

  String getSelectedReciterName() {
    late final ReciterPresenter reciterPresenter = locate<ReciterPresenter>();
    final String selectedReciterName =
        reciterPresenter.currentUiState.selectedReciter.name;
    return selectedReciterName;
  }

  String getSelectedTranslationName() {
    late final TranslationPresenter translationPresenter =
        locate<TranslationPresenter>();
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<TTDbFileModel>? selectedItems =
        translationPresenter.currentUiState.selectedItems;
    final String translationName =
        selectedItems != null && selectedItems.isNotEmpty
            ? selectedItems.length > 1
                ? "Multiple Translations"
                : selectedItems.first.name
            : "No Translation Selected";
    return translationName;
  }

  // Translation Related Code

  Future<void> _fetchCurrentSettingsState() async {
    final SettingsStateEntity settingsState = await _getSettingsState.execute();
    uiState.value = uiState.value.copyWith(settingsState: settingsState);
  }

  Future<void> _updateSettingsState(
    SettingsStateEntity updatedSettingsState,
  ) async {
    uiState.value = uiState.value.copyWith(settingsState: updatedSettingsState);
    await _updateSettings.execute(settingsState: updatedSettingsState);
  }

  late final Lock setArabicFontLock = Lock();
  Future<void> changeFont({required ArabicFonts font}) {
    return setArabicFontLock.synchronized(() async {
      final SettingsStateEntity updatedSettingsState =
          _currentSettingState.copyWith(arabicFont: font);
      await _updateSettingsState(updatedSettingsState);
    });
  }

  late final Lock setArabicScriptLock = Lock();
  Future<void> changeScript({required ArabicFontScript script}) {
    return setArabicScriptLock.synchronized(() async {
      final SettingsStateEntity updatedSettingsState =
          _currentSettingState.copyWith(arabicFontScript: script);
      await _updateSettingsState(updatedSettingsState);
    });
  }

  void fixStatusBarColor() {
    const Color color = Colors.transparent;
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarIconBrightness:
          Get.isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          Get.isDarkMode ? QuranColor.cardColorDark : QuranColor.cardColorLight,
      statusBarColor: color,
    );

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
  }

  SettingsStateEntity get _currentSettingState =>
      uiState.value.settingsState ?? SettingsStateEntity.empty();

  Future<void> toggleWakeLock({required bool turnOn}) async {
    // await catchFutureOrVoid(() async => WakelockPlus.toggle(enable: turnOn));
  }

  Future<void> toggleWakeLockBasedOnState() async {
    await catchFutureOrVoid(() async {
      await onReady();

      await toggleWakeLock(turnOn: _currentSettingState.keepScreenOn);
    });
  }

  late final Lock setArabicFontSizeLock = Lock();

  Future<void> changeArabicFontSize({required double fontSize}) async {
    await setArabicFontSizeLock.synchronized(() async {
      final SettingsStateEntity updatedSettingsState =
          _currentSettingState.copyWith(arabicFontSize: fontSize);
      await _updateSettingsState(updatedSettingsState);
    });
  }

  late final Lock setLocalFontSizeLock = Lock();

  Future<void> changeLocalFontSize({required double fontSize}) async {
    await setLocalFontSizeLock.synchronized(() async {
      final SettingsStateEntity updatedSettingsState =
          _currentSettingState.copyWith(localFontSize: fontSize);
      await _updateSettingsState(updatedSettingsState);
    });
  }

  Future<void> changeTafseerFontSize({required double fontSize}) async {
    await setLocalFontSizeLock.synchronized(() async {
      final SettingsStateEntity updatedSettingsState =
          _currentSettingState.copyWith(tafseerFontSize: fontSize);
      await _updateSettingsState(updatedSettingsState);
    });
  }

  String getSelectedTafseerName() {
    late final TafseerPresenter tafseerPresenter = locate<TafseerPresenter>();
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<TTDbFileModel>? selectedItems =
        tafseerPresenter.currentUiState.selectedItems;
    final String tafseerName = selectedItems != null && selectedItems.isNotEmpty
        ? selectedItems.length > 1
            ? "Multiple Tafseers"
            : selectedItems.first.name
        : "No Tafseer Selected";
    return tafseerName;
  }

  Future<void> setArabicFont({required ArabicFonts arabicFont}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(arabicFont: arabicFont);
    await _updateSettingsState(updatedSettingsState);
  }

  Future<void> setArabicScript({required ArabicFontScript arabicScript}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(arabicFontScript: arabicScript);
    await _updateSettingsState(updatedSettingsState);
  }

  Future<void> toggleShowArabic({required bool showArabic}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(showArabic: showArabic);
    await _updateSettingsState(updatedSettingsState);
  }

  String getFontSectionTitle(BuildContext context, ArabicFontScript script) {
    return script == ArabicFontScript.uthmani
        ? context.l10n.uthmaniMadani
        : context.l10n.indopakAsian;
  }

  Future<void> toggleShowTranslation({required bool showTranslation}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(showTranslation: showTranslation);
    await _updateSettingsState(updatedSettingsState);
  }

  Future<void> toggleShowWordByWord({required bool showWordByWord}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(showWordByWord: showWordByWord);
    await _updateSettingsState(updatedSettingsState);
  }

  Future<void> toggleNightMode({required bool nightMode}) async {
    final SettingsStateEntity updatedSettingsState = _currentSettingState
        .copyWith(themeState: nightMode ? ThemeState.dark : ThemeState.light);
    uiState.value = uiState.value.copyWith(settingsState: updatedSettingsState);
    await ThemeServicePresentable.toggleDarkMode(nightMode: nightMode);
    await _updateSettingsState(updatedSettingsState);
  }

  Future<void> toggleSystemMode({required ThemeState themeState}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(themeState: themeState);
    uiState.value = uiState.value.copyWith(settingsState: updatedSettingsState);
    _isDeviceInDarkMode
        ? await ThemeServicePresentable.toggleDarkMode(nightMode: true)
        : await ThemeServicePresentable.toggleDarkMode(nightMode: false);
    await _updateSettingsState(updatedSettingsState);
  }

  static bool get _isDeviceInDarkMode {
    final isDarkMode = catchAndReturn(() {
      final PlatformDispatcher platformDispatcher =
          WidgetsBinding.instance.platformDispatcher;
      final Brightness brightness = platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    });
    return isDarkMode ?? false;
  }

  Future<void> toggleScreenOn({required bool screenOn}) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(keepScreenOn: screenOn);
    await toggleWakeLock(turnOn: screenOn);
    await _updateSettingsState(updatedSettingsState);
  }

  final CloseAnnouncementUseCase _closeAnnouncement;

  Future<void> closeNoticeBox(PromotionalMessageEntity message) async {
    final Either<String, Unit> result =
        await _closeAnnouncement.execute(userSeen: true);

    result.fold(addUserMessage, doNothing);
  }

  Future<void> setNotificationTime({
    required TimeOfDay notificationTime,
  }) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(dailyNotificationTime: notificationTime);
    await _updateSettingsState(updatedSettingsState);
    await _scheduleNotificationExecution(
      _currentSettingState.showDailyNotification,
      notificationTime,
    );
  }

  CancellationToken? _toggleShowNotificationCancellationToken;

  Future<void> toggleShowNotification({required bool showNotification}) async {
    if (_toggleShowNotificationCancellationToken != null) {
      _toggleShowNotificationCancellationToken?.cancel();
    }
    _toggleShowNotificationCancellationToken = CancellationToken();
    await catchFutureOrVoid(
      () async => CancellableFuture.from(
        () async => _toggleShowNotification(showNotification),
        _toggleShowNotificationCancellationToken,
      ),
    );
  }

  Future<void> _toggleShowNotification(bool showNotification) async {
    final SettingsStateEntity updatedSettingsState =
        _currentSettingState.copyWith(showDailyNotification: showNotification);
    await _updateSettingsState(updatedSettingsState);
    final TimeOfDay dailyNotificationTime =
        _currentSettingState.dailyNotificationTime;
    await _scheduleNotificationExecution(
      showNotification,
      dailyNotificationTime,
    );
  }

  final ScheduleNotificationUseCase _scheduleNotification;

  Future<void> _scheduleNotificationExecution(
    bool showNotification,
    TimeOfDay dailyNotificationTime,
  ) async {
    await executeMessageOnlyUseCase(
      () => _scheduleNotification.execute(
        turnOn: showNotification,
        time: dailyNotificationTime,
      ),
    );
  }

  String getLocalizedScriptTitle(
      BuildContext context, ArabicFontScript arabicFontScript) {
    switch (arabicFontScript) {
      case ArabicFontScript.uthmani:
        return context.l10n.uthmaniMadani;
      case ArabicFontScript.indoPak:
        return context.l10n.indopakAsian;
      default:
        return '';
    }
  }

  Map<String, String> appLanguageList = {
    "bn_BD": "বাংলা (Bangla)",
    "en_US": "English",
    "ar_SA": "العربية (Arabic)",
    "in_ID": "Bahasa Indonesia (Indonesian)",
    "ms_MY": "Bahasa Melayu (Malaysian)",
    "de_DE": "Deutsch (German)",
    "fr_FR": "Français (French)",
    "ku_KU": "كوردى (Kurdish)",
    "it_IT": "Italiano (Italian)",
    "ru_RU": "Русский (Russian)",
    "es_ES": "Español (Spanish)",
    "tr_TR": "Türkçe (Turkish)",
    "ur_PK": "اردو (Urdu)",
    "uz_UZB": "O'zbek (Uzbek)",
    "zh_CN": "中文 (Chinese)",
    "fil_PH": "Tagalog (Filipino)",
    "pt_PT": "Português (Portuguese)",
    "bs_BA": "Bosanski (Bosnian)",
    "hr_HR": "hrvatski (Croatian)",
    "sr_BA": "srpski (Serbian)",
    "fa_IR": "فارسی (Persian)",
    "th_TH": "ภาษาไทย (Thai)",
    "sq_ALB": "shqip (Albanian)",
  };

  bool checkIfSelected({required int index}) {
    return uiState.value.selectedIndex == index;
  }

  void selectIndex({required int index}) {
    uiState.value = uiState.value.copyWith(selectedIndex: index);
  }

  @override
  Future<void> addUserMessage(String message) async {
    return showMessage(message: 'Set Notification Time');
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = uiState.value.copyWith(isLoading: loading);
  }
}
