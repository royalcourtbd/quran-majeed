import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/appearance_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/content_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/font_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/general_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/notification_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_switch.dart';

class SettingsMobileView extends StatelessWidget {
  const SettingsMobileView({
    super.key,
    required this.settingPresenter,
    required this.theme,
  });

  final SettingsPresenter settingPresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('settings_mobile_view'),
      child: Column(
        children: [
          GeneralSettingsCard(
            key: const Key('general_settings_card'),
            isFromSettingsPage: true,
            settingPresenter: settingPresenter,
          ),
          BuildDivider(
            theme: theme,
          ),
          ContentSettingsCard(
            key: const Key('content_settings_card'),
            isFromSettingsPage: true,
            settingPresenter: settingPresenter,
          ),
          BuildDivider(theme: theme),
          WordByWordSwitch(
            key: const Key('word_by_word_switch'),
            settingPresenter: settingPresenter,
            theme: theme,
          ),
          BuildDivider(theme: theme),
          FontSettingsCard(
            key: const Key('font_settings_card'),
            settingPresenter: settingPresenter,
            isFromSettingsPage: true,
            showTafseerFontSlider: true,
          ),
          BuildDivider(
            theme: theme,
          ),
          AppearanceSettingsCard(
            key: const Key('appearance_settings_card'),
            settingPresenter: settingPresenter,
            isFromSettingsPage: true,
          ),
          BuildDivider(
            theme: theme,
          ),
          NotificationSettingsCard(
            key: const Key('notification_settings_card'),
            isFromSettingsPage: true,
            presenter: settingPresenter,
          ),
          gapH50
        ],
      ),
    );
  }
}
