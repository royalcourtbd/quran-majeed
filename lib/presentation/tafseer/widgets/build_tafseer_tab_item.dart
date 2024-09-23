import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/tafseer_tab.dart';

class BuildTafseerTabItem extends StatelessWidget {
  const BuildTafseerTabItem({
    super.key,
    required this.theme,
    required this.index,
    required this.activeTabIndex,
    required this.selectedItemsLength,
    required this.tafseerName,
    required this.language,
    required this.onClose,
  });

  final ThemeData theme;
  final String tafseerName;
  final String language;
  final int index;
  final int activeTabIndex;
  final int selectedItemsLength;
  final Function(int) onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 40.percentWidth,
      child: TafseerTab(
        key: Key('TafseerTab$index'),
        index: index,
        theme: theme,
        language:language,
        tafseerName: tafseerName,
        selectedItemsLength: selectedItemsLength,
        onClose: onClose,
        activeTabIndex: activeTabIndex,
      ),
    );
  }
}
