import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/config/quran_custom_text_theme.dart';
import 'package:quran_majeed/core/config/quran_custom_theme_colors.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';

class QuranTheme {
  QuranTheme._();

  static final ThemeData _baseTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: FontFamily.kalpurush,
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5)),
    ),
    bannerTheme:
        const MaterialBannerThemeData(backgroundColor: Color(0xffDBDBDB)),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xffDEDEDE)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xff17B686)),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xff17B686)),
      ),
      hoverColor: QuranColor.primaryColorGreen,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 1,
      space: 0,
    ),
    radioTheme: const RadioThemeData(
      visualDensity: VisualDensity(horizontal: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    disabledColor: const Color(0xff7F909F),
    dividerColor: const Color(0xffDEDEDE),
    secondaryHeaderColor: const Color(0xff17B686),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      modalBackgroundColor: Color(0xFFF3F3F3),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  static ThemeData lightTheme = _baseTheme.copyWith(
    extensions: [
      QuranCustomThemeColors(
        primaryColor: QuranColor.primaryColorLight,
        secondary: QuranColor.secondaryColorLight,
        cardShade: QuranColor.cardColorLight,
        topShapeBg: QuranColor.topShapeBgLight,
        navInactive: QuranColor.navInactiveLight,
        topIconHome: QuranColor.primaryColorLight,
        backgroundColor: QuranColor.scaffoldBachgroundColorLight,
        whiteColor: Colors.white,
        navBgAc: QuranColor.navBgAcLight.withOpacity(0.25),
        blackColor: QuranColor.blackColorLight,
        subtitleColor: QuranColor.textColorLight.withOpacity(0.6),
        homeDashboardBgColor: QuranColor.scaffoldBachgroundColorLight,
        gdTop: QuranColor.gdTopLight,
        gdBottom: QuranColor.gdBottomLight,
        gdMiddle: QuranColor.gdMiddleLight,
      ),
      QuranCustomTextTheme(
        lableExtraSmall: TextStyle(
          fontSize: lableExtraSmallFontSize,
          color: QuranColor.textColorLight,
          fontFamily: FontFamily.inter,
        ),
        surahName: TextStyle(
          fontSize: surahNameFontSize,
          fontFamily: FontFamily.suraNames,
          fontWeight: FontWeight.w400,
          color: QuranColor.textColorLight,
        ),
        arabicAyah: TextStyle(
          fontFamily: FontFamily.meQuran,
          fontSize: arabicAyahFontSize,
          fontWeight: FontWeight.w400,
          height: 2,
          color: QuranColor.textColorLight,
        ),
      )
    ],
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return QuranColor.primaryColorLight;
        }
        return Colors.transparent;
      }),
      side: BorderSide(
        color: QuranColor.primaryColorLight.withOpacity(0.4),
        width: 2,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: QuranColor.scaffoldBachgroundColorLight,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: QuranColor.primaryColorLight,
      labelStyle: TextStyle(color: Color(0xff17B686)),
      fillColor: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      color: QuranColor.primaryColorLight.withOpacity(0.9),
    ),
    radioTheme: RadioThemeData(
      overlayColor: WidgetStateProperty.all(QuranColor.cardColorLight),
      fillColor: WidgetStateProperty.all(QuranColor.primaryColorLight),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: QuranColor.primaryColorLight,
      selectionColor: QuranColor.primaryColorLight.withOpacity(0.2),
      selectionHandleColor: QuranColor.primaryColorLight,
    ),
    primaryColorLight: Colors.black,
    buttonTheme: const ButtonThemeData(
      buttonColor: QuranColor.textColorLight,
    ),
    cardColor: QuranColor.cardColorLight,
    iconTheme: const IconThemeData(color: QuranColor.textColorLight),
    primaryColor: QuranColor.primaryColorLight,
    scaffoldBackgroundColor: QuranColor.scaffoldBachgroundColorLight,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(QuranColor.primaryColorLight),
    ),
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.white,
      backgroundColor: QuranColor.secondaryColorLight,
      foregroundColor: Color(0xff477848),
      iconTheme: IconThemeData(color: QuranColor.textColorLight),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textTheme: QuranTextTheme.baseTextTheme.apply(
      bodyColor: QuranColor.textColorLight,
      displayColor: QuranColor.textColorLight,
      fontFamily: FontFamily.inter,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: QuranColor.primaryColorLight,
      secondary: QuranColor.secondaryColorLight,
      surface: QuranColor.primaryColorLight,
      error: Color(0xFFED3535),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFE7DF),
      scrim: QuranColor.primaryColorLight,
      inverseSurface: QuranColor.scaffoldBachgroundColorLight,
    ),
  );

  static ThemeData greenTheme = _baseTheme.copyWith(
    extensions: [
      QuranCustomThemeColors(
        primaryColor: QuranColor.primaryColorGreen,
        secondary: QuranColor.secondaryColorGreen,
        cardShade: QuranColor.cardColorGreen,
        topShapeBg: QuranColor.topShapeBgGreen,
        navInactive: QuranColor.navInactiveGreen,
        topIconHome: QuranColor.primaryColorGreen,
        backgroundColor: QuranColor.scaffoldBachgroundColorGreen,
        whiteColor: Colors.white,
        navBgAc: QuranColor.navBgAcGreen.withOpacity(0.25),
        blackColor: QuranColor.blackColorGreen,
        subtitleColor: QuranColor.textColorGreen.withOpacity(0.6),
        homeDashboardBgColor: QuranColor.scaffoldBachgroundColorGreen,
        gdTop: QuranColor.gdTopGreen,
        gdBottom: QuranColor.gdBottomGreen,
        gdMiddle: QuranColor.gdMiddleGreen,
      ),
      QuranCustomTextTheme(
        lableExtraSmall: TextStyle(
          fontSize: lableExtraSmallFontSize,
          color: QuranColor.textColorGreen,
          fontFamily: FontFamily.inter,
        ),
        surahName: TextStyle(
          fontSize: surahNameFontSize,
          fontFamily: FontFamily.suraNames,
          fontWeight: FontWeight.w400,
          color: QuranColor.textColorGreen,
        ),
        arabicAyah: TextStyle(
          fontFamily: FontFamily.meQuran,
          fontSize: arabicAyahFontSize,
          fontWeight: FontWeight.w400,
          height: 2,
          color: QuranColor.textColorGreen,
        ),
      )
    ],
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return QuranColor.primaryColorGreen;
        }
        return Colors.transparent;
      }),
      side: BorderSide(
        color: QuranColor.primaryColorGreen.withOpacity(0.4),
        width: 2,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: QuranColor.scaffoldBachgroundColorGreen,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: QuranColor.primaryColorGreen,
      labelStyle: TextStyle(color: Color(0xff17B686)),
      fillColor: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      color: QuranColor.primaryColorGreen.withOpacity(0.9),
    ),
    radioTheme: RadioThemeData(
      overlayColor: WidgetStateProperty.all(QuranColor.cardColorGreen),
      fillColor: WidgetStateProperty.all(QuranColor.primaryColorGreen),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: QuranColor.primaryColorGreen,
      selectionColor: QuranColor.primaryColorGreen.withOpacity(0.2),
      selectionHandleColor: QuranColor.primaryColorGreen,
    ),
    primaryColorLight: Colors.black,
    buttonTheme: const ButtonThemeData(
      buttonColor: QuranColor.textColorGreen,
    ),
    cardColor: QuranColor.cardColorGreen,
    iconTheme: const IconThemeData(color: QuranColor.textColorGreen),
    primaryColor: QuranColor.primaryColorGreen,
    scaffoldBackgroundColor: QuranColor.scaffoldBachgroundColorGreen,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(QuranColor.primaryColorGreen),
    ),
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.white,
      backgroundColor: QuranColor.secondaryColorGreen,
      foregroundColor: Color(0xff477848),
      iconTheme: IconThemeData(color: QuranColor.textColorGreen),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textTheme: QuranTextTheme.baseTextTheme.apply(
      bodyColor: QuranColor.textColorGreen,
      displayColor: QuranColor.textColorGreen,
      fontFamily: FontFamily.inter,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: QuranColor.primaryColorGreen,
      secondary: QuranColor.secondaryColorGreen,
      surface: QuranColor.primaryColorGreen,
      error: Color(0xFFED3535),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFE7DF),
      scrim: QuranColor.primaryColorGreen,
      inverseSurface: QuranColor.scaffoldBachgroundColorGreen,
    ),
  );

  static ThemeData darkTheme = _baseTheme.copyWith(
    brightness: Brightness.dark,
    extensions: [
      QuranCustomThemeColors(
        primaryColor: QuranColor.primaryColorDark,
        secondary: QuranColor.secondaryColorDark,
        cardShade: QuranColor.cardColorDark,
        topShapeBg: QuranColor.topShapeBgDark,
        navInactive: QuranColor.navInactiveDark,
        topIconHome: QuranColor.topIconHomeDark,
        backgroundColor: QuranColor.scaffoldBachgroundColorDark,
        whiteColor: Colors.white,
        navBgAc: QuranColor.navBgAcDark.withOpacity(0.25),
        blackColor: QuranColor.blackColorDark,
        subtitleColor: QuranColor.textColorDark.withOpacity(0.6),
        homeDashboardBgColor: QuranColor.cardColorDark,
        gdTop: QuranColor.gdTopDark,
        gdBottom: QuranColor.gdBottomDark,
        gdMiddle: QuranColor.gdMiddleDark,
      ),
      QuranCustomTextTheme(
        lableExtraSmall: TextStyle(
          fontSize: lableExtraSmallFontSize,
          color: QuranColor.textColorDark,
          fontFamily: FontFamily.inter,
        ),
        surahName: TextStyle(
          fontSize: surahNameFontSize,
          fontFamily: FontFamily.suraNames,
          fontWeight: FontWeight.w400,
          color: QuranColor.textColorDark,
        ),
        arabicAyah: TextStyle(
          fontFamily: FontFamily.meQuran,
          fontSize: arabicAyahFontSize,
          fontWeight: FontWeight.w400,
          height: 2,
          color: QuranColor.textColorDark,
        ),
      )
    ],
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return QuranColor.primaryColorDark;
        }
        return Colors.transparent;
      }),
      side: const BorderSide(
        color: QuranColor.primaryColorDark,
        width: 2,
      ),
    ),
    bannerTheme:
        const MaterialBannerThemeData(backgroundColor: Color(0xff7F909F)),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xff122337),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(QuranColor.textColorDark),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Color(0xff7F909F)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF585868)),
      ),
      focusColor: QuranColor.textColorDark,
      labelStyle: TextStyle(color: Color(0xff17B686)),
      fillColor: Color(0xff223449),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: QuranColor.textColorDark,
      selectionColor: QuranColor.textColorDark.withOpacity(0.5),
      selectionHandleColor: QuranColor.textColorDark,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.amber),
    cardColor: QuranColor.cardColorDark,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xff122337),
      modalBackgroundColor: Color(0xff223449),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(QuranColor.textColorDark),
    ),
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.black,
      backgroundColor: QuranColor.secondaryColorDark,
      foregroundColor: Color(0xff477848),
      iconTheme: IconThemeData(color: QuranColor.textColorDark),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    primaryColor: QuranColor.primaryColorDark,
    scaffoldBackgroundColor: QuranColor.scaffoldBachgroundColorDark,
    primaryColorDark: const Color(0xff122337),
    dividerColor: const Color(0xFF585868),
    iconTheme: const IconThemeData(color: Color(0xff7F909F)),
    textTheme: QuranTextTheme.baseTextTheme.apply(
      bodyColor: QuranColor.textColorDark,
      displayColor: QuranColor.textColorDark,
      fontFamily: FontFamily.inter,
    ),
    colorScheme: const ColorScheme.dark(
      primary: QuranColor.textColorDark,
      secondary: QuranColor.secondaryColorDark,
      surface: QuranColor.textColorDark,
      error: Color(0xFFED3535),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
      errorContainer: Color(0xFF202939),
      scrim: QuranColor.textColorDark,
      inverseSurface: QuranColor.scaffoldBachgroundColorDark,
    ),
  );
}

Future<SystemUiOverlayStyle?> getSystemUiOverlayStyle({
  bool? isDark,
  BuildContext? context,
}) async {
  final SystemUiOverlayStyle? uiOverlayStyle = await catchAndReturnFuture(
    () async {
      final ThemeData theme = Theme.of(context ?? QuranMajeed.globalContext);
      final Color statusBarColor = isDark == null
          ? theme.primaryColor
          : (isDark ? const Color(0x00ffffff) : const Color(0xffffffff));
      final Color systemNavigationBarColor = isDark == null
          ? theme.cardColor
          : (isDark ? const Color(0xff161C23) : const Color(0xffffffff));
      return SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    },
  );
  return uiOverlayStyle;
}
