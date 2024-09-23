import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/splash/splash_screen.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';
 
void main() async {
  await _init();
  runApp(const QuranMajeed());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SplashScreen.show();
  await ServiceLocator.setUp();
  await _setMaxRefreshRate();
}

Future<void> _setMaxRefreshRate() async {
  if (!Platform.isAndroid) return;
  await catchFutureOrVoid(() async => FlutterDisplayMode.setHighRefreshRate());
}
