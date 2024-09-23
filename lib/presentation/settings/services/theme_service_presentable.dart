import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/config/themes.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';

class ThemeServicePresentable {
  ThemeServicePresentable._();

  static Future<void> toggleDarkMode({required bool nightMode}) async {
    await catchFutureOrVoid(() async {
      // Get.changeThemeMode(nightMode ? ThemeMode.dark : ThemeMode.light);
      await fixStatusBarManually(isDarkModeMaybe: nightMode);
    });
  }

  static Future<void> fixStatusBarManually({
    bool? isDarkModeMaybe,
    BuildContext? context,
  }) async {
    await catchFutureOrVoid(() async {
      final SystemUiOverlayStyle? uiOverlayStyle =
          await getSystemUiOverlayStyle(
        isDark: isDarkMode(context ?? QuranMajeed.globalContext),
        context: context,
      );
      if (uiOverlayStyle != null) {
        SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
      }
    });
  }

  static Future<void> fixStatusBarManuallyInSplashScreen({
    bool? isDarkModeMaybe,
    BuildContext? context,
  }) async {
    await catchFutureOrVoid(() async {
      final Color systemNavigationBarColor = isDarkMode(context ?? Get.context!)
          ? const Color(0xff161C23)
          : const Color(0xffffffff);
      final SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
    });
  }

  static Future<void> loadCurrentTheme({bool? isFirstTime}) async {
    await catchFutureOrVoid(() async {
      final SettingsPresenter settingsPresenter = locate<SettingsPresenter>();
      await settingsPresenter.onReady();

      final SettingsStateEntity? settingsState =
          settingsPresenter.uiState.value.settingsState;
      final bool noThemeSelected = settingsState?.themeState == null;

      if (noThemeSelected || (isFirstTime ?? false)) {
        final bool isDarkMode = _isDeviceInDarkMode;
        await settingsPresenter.toggleNightMode(nightMode: isDarkMode);
        await toggleDarkMode(nightMode: isDarkMode);
        return;
      }

      final bool nightMode = settingsState?.themeState == ThemeState.dark;
      await toggleDarkMode(nightMode: nightMode);
    });
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
}
