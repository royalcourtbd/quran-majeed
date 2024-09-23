import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_mobile_view.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_tab_view.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  late final SettingsPresenter _settingPresenter = locate();
  late final MainPagePresenter _drawerPresenter = locate();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        key: const Key('settings_app_bar'),
        theme: theme,
        title: context.l10n.settings,
        isRoot:
            _drawerPresenter.currentUiState.currentIndex == 4 ? true : false,
      ),
      body: Column(
        key: const Key('settings_page'),
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              key: const Key('settings_body'),
              isColored: true,
              child: isMobile
                  ? SettingsMobileView(
                      key: const Key('settings_mobile_view'),
                      settingPresenter: _settingPresenter,
                      theme: theme,
                    )
                  : SettingsTabView(
                      key: const Key('settings_tab_view'),
                      theme: theme,
                      settingPresenter: _settingPresenter,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
