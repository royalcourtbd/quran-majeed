import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';

class QuranCustomTextTheme extends ThemeExtension<QuranCustomTextTheme> {
  final TextStyle? lableExtraSmall;
  final TextStyle? surahName;
  final TextStyle? arabicAyah;

  const QuranCustomTextTheme({
    this.lableExtraSmall,
    this.surahName,
    this.arabicAyah,
  });

  @override
  ThemeExtension<QuranCustomTextTheme> copyWith({
    TextStyle? lableExtraSmall,
    TextStyle? surahName,
    TextStyle? arabicAyah,
  }) {
    return QuranCustomTextTheme(
      lableExtraSmall: lableExtraSmall ?? this.lableExtraSmall,
      surahName: surahName ?? this.surahName,
      arabicAyah: arabicAyah ?? this.arabicAyah,
    );
  }

  @override
  ThemeExtension<QuranCustomTextTheme> lerp(
    ThemeExtension<QuranCustomTextTheme>? other,
    double t,
  ) {
    if (other is! QuranCustomTextTheme) {
      return this;
    }
    return QuranCustomTextTheme(
      lableExtraSmall:
          TextStyle.lerp(lableExtraSmall, other.lableExtraSmall, t),
      surahName: TextStyle.lerp(surahName, other.surahName, t),
      arabicAyah: TextStyle.lerp(arabicAyah, other.arabicAyah, t),
    );
  }
}

class QuranTextTheme {
  static TextTheme baseTextTheme = TextTheme(
    displayLarge: const TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: 57,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: const TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: const TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: headlineLargeFontSize,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: headlineMediumFontSize,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: headingSmallFontSize,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: titleLargeFontSize,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: titleMediumFontSize,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: titleSmallFontSize,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: bodyLargeFontSize,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: bodyMediumFontSize,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: bodySmallFontSize,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: labelLargeFontSize,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: labelMediumFontSize,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: FontFamily.inter,
      fontSize: labelSmallFontSize,
      fontWeight: FontWeight.w500,
    ),
  );
}
