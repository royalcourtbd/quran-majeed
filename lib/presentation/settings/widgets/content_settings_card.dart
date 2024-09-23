import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/switch_setting_item.dart';

class ContentSettingsCard extends StatelessWidget {
  const ContentSettingsCard({
    super.key,
    this.isFromSettingsPage = false,
    required this.settingPresenter,
  });
  final SettingsPresenter settingPresenter;
  final bool isFromSettingsPage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: settingPresenter,
      builder: () {
        return SettingsContainer(
          child: Column(
            children: [
              SettingsCardHeader(
                title: context.l10n.viewSettings,
                svgPath: SvgPath.icViews,
              ),
              gapH18,
              Padding(
                padding: EdgeInsets.only(
                    left: isFromSettingsPage ? thirtySevenPx : 0),
                child: Column(
                  children: [
                    SwitchSettingItem(
                      theme: theme,
                      title: context.l10n.showArabic,
                      value: settingPresenter
                              .uiState.value.settingsState?.showArabic ??
                          true,
                      onChanged: (value) =>
                          settingPresenter.toggleShowArabic(showArabic: value),
                    ),
                    gapH8,
                    SwitchSettingItem(
                      theme: theme,
                      title: context.l10n.showTranslation,
                      value: settingPresenter
                              .uiState.value.settingsState?.showTranslation ??
                          true,
                      onChanged: (value) => settingPresenter
                          .toggleShowTranslation(showTranslation: value),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
