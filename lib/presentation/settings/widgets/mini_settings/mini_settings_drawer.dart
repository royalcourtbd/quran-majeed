import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/content_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/font_settings_card.dart';
import 'package:quran_majeed/presentation/settings/ui/settings_page.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_switch.dart';

class MiniSettingsDrawer extends StatelessWidget {
  MiniSettingsDrawer({
    super.key,
    this.showOnlyFontSettings = false,
    this.showTafseerFontSlider = false,
  });

  final bool showOnlyFontSettings;
  final bool showTafseerFontSlider;

  late final SettingsPresenter _settingPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      height: double.infinity,
      width: QuranScreen.width * 0.75,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const MiniSettingsTopBar(),
            gapH5,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: showOnlyFontSettings
                      ? [
                          FontSettingsCard(
                            settingPresenter: _settingPresenter,
                            showTextReview: false,
                            showTafseerFontSlider: showTafseerFontSlider,
                          ),
                        ]
                      : [
                          ContentSettingsCard(
                            settingPresenter: _settingPresenter,
                            isFromSettingsPage: false,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: twentyPx),
                            child: BuildDivider(
                              theme: themeData,
                            ),
                          ),

                          WordByWordSwitch(
                            settingPresenter: _settingPresenter,
                            theme: themeData,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: twentyPx),
                            child: BuildDivider(
                              theme: themeData,
                            ),
                          ),
                          FontSettingsCard(
                            settingPresenter: _settingPresenter,
                            showTextReview: false,
                          ),

                          //NotificationSettingsCard(),
                          //  const AppearanceSettingsCard(),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniSettingsTopBar extends StatelessWidget {
  const MiniSettingsTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: twelvePx,
        right: twelvePx,
        top: twentyOnePx,
      ),
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.navigatorPop(),
            child: Padding(
              padding: paddingH6,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: sixteenPx,
                color: themeData.colorScheme.scrim,
              ),
            ),
          ),
          gapW8,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.quickTools,
              style: themeData.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: themeData.primaryColor,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await context.navigatorPush<void>(SettingsPage());
            },
            child: SvgPicture.asset(
              SvgPath.icSettings,
              height: twentyOnePx,
              colorFilter:
                  buildColorFilter(Theme.of(context).colorScheme.scrim),
            ),
          ),
        ],
      ),
    );
  }
}
