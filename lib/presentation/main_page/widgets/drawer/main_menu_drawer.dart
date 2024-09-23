import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/daily_ayah/ui/daily_ayah_page.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/custom_drawer_tile.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/drawer_title_widget.dart';
import 'package:quran_majeed/presentation/settings/ui/settings_page.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';

class MainMenuDrawerWidget extends StatelessWidget {
  MainMenuDrawerWidget({super.key, required this.theme});
  final ThemeData theme;
  late final MainPagePresenter _drawerPresenter = locate<MainPagePresenter>();
  late final TranslationPresenter _translationPresenter =
      locate<TranslationPresenter>();
  late final TafseerPresenter _tafseerPresenter = locate<TafseerPresenter>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerTitleWidget(
          title: context.l10n.mainMenu,
          theme: theme,
        ),
        CustomDrawerTile(
            title: context.l10n.settings,
            svgPath: SvgPath.icSettings,
            onTap: () => context.navigatorPush<void>(SettingsPage())),
        CustomDrawerTile(
            title: context.l10n.sadaqahJariah,
            svgPath: SvgPath.icSadaqa,
            onTap: () => _drawerPresenter.onClickSadaqa(context)),
        CustomDrawerTile(
          title: context.l10n.dailyAyah,
          svgPath: SvgPath.icDailyAyah,
          onTap: () => context.navigatorPush<void>(DailyAyahPage()),
        ),
        CustomDrawerTile(
          title: context.l10n.jumpToAyah,
          svgPath: SvgPath.icJumpTo,
          onTap: () => _drawerPresenter.openJumpToAyahBottomSheet(context),
        ),
        // CustomDrawerTile(
        //     title: "Notification",
        //     svgPath: SvgPath.icNotification,
        //     isNotification: true,
        //     notificationCount: 2,
        //     onTap: () => context.navigatorPush<void>(NotificationPage())
        // ),
        CustomDrawerTile(
          title: context.l10n.tafseerList,
          svgPath: SvgPath.icTafseer,
          onTap: () => context.navigatorPush<void>(
            DownloadPage(
              presenter: _tafseerPresenter,
              title: context.l10n.tafseer,
              isTafseer: true,
            ),
          ),
        ),
        CustomDrawerTile(
          title: context.l10n.translationList,
          svgPath: SvgPath.icTranslate,
          onTap: () => context.navigatorPush<void>(
            DownloadPage(
              presenter: _translationPresenter,
              title: context.l10n.translation,
              isTafseer: false,
            ),
          ),
        ),
      ],
    );
  }
}
