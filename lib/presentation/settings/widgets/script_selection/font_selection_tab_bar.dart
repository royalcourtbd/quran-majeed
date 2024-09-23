import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';

import 'package:quran_majeed/presentation/settings/widgets/script_selection/font_selection_tab_bar_item.dart';

class FontSelectionTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final ThemeData theme;
  final SettingsPresenter settingPresenter;

  const FontSelectionTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.theme,
    required this.settingPresenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fiftySevenPx,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(twentyPx)),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => FontSelectionTabBarItem(
            title: settingPresenter.getLocalizedScriptTitle(
                context, tabs[index]['title'] as ArabicFontScript),
            isSelected: selectedIndex == index,
            onTap: () => onTabSelected(index),
            isLeftTab: index == 0,
            isRightTab: index == tabs.length - 1,
            theme: theme,
          ),
        ),
      ),
    );
  }
}
