import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';

// By separating the mapper functions (toMap, fromMap, toEntity, fromEntity) from the entity class
// and placing them into separate files in the data layer, we gain more flexibility and scalability.
// For example, we can easily run these functions in an isolate to improve performance, or separate DTO
// object types from domain layer entities. This also makes it easier to swap out data sources in the future
// as the functions can be reused with minimal changes. Additionally, this promotes a separation of concerns
// and ensures that the entity class in the domain layer remains clean and focused on business logic.

extension SettingsEntityToSerialisedString on SettingsStateEntity {
  Future<String> toSerialisedString() async => compute(_convertSettingsEntityToSerialisedString, this);
}

extension SerialisedStringToSettingStateEntity on String {
  Future<SettingsStateEntity> toSettingStateEntity() async =>
      compute(_convertSerialisedStringToSettingStateEntity, this);
}

String _convertSettingsEntityToSerialisedString(
  SettingsStateEntity settingsState,
) {
  final Map<String, Object> map = _convertSettingsEntityToMap(settingsState: settingsState);
  final String serialisedString = jsonEncode(map);
  return serialisedString;
}

SettingsStateEntity _convertSerialisedStringToSettingStateEntity(
  String serialisedString,
) {
  final Map<String, dynamic> map = jsonDecode(serialisedString) as Map<String, dynamic>;
  final SettingsStateEntity settingsState = _convertMapToSettingStateEntity(map: map);
  return settingsState;
}

Map<String, Object> _convertSettingsEntityToMap({
  required SettingsStateEntity settingsState,
}) {
  return {
    'showArabic': settingsState.showArabic,
    'showTranslation': settingsState.showTranslation,
    'arabicFontSize': settingsState.arabicFontSize,
    'localFontSize': settingsState.localFontSize,
    'arabicFontScript': settingsState.arabicFontScript.name,
    'arabicFont': settingsState.arabicFont.name,
    'themeState': settingsState.themeState.name,
    'keepScreenOn': settingsState.keepScreenOn,
    'showWordByWord': settingsState.showWordByWord,
    'tafseerFontSize': settingsState.tafseerFontSize,
  };
}

SettingsStateEntity _convertMapToSettingStateEntity({
  required Map<String, Object?> map,
}) {
  final String arabicFontScriptString = map['arabicFontScript'] as String? ?? "";
  final ArabicFontScript arabicFontScript = ArabicFontScript.values.firstWhere((a) => a.name == arabicFontScriptString);
  final String arabicFontString = map['arabicFont'] as String? ?? "";
  final ArabicFonts arabicFont = ArabicFonts.values.firstWhere((a) => a.name == arabicFontString);

  final String themeStateString = map['themeState'] as String? ?? "";
  final ThemeState themeState = ThemeState.values.firstWhere((theme) => theme.name == themeStateString);

  return SettingsStateEntity(
    showArabic: map['showArabic'] as bool? ?? true,
    showTranslation: map['showTranslation'] as bool? ?? true,
    arabicFontSize: map['arabicFontSize'] as double? ?? 20.0,
    localFontSize: map['localFontSize'] as double? ?? 14.0,
    arabicFontScript: arabicFontScript,
    arabicFont: arabicFont,
    themeState: themeState,
    keepScreenOn: map['keepScreenOn'] as bool? ?? true,
    showWordByWord: map['showWordByWord'] as bool? ?? false,
    tafseerFontSize: map['tafseerFontSize'] as double? ?? 20.0,
    showDailyNotification: map['showDailyNotification'] as bool? ?? true,
    dailyNotificationTime: map['dailyNotificationTime'] as TimeOfDay? ?? const TimeOfDay(hour: 9, minute: 0),
  );
}
