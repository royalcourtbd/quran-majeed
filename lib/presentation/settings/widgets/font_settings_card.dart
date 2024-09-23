import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/adaptive_selection_box.dart';
import 'package:quran_majeed/presentation/settings/widgets/custom_slider.dart';
import 'package:quran_majeed/presentation/settings/widgets/script_selection/font_selection_bottom_sheet.dart';
import 'package:quran_majeed/presentation/settings/widgets/font_view.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/tab_setting_header_widget.dart';

class FontSettingsCard extends StatelessWidget {
  const FontSettingsCard({
    super.key,
    required this.settingPresenter,
    this.showTextReview = true,
    this.isFromSettingsPage = false,
    this.showTafseerFontSlider = false,
  });

  final SettingsPresenter settingPresenter;
  final bool showTextReview;
  final bool isFromSettingsPage;
  final bool showTafseerFontSlider;

  void _showScriptBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FontSelectionBottomSheet(settingPresenter: settingPresenter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SettingsContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? SettingsCardHeader(
                  title: context.l10n.fontSettings,
                  svgPath: SvgPath.icShapes,
                )
              : TabSettingHeaderWidget(
                  title: context.l10n.fontSettings,
                ),
          PresentableWidgetBuilder(
              presenter: settingPresenter,
              builder: () {
                final SettingsStateEntity settingsState =
                    settingPresenter.uiState.value.settingsState!;
                return Padding(
                  padding: EdgeInsets.only(
                      left: isFromSettingsPage ? thirtySevenPx : 0),
                  child: Column(
                    children: [
                      if (showTextReview) ...[
                        gapH25,
                        FontView(
                          settingPresenter: settingPresenter,
                          themeData: themeData,
                        ),
                      ],
                      gapH25,
                      CustomSlider(
                        title: context.l10n.arabicFontSize,
                        min: 12,
                        max: 36,
                        defaultValue: settingsState.arabicFontSize,
                        onChanged: (value) {
                          settingPresenter.changeArabicFontSize(
                              fontSize: value.toDouble());
                        },
                      ),
                      gapH25,
                      CustomSlider(
                        title: context.l10n.translationFontSize,
                        min: 12,
                        max: 36,
                        defaultValue: (settingsState.localFontSize),
                        onChanged: (value) => settingPresenter
                            .changeLocalFontSize(fontSize: value.toDouble()),
                      ),
                      gapH25,
                      if (showTafseerFontSlider) ...[
                        CustomSlider(
                          title: context.l10n.tafseerFontSize,
                          min: 12,
                          max: 36,
                          defaultValue: settingsState.tafseerFontSize,
                          onChanged: (value) =>
                              settingPresenter.changeTafseerFontSize(
                                  fontSize: value.toDouble()),
                        ),
                        gapH25,
                      ],
                      AdaptiveSelectionBox(
                        title: context.l10n.scrip,
                        boxTitle: settingPresenter.getFontSectionTitle(
                            context, settingsState.arabicFontScript),
                        onTap: () => _showScriptBottomSheet(context),
                      ),
                      if (!isMobile) gapH10,
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
