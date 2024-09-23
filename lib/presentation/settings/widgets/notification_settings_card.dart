import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/text_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_ui_state.dart';
import 'package:quran_majeed/presentation/settings/widgets/set_notification_time_setting.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/switch_setting_item.dart';
import 'package:quran_majeed/presentation/settings/widgets/tab_setting_header_widget.dart';

class NotificationSettingsCard extends StatelessWidget {
  const NotificationSettingsCard({
    super.key,
    this.isFromSettingsPage = false,
    required this.presenter,
  });
  final bool isFromSettingsPage;
  final SettingsPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: presenter,
        builder: () {
          final SettingsUiState uiState = presenter.uiState.value;
          final SettingsStateEntity? settingsState = uiState.settingsState;
          return settingsState == null
              ? LoadingIndicator(
                  key: const Key('loading_indicator'),
                  theme: theme,
                )
              : SettingsContainer(
                  child: Column(
                    children: [
                      isMobile
                          ? SettingsCardHeader(
                              key: const Key(
                                  'notification_settings_card_header'),
                              title: context.l10n.notificationSettings,
                              svgPath: SvgPath.icNotificationFill,
                            )
                          : TabSettingHeaderWidget(
                              key: const Key(
                                  'notification_settings_card_header'),
                              title: context.l10n.notificationSettings,
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: isFromSettingsPage ? thirtySevenPx : 0),
                        child: Column(
                          children: [
                            gapH10,
                            SwitchSettingItem(
                              key: const Key('daily_notification_toggle'),
                              title: context.l10n.dailyNotification,
                              theme: theme,
                              onChanged: (bool toggled) =>
                                  presenter.toggleShowNotification(
                                showNotification: toggled,
                              ),
                              value: settingsState.showDailyNotification,
                            ),
                            gapH10,
                            SetNotificationTimeSetting(
                                key: const Key('set_time'),
                                title: context.l10n.setTime,
                                subtitle:
                                    formatLocalTimeOfDayInEnglishForBothAmPm(
                                  settingsState.dailyNotificationTime,
                                ),
                                onTap: () => onNotificationMenuTapped(
                                      context: context,
                                      currentDefault:
                                          const TimeOfDay(hour: 9, minute: 0),
                                      presenter: presenter,
                                    )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
