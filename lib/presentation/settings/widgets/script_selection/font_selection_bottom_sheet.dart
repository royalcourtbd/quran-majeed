import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_ui_state.dart';
import 'package:quran_majeed/presentation/settings/widgets/font_view.dart';
import 'package:quran_majeed/presentation/settings/widgets/script_selection/font_option_list_item.dart';
import 'package:quran_majeed/presentation/settings/widgets/script_selection/font_selection_tab_bar.dart';

class FontSelectionBottomSheet extends StatefulWidget {
  final SettingsPresenter settingPresenter;

  const FontSelectionBottomSheet({super.key, required this.settingPresenter});

  @override
  State<FontSelectionBottomSheet> createState() =>
      _FontSelectionBottomSheetState();
}

class _FontSelectionBottomSheetState extends State<FontSelectionBottomSheet> {
  int _selectedTabIndex = 0;
  late ArabicFonts _selectedFont;
  late final SettingsUiState uiState = widget.settingPresenter.uiState.value;

  late final List<Map<String, dynamic>> _tabs;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex =
        uiState.settingsState!.arabicFontScript == ArabicFontScript.uthmani
            ? 0
            : 1;
    _selectedFont = uiState.settingsState!.arabicFont;
    _initTabs();
  }

  void _initTabs() {
    final uthmaniMadaniFonts = [
      ArabicFonts.kfgq,
      ArabicFonts.meQuran,
      ArabicFonts.amiriQuran,
      ArabicFonts.hafsSmart,
      ArabicFonts.uthmanicHafs1,
      ArabicFonts.uthmanTN1,
      ArabicFonts.uthmanTN1B,
      ArabicFonts.alQalamQuranMajeed,
      ArabicFonts.lateef,
      ArabicFonts.pdmsSaleem,
      ArabicFonts.pdmsIslamic,
    ];

    final indoPakAsianFonts = [
      ArabicFonts.nooreHuda,
      ArabicFonts.nooreHira,
      ArabicFonts.nooreHidayat,
    ];

    _tabs = [
      {
        'title': ArabicFontScript.uthmani,
        'fonts': uthmaniMadaniFonts,
      },
      {
        'title': ArabicFontScript.indoPak,
        'fonts': indoPakAsianFonts,
      },
    ];
  }

  Future<void> _handleFontSelection(ArabicFonts font) async {
    setState(() => _selectedFont = font);
    await widget.settingPresenter.changeFont(font: font);
  }

  Future<void> _handleTabSelection(int index) async {
    setState(() => _selectedTabIndex = index);
    await widget.settingPresenter.changeScript(
        script:
            index == 0 ? ArabicFontScript.uthmani : ArabicFontScript.indoPak);
    await _handleFontSelection(_tabs[index]['fonts'][0]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: true,
      child: Container(
        height: 60.percentHeight,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(twentyPx)),
        ),
        child: Column(
          children: [
            FontSelectionTabBar(
              tabs: _tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: _handleTabSelection,
              theme: theme,
              settingPresenter: widget.settingPresenter,
            ),
            FontView(
              settingPresenter: widget.settingPresenter,
              themeData: theme,
              showTranslationTextReview: false,
            ),
            gapH10,
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _tabs[_selectedTabIndex]['fonts'].length,
                itemBuilder: (context, index) {
                  final font = _tabs[_selectedTabIndex]['fonts'][index];
                  return FontOptionListItem(
                    font: arabicFontToNameMap[font] ?? '',
                    isSelected: _selectedFont == font,
                    onSelected: (_) async => await _handleFontSelection(font),
                    theme: theme,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
