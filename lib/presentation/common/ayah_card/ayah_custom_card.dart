import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/common/ayah_card/build_ayah_continer_top_row.dart';

class AyahCustomCard extends StatelessWidget {
  const AyahCustomCard({
    super.key,
    required this.showArabic,
    required this.showTranslate,
    this.index,
    required this.settingUiState,
    required this.surahTitle,
    required this.arabicAyah,
    required this.translation,
    required this.onTapMoreButton,
    required this.theme,
    this.icon,
  });
  final SettingsStateEntity settingUiState;
  final bool showArabic;
  final bool showTranslate;
  final int? index;
  final String surahTitle;
  final String arabicAyah;
  final String translation;
  final Function() onTapMoreButton;
  final Widget? icon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: twentyPx,
        right: twentyPx,
        top: tenPx,
        bottom: tenPx,
      ),
      decoration: BoxDecoration(
        color: index!.isEven
            ? theme.scaffoldBackgroundColor
            : theme.cardColor.withOpacity(0.5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildAyahContainerTopRow(
            onTapMoreButton: onTapMoreButton,
            rowTitle: surahTitle,
            icon: icon,
            theme: theme,
          ),
          gapH25,
          if (showArabic)
            SizedBox(
              width: double.infinity,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    arabicAyah,
                    textDirection: TextDirection.rtl,
                    style: context.quranText.arabicAyah!.copyWith(
                      fontSize: settingUiState.arabicFontSize,
                      fontFamily: settingUiState.arabicFont.name,
                    ),
                  )
                ],
              ),
            ),
          gapH25,
          if (showTranslate)
            Text(
              translation,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: settingUiState.localFontSize,
              ),
            ),
        ],
      ),
    );
  }
}
