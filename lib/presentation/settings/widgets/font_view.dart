import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';

class FontView extends StatelessWidget {
  const FontView({
    super.key,
    required this.settingPresenter,
    required this.themeData,
    this.showTranslationTextReview = true,
  });

  final ThemeData themeData;
  final SettingsPresenter settingPresenter;
  final bool showTranslationTextReview;

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: settingPresenter,
      builder: () {
        final uiState = settingPresenter.uiState.value;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: fifteenPx, vertical: tenPx),
          decoration: BoxDecoration(
            color: themeData.cardColor,
            borderRadius: radius6,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ',
                  textAlign:
                      !showTranslationTextReview ? TextAlign.center : null,
                  textDirection: TextDirection.rtl,
                  style: themeData.textTheme.bodyMedium!.copyWith(
                    fontSize: uiState.settingsState?.arabicFontSize,
                    fontFamily: uiState.settingsState?.arabicFont.name,
                    fontWeight: FontWeight.w400,
                    height: twoPx,
                  ),
                ),
              ),
              if (showTranslationTextReview) ...[
                gapH6,
                Text(
                  'All praise is for Allah—Lord of all worlds.',
                  style: themeData.textTheme.bodyMedium!.copyWith(
                    fontSize: uiState.settingsState?.localFontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
