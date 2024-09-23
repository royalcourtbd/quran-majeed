import 'package:flutter/material.dart';

import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/bug_report_page.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/contact_us_page.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/custom_drawer_tile.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/drawer_title_widget.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/our_projects.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/share_screen_shot_popup_dialog.dart';

class OthersDrawerWidget extends StatelessWidget {
  OthersDrawerWidget({super.key, required this.theme});
  final ThemeData theme;

  late final MainPagePresenter _drawerPresenter = locate();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerTitleWidget(title: context.l10n.others, theme: theme),
        CustomDrawerTile(
            title: context.l10n.ourProject,
            svgPath: SvgPath.icOurProject,
            onTap: () => context.navigatorPush<void>(OurProjectsPage())),
        CustomDrawerTile(
            title: context.l10n.privacyPolicy,
            svgPath: SvgPath.icPrivacyPolicy,
            onTap: () => _drawerPresenter.onTapPrivacyPolicy(context)),
        CustomDrawerTile(
            title: context.l10n.reportABug,
            svgPath: SvgPath.icBug,
            onTap: () => context.navigatorPush(BugReportPage())),
        CustomDrawerTile(
            title: context.l10n.aboutUs,
            svgPath: SvgPath.icAboutUs,
            onTap: () => _drawerPresenter.onClickAboutUs(context)),
        CustomDrawerTile(
            title: context.l10n.thanksAndCredit,
            svgPath: SvgPath.icCredit,
            onTap: () => _drawerPresenter.onClickThanks(context)),
        CustomDrawerTile(
            title: context.l10n.contactUs,
            svgPath: SvgPath.icContact,
            onTap: () => context.navigatorPush<void>(ContactUsPage())),
        CustomDrawerTile(
            title: context.l10n.giveRating,
            svgPath: SvgPath.icRating,
            onTap: () {}),
        CustomDrawerTile(
            title: context.l10n.shareThisApp,
            svgPath: SvgPath.icShare,
            onTap: () {
              context.navigatorPop();
              ShareScreenShotPopupDialog.show(context: context);
            }),
        CustomDrawerTile(
            title: "${context.l10n.visit} Quranmazid.com",
            svgPath: SvgPath.icVisit,
            onTap: () {}),
      ],
    );
  }
}
