import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/config/themes.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/l10n/l10n.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_features_page.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuranMajeed extends StatefulWidget {
  const QuranMajeed({super.key});

  static final GlobalKey _globalKey = GlobalKey();

  static BuildContext get globalContext =>
      Get.context ?? _globalKey.currentContext!;

  @override
  State<QuranMajeed> createState() => _QuranMajeedState();
}

class _QuranMajeedState extends State<QuranMajeed> with WidgetsBindingObserver {
  late final SettingsPresenter _presenter = locate();
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, oriantation, sreenType) {
        return Obx(
          () {
            return GetMaterialApp(
              key: QuranMajeed._globalKey,
              debugShowCheckedModeBanner: false,
              title: 'Quran Majeed',
              theme: QuranTheme.lightTheme,
              darkTheme: QuranTheme.darkTheme,
              themeMode: ThemeMode.system,
              supportedLocales: L10n.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: L10n.supportedLocales[1],
              defaultTransition: Transition.rightToLeftWithFade,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
              home: OnBoardingFeaturesPage(),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _presenter.fixStatusBarColor();

    if (state != AppLifecycleState.resumed) return;

    super.didChangeAppLifecycleState(state);
  }
}
