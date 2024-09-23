import 'package:flutter/material.dart';

class QuranCustomThemeColors extends ThemeExtension<QuranCustomThemeColors> {
  final Color primaryColor;
  final Color secondary;
  final Color cardShade;
  final Color topShapeBg;
  final Color navInactive;
  final Color topIconHome;
  final Color backgroundColor;
  final Color whiteColor;
  final Color navBgAc;
  final Color blackColor;
  final Color subtitleColor;
  final Color homeDashboardBgColor;
  final Color gdTop; // New property
  final Color gdMiddle; // New property
  final Color gdBottom; // New property

  const QuranCustomThemeColors({
    required this.primaryColor,
    required this.secondary,
    required this.cardShade,
    required this.topShapeBg,
    required this.navInactive,
    required this.topIconHome,
    required this.backgroundColor,
    required this.whiteColor,
    required this.navBgAc,
    required this.blackColor,
    required this.subtitleColor,
    required this.homeDashboardBgColor,
    required this.gdTop, // New property
    required this.gdMiddle, // New property
    required this.gdBottom, // New property
  });

  @override
  ThemeExtension<QuranCustomThemeColors> copyWith({
    Color? primaryColor,
    Color? secondary,
    Color? cardShade,
    Color? topShapeBg,
    Color? navInactive,
    Color? topIconHome,
    Color? backgroundColor,
    Color? whiteColor,
    Color? navBgAc,
    Color? blackColor,
    Color? subtitleColor,
    Color? homeDashboardBgColor,
    Color? gdTop, // New property
    Color? gdMiddle, // New property
    Color? gdBottom, // New property
  }) {
    return QuranCustomThemeColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondary: secondary ?? this.secondary,
      cardShade: cardShade ?? this.cardShade,
      topShapeBg: topShapeBg ?? this.topShapeBg,
      navInactive: navInactive ?? this.navInactive,
      topIconHome: topIconHome ?? this.topIconHome,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      whiteColor: whiteColor ?? this.whiteColor,
      navBgAc: navBgAc ?? this.navBgAc,
      blackColor: blackColor ?? this.blackColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      homeDashboardBgColor: homeDashboardBgColor ?? this.homeDashboardBgColor,
      gdTop: gdTop ?? this.gdTop, // New property
      gdMiddle: gdMiddle ?? this.gdMiddle, // New property
      gdBottom: gdBottom ?? this.gdBottom, // New property
    );
  }

  @override
  ThemeExtension<QuranCustomThemeColors> lerp(
      ThemeExtension<QuranCustomThemeColors>? other, double t) {
    if (other is! QuranCustomThemeColors) {
      return this;
    }
    return QuranCustomThemeColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      cardShade: Color.lerp(cardShade, other.cardShade, t)!,
      topShapeBg: Color.lerp(topShapeBg, other.topShapeBg, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      topIconHome: Color.lerp(topIconHome, other.topIconHome, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      navBgAc: Color.lerp(navBgAc, other.navBgAc, t)!,
      blackColor: Color.lerp(blackColor, other.blackColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      homeDashboardBgColor:
          Color.lerp(homeDashboardBgColor, other.homeDashboardBgColor, t)!,
      gdTop: Color.lerp(gdTop, other.gdTop, t)!, // New property
      gdMiddle: Color.lerp(gdMiddle, other.gdMiddle, t)!, // New property
      gdBottom: Color.lerp(gdBottom, other.gdBottom, t)!, // New property
    );
  }
}
