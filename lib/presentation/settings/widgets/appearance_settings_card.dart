import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/switch_setting_item.dart';
import 'package:quran_majeed/presentation/settings/widgets/tab_setting_header_widget.dart';
import 'package:quran_majeed/presentation/settings/widgets/theme_list_widget.dart';

class AppearanceSettingsCard extends StatelessWidget {
  const AppearanceSettingsCard({
    super.key,
    required this.settingPresenter,
    this.isFromSettingsPage = false,
  });

  final SettingsPresenter settingPresenter;
  final bool isFromSettingsPage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return SettingsContainer(
        child: Column(children: [
      isMobile
          ? SettingsCardHeader(
              title: context.l10n.appearance,
              svgPath: SvgPath.icAppearance,
            )
          : TabSettingHeaderWidget(title: context.l10n.appearance),
      Padding(
          padding:
              EdgeInsets.only(left: isFromSettingsPage ? thirtySevenPx : 0),
          child: Column(children: [
            //TODO: After implementing tajweed color , uncomment this
            isMobile ? gapH25 : gapH10,
            // SwitchSettingItem(
            //   title: "Tajweed Color",
            //   theme: theme,
            //   onChanged: (bool toggled) {},
            //   value: false,
            // ),
            // gapH5,
            // TajweedColorOption(
            //   theme: theme,
            //   onTap: () => context.navigatorPush(const TajweedRulesPage()),
            // ),

            // gapH5,
            SwitchSettingItem(
              title: context.l10n.keepScreenOn,
              theme: theme,
              onChanged: (bool toggled) =>
                  settingPresenter.toggleScreenOn(screenOn: toggled),
              value:
                  settingPresenter.uiState.value.settingsState?.keepScreenOn ??
                      false,
            ),

            gapH10,
            // const SettingsLargeOption(),

            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.interfaceTheme,
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: isMobile ? FontWeight.w600 : FontWeight.w700,
                    ),
                  ),
                  isMobile ? gapH15 : gapH5,
                  ThemeListWidget(
                    settingPresenter: settingPresenter,
                    theme: theme,
                  ),
                  isMobile ? gapH25 : gapH10,
                ],
              ),
            ),
          ]))
    ]));
  }
}

class TajweedColorOption extends StatelessWidget {
  const TajweedColorOption({
    super.key,
    required this.theme,
    required this.onTap,
  });

  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: theme,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding10,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacity(0.1),
          borderRadius: radius10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tajweed Color',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            Transform.rotate(
              angle: 3.14,
              child: SvgPicture.asset(
                SvgPath.icBack,
                width: twentySixPx,
                colorFilter: buildColorFilterToChangeColor(
                  context.color.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
