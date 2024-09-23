import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/font_family.dart';

class SettingsStateEntity extends Equatable {
  const SettingsStateEntity({
    required this.showArabic,
    required this.showTranslation,
    required this.arabicFontSize,
    required this.localFontSize,
    required this.arabicFontScript,
    required this.arabicFont,
    required this.themeState,
    required this.keepScreenOn,
    required this.showWordByWord,
    required this.tafseerFontSize,
    required this.showDailyNotification,
    required this.dailyNotificationTime,
  });

  factory SettingsStateEntity.empty() {
    return const SettingsStateEntity(
      showArabic: true,
      showTranslation: true,
      arabicFontSize: 28,
      localFontSize: 15,
      arabicFontScript: ArabicFontScript.uthmani,
      arabicFont: ArabicFonts.kfgq,
      themeState: ThemeState.system,
      keepScreenOn: false,
      showWordByWord: false,
      tafseerFontSize: 15,
      showDailyNotification: true,
       dailyNotificationTime: TimeOfDay(hour: 9, minute: 0),
    );
  }

  final bool showArabic;
  final bool showTranslation;
  final double arabicFontSize;
  final double localFontSize;
  final ArabicFontScript arabicFontScript;
  final ArabicFonts arabicFont;
  final ThemeState themeState;
  final bool keepScreenOn;
  final bool showWordByWord;
  final double tafseerFontSize;
  final bool showDailyNotification;
  final TimeOfDay dailyNotificationTime;

  @override
  List<Object?> get props => [
        showArabic,
        showTranslation,
        arabicFontSize,
        localFontSize,
        arabicFontScript,
        arabicFont,
        themeState,
        keepScreenOn,
        showWordByWord,
        tafseerFontSize,
        showDailyNotification,
        dailyNotificationTime,
      ];

  SettingsStateEntity copyWith({
    bool? showArabic,
    bool? showTranslation,
    double? arabicFontSize,
    double? localFontSize,
    ArabicFontScript? arabicFontScript,
    ArabicFonts? arabicFont,
    ThemeState? themeState,
    bool? keepScreenOn,
    bool? showWordByWord,
    double? tafseerFontSize,
    bool? showDailyNotification,
    TimeOfDay? dailyNotificationTime,
  }) {
    return SettingsStateEntity(
      showArabic: showArabic ?? this.showArabic,
      showTranslation: showTranslation ?? this.showTranslation,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      localFontSize: localFontSize ?? this.localFontSize,
      arabicFontScript: arabicFontScript ?? this.arabicFontScript,
      arabicFont: arabicFont ?? this.arabicFont,
      themeState: themeState ?? this.themeState,
      keepScreenOn: keepScreenOn ?? this.keepScreenOn,
      showWordByWord: showWordByWord ?? this.showWordByWord,
      tafseerFontSize: tafseerFontSize ?? this.tafseerFontSize,
      showDailyNotification: showDailyNotification ?? this.showDailyNotification,
      dailyNotificationTime: dailyNotificationTime ?? this.dailyNotificationTime,
    );
  }
}

enum ArabicFontScript { uthmani, indoPak }

enum ArabicFonts {
  kfgq,
  meQuran,
  kitab,
  hafsSmart,
  uthmanicHafs1,
  uthmanTN1,
  uthmanTN1B,
  alQalamQuranMajeed,
  amiriQuran,
  lateef,
  nooreHidayat,
  nooreHira,
  nooreHuda,
  pdmsSaleem,
  pdmsIslamic,
}

Map<ArabicFonts, String> arabicFontToFontFamilyMap = {
  ArabicFonts.kfgq: FontFamily.kfgq,
  ArabicFonts.meQuran: FontFamily.meQuran,
  ArabicFonts.kitab: FontFamily.kitab,
  ArabicFonts.hafsSmart: FontFamily.hafsSmart,
  ArabicFonts.uthmanicHafs1: FontFamily.uthmanicHafs1,
  ArabicFonts.uthmanTN1: FontFamily.uthmanTN1,
  ArabicFonts.uthmanTN1B: FontFamily.uthmanTN1B,
  ArabicFonts.alQalamQuranMajeed: FontFamily.alQalamQuranMajeed,
  ArabicFonts.amiriQuran: FontFamily.amiriQuran,
  ArabicFonts.lateef: FontFamily.lateef,
  ArabicFonts.nooreHidayat: FontFamily.nooreHidayat,
  ArabicFonts.nooreHira: FontFamily.nooreHira,
  ArabicFonts.nooreHuda: FontFamily.nooreHuda,
  ArabicFonts.pdmsSaleem: FontFamily.pdmsSaleem,
  ArabicFonts.pdmsIslamic: FontFamily.pdmsIslamic,
};

Map<ArabicFonts, String> arabicFontToNameMap = {
  ArabicFonts.kfgq: "KFGQ",
  ArabicFonts.meQuran: "MeQuran",
  ArabicFonts.kitab: "Kitab",
  ArabicFonts.hafsSmart: "Hafs Smart",
  ArabicFonts.uthmanicHafs1: "Uthmanic Hafs 1",
  ArabicFonts.uthmanTN1: "Uthman TN 1",
  ArabicFonts.uthmanTN1B: "Uthman TN",
  ArabicFonts.alQalamQuranMajeed: "Al Qalam Quran Majeed",
  ArabicFonts.amiriQuran: "Amiri Quran",
  ArabicFonts.lateef: "Lateef",
  ArabicFonts.nooreHidayat: "Noore Hidayat",
  ArabicFonts.nooreHira: "Noore Hira",
  ArabicFonts.nooreHuda: "Noore Huda",
  ArabicFonts.pdmsSaleem: "PDMS Saleem",
  ArabicFonts.pdmsIslamic: "PDMS Islamic",
};

enum ThemeState { system, light, dark }
