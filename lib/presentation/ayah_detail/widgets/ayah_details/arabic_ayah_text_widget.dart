import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

class ArabicAyahTextWidget extends StatelessWidget {
  const ArabicAyahTextWidget({
    super.key,
    required this.ayahNumber,
    required this.wordData,
    required this.arabicFontScript,
    required this.arabicFontName,
    required this.arabicFontSize,
    required this.theme,
  });

  final int ayahNumber;
  final List<WordByWordEntity> wordData;
  final ArabicFontScript arabicFontScript;
  final String arabicFontName;
  final double arabicFontSize;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        key: Key("ayah_$ayahNumber"),
        spacing: 10,
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        textDirection: TextDirection.rtl,
        children: wordData.map(
          (word) {
            return Text(
              arabicFontScript == ArabicFontScript.uthmani
                  ? word.uthmani!
                  : word.indopak!,
              textDirection: TextDirection.rtl,
              style: context.quranText.arabicAyah!.copyWith(
                fontFamily: arabicFontName,
                fontSize: arabicFontSize,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
