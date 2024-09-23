import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/custom_theme_widget.dart';

class ThemeListWidget extends StatelessWidget {
  const ThemeListWidget({
    super.key,
    required this.settingPresenter,
    required this.theme,
  });

  final SettingsPresenter settingPresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: settingPresenter,
      builder: () {
        ThemeState themeState =
            settingPresenter.uiState.value.settingsState?.themeState ??
                ThemeState.system;
        return SizedBox(
          height: isMobile ? 30.percentWidth : 20.percentWidth,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomThemeWidget(
                      selectedColor: context.color.primaryColor,
                      isSelected: themeState == ThemeState.system,
                      title: context.l10n.system,
                      onTap: () => showComingSoonMessage(context: context),
                      // settingPresenter.toggleSystemMode(
                      //     themeState: ThemeState.system),
                    ),
                    CustomThemeWidget(
                      selectedColor: theme.primaryColor,
                      isSelected: themeState == ThemeState.light,
                      title: context.l10n.light,
                      onTap: () => showComingSoonMessage(context: context),
                      // settingPresenter.toggleNightMode(nightMode: false),
                    ),
                    CustomThemeWidget(
                      selectedColor: context.color.primaryColor,
                      isSelected: themeState == ThemeState.dark,
                      title: context.l10n.dark,
                      onTap: () => showComingSoonMessage(context: context),
                      // settingPresenter.toggleNightMode(nightMode: true),
                    ),
                    CustomThemeWidget(
                      selectedColor: context.color.primaryColor,
                      isSelected: themeState == ThemeState.light,
                      title: context.l10n.green,
                      onTap: () => showComingSoonMessage(context: context),
                      // settingPresenter.toggleNightMode(nightMode: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
