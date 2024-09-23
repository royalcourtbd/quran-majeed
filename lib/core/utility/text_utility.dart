import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quran_majeed/core/external_libs/lru_map/lru_map.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';

final Map<Object, String> _translateNumberToBanglaStringCache = LruMap(maximumSize: 100);
const Map<String, String> _englishToBanglaMap = {
  '0': '০',
  '1': '১',
  '2': '২',
  '3': '৩',
  '4': '৪',
  '5': '৫',
  '6': '৬',
  '7': '৭',
  '8': '৮',
  '9': '৯',
};

String translateNumberToBanglaString(Object number) {
  final String? translatedNumber = catchAndReturn(() {
    if (_translateNumberToBanglaStringCache.containsKey(number)) {
      return _translateNumberToBanglaStringCache[number]!;
    }

    String numberAsString = number.toString();

    for (final String englishNumber in _englishToBanglaMap.keys) {
      numberAsString = numberAsString.replaceAll(
        englishNumber,
        _englishToBanglaMap[englishNumber]!,
      );
    }

    _translateNumberToBanglaStringCache[number] = numberAsString;
    return numberAsString;
  });
  return translatedNumber ?? "";
}

/// Returns a boolean indicating whether the given [text] contains only Bangla or English digits (0-9).
///
/// Example usage:
///
///
/// ```dart
/// bool hasOnlyDigits = hasOnlyBanglaOrEnglishNumber('১২৩'); // true
/// bool hasOnlyDigits2 = hasOnlyBanglaOrEnglishNumber('123'); // true
/// bool hasOnlyDigits3 = hasOnlyBanglaOrEnglishNumber('১২৩abc'); // false
/// ```
///
/// Returns false if an exception occurs during execution.
bool hasOnlyBanglaOrEnglishNumber(String text) {
  final bool? onlyBanglaOrEnglishNumber = catchAndReturn(() {
    final RegExp bengaliDigits = RegExp('[০-৯]+');
    final RegExp englishDigits = RegExp('[0-9]+');
    return !text.split('').any(
          (char) => !(bengaliDigits.hasMatch(char) || englishDigits.hasMatch(char)),
        );
  });
  return onlyBanglaOrEnglishNumber ?? false;
}

Theme fixedLightContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
  return Theme(
    data: ThemeData.light(),
    child: AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    ),
  );
}

/// Returns a boolean indicating whether the given [str] contains any Bengali
/// digits (০-৯).
///
/// Example usage:
///
///
/// ```dart
/// bool hasDigits = hasBanglaDigits('abc১২৩'); // true
/// bool hasDigits2 = hasBanglaDigits('কাজকাজ123'); // false
///
///```
bool hasBanglaDigits(String str) {
  final RegExp bengaliDigits = RegExp('[০-৯]');
  return bengaliDigits.hasMatch(str);
}

/// Returns a boolean indicating whether the given [str] contains any English
/// digits (0-9).
///
/// Example usage:
///
///
/// ```dart
/// bool hasDigits = hasEnglishDigits('abc123'); // true
/// bool hasDigits2 = hasEnglishDigits('কাজকাজ১২৩'); // true
/// bool hasDigits3 = hasEnglishDigits('কাজকাজ'); //false
///
/// ```
bool hasEnglishDigits(String str) {
  final RegExp englishDigits = RegExp('[0-9]');
  return englishDigits.hasMatch(str);
}

const Map<String, String> _bengaliToEnglishMap = {
  '০': '0',
  '১': '1',
  '২': '2',
  '৩': '3',
  '৪': '4',
  '৫': '5',
  '৬': '6',
  '৭': '7',
  '৮': '8',
  '৯': '9',
};

/// Translates Bengali digits in the given [str] to English digits using the
/// _bengaliToEnglishMap map.
///
/// Example usage:
///
///
/// ``` dart
/// String bengaliString = '২৩৪৫৬৭৮৯';
/// String englishString = translateBengaliToEnglish(bengaliString);
/// print(englishString);
/// Output: "23456789"
///
///```
String translateBengaliToEnglish(String str) {
  String translatedStr = str;
  for (final String bengaliDigit in _bengaliToEnglishMap.keys) {
    translatedStr = translatedStr.replaceAll(
      bengaliDigit,
      _bengaliToEnglishMap[bengaliDigit]!,
    );
  }
  return translatedStr;
}

/// Checks if the given [String] contains any Arabic characters.
///
/// Returns true if it contains Arabic characters, false otherwise.
///
/// Example usage:
///
///
/// ```dart
///  bool hasArabicCharacters = hasArabic("مرحبا بالعالم"); // true
/// ```
///
bool hasArabic(String str) {
  final RegExp arabic = RegExp('[\u0600-\u06FF]');
  return arabic.hasMatch(str);
}

/// Normalizes the given [String] by removing any Arabic diacritics.
/// (e.g. "ٌ" => "").
/// Returns the normalized [String].
/// Returns the original [String] if an exception occurs during execution.
/// Example usage:
/// ```dart
/// String arabicString = "مَرْحَبًا بِالْعَالَمِ";
/// String normalizedString = normalizeArabicString(arabicString);
/// print(normalizedString);
/// Output: "مرحبا بالعالم"
/// ```

// String normalizeArabicString(String str) {
//   final String? normalizedString = catchAndReturn(() {
//     final String normalizedText = str.replaceAll(RegExp(r'[\u064B-\u0652]'), '');
//     return normalizedText.replaceAll(RegExp(r'[\u0640]'), '');
//   });
//   return normalizedString ?? str;
// }

String normalizeArabicString(String str) {
  final String? normalizedString = catchAndReturn(() {
    // Remove Quranic diacritics
    String normalizedText = str.replaceAll(RegExp(r'[\u064B-\u0652\u0670]'), '');

    // Replace Alef Wasla with Alef
    normalizedText = normalizedText.replaceAll('ٱ', 'ا');

    // Remove Madda and small high Alef
    normalizedText = normalizedText.replaceAll(RegExp('[ٰٓ]'), '');

    // Remove Quranic annotations
    normalizedText = normalizedText.replaceAll(RegExp(r'[\u06D6-\u06ED]'), '');

    // Normalize Lam Alef
    normalizedText = normalizedText.replaceAll('لآ', 'لا');

    return normalizedText;
  });
  return normalizedString ?? str;
}

/// Highlights the given [text] by wrapping the words in the given
/// [highlightWords] list with the <highlighted> tag.
/// Returns the highlighted [String].
/// Returns the original [String] if an exception occurs during execution.
/// Example usage:
/// ```dart
/// String text = "مرحبا بالعالم";
/// List<String> highlightWords = ["مرحبا", "بالعالم"];
/// String highlightedText = arabicHighlight(text, highlightWords);
/// print(highlightedText);
/// Output: "<highlighted>مرحبا</highlighted> <highlighted>بالعالم</highlighted>"
/// ```
/// ```dart

String arabicHighlight(String text, List<String> highlightWords) {
  final List<String> words = text.split(" ");
  final List<String> resultText = [];

  for (final String word in words) {
    bool found = false;
    final String strippedWord = normalizeArabicString(word);

    for (final String highlightWord in highlightWords) {
      final String strippedhighlightWord = normalizeArabicString(highlightWord);

      if (strippedWord == strippedhighlightWord) {
        found = true;
        break;
      }
    }
    if (found) {
      resultText.add("<highlighted>$word</highlighted>");
    } else {
      resultText.add(" $word");
    }
  }

  return resultText.join(" ");
}

/// Formats a given [DateTime] object into a string with the format
/// "dd MMMM yyyy, hh:mm a".
///
/// Returns an empty string if an exception occurs during formatting.
///
/// Example Output:
///
/// formatDateTime(DateTime(2023, 4, 8, 16, 30)) => "08 April 2023, 04:30 PM"
///
String formatDateTime(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    logErrorStatic(e, _fileName);
    return "";
  }
}

/// Formats a given [TimeOfDay] object into a Bangla time string in a specific
/// format.
///
/// Example output: "বিকেল ৪:৩০"
///
/// The Bangla time string is formatted as "বিকেল/সকাল <Hour>:<Minute>",
/// where the hour and minute are translated to Bangla numerals and padded with
/// leading "০" if necessary.
///
/// Returns the formatted Bangla time string or the default toString() value of
/// [time] if the conversion fails.
String formatLocalTimeOfDayInBangla(TimeOfDay time) {
  final String? localTimeInBangla = catchAndReturn(() {
    final int hour = time.hourOfPeriod;
    final int minute = time.minute;
    final String formattedHour = translateNumberToBanglaString(hour).padLeft(2, '০');
    final String formattedMinute = translateNumberToBanglaString(minute).padLeft(2, '০');

    final String amPm = time.period == DayPeriod.pm ? 'বিকেল' : 'সকাল';
    return '$amPm $formattedHour:$formattedMinute';
  });
  return localTimeInBangla ?? time.toString();
}

String formatLocalTimeOfDayInEnglishForBothAmPm(TimeOfDay time) {
  final String? localTimeInEnglish = catchAndReturn(() {
    final int hour = time.hourOfPeriod;
    final int minute = time.minute;
    final String formattedHour = hour.toString().padLeft(2, '0');
    final String formattedMinute = minute.toString().padLeft(2, '0');

    final String amPm = time.period == DayPeriod.pm ? 'PM' : 'AM';
    return '$formattedHour:$formattedMinute $amPm';
  });
  return localTimeInEnglish ?? time.toString();
}

/// Parses a Bangla time string into a [TimeOfDay] object. The expected format of
/// the input string is "<am/pm> <hour>:<minute>". ("বিকেল ৪:৩০")
///
/// The hour and minute values in the input string are expected to be in Bangla
/// numerals, which will be automatically converted to English numerals.
///
/// If the input string cannot be parsed, the current time of day will be returned.
TimeOfDay parseLocalTimeOfDayInBangla(String timeString) {
  final parsedTime = catchAndReturn(() {
    final List<String> timeParts = timeString.split(' ');
    final String amPm = timeParts[0];
    final String time = timeParts[1];

    final String hour = translateBanglaNumberToEnglishString(
      time.substring(0, time.indexOf(':')),
    );
    final String minute = translateBanglaNumberToEnglishString(
      time.substring(time.indexOf(':') + 1),
    );
    final int hourInt = int.parse(hour);
    final int minuteInt = int.parse(minute);

    final int hourOfDay = hourInt + (amPm == 'বিকেল' ? 12 : 0);
    return TimeOfDay(hour: hourOfDay, minute: minuteInt);
  });

  return parsedTime ?? TimeOfDay.now();
}

TimeOfDay parseLocalTimeOfDayInBanglaWithoutAmPm(String timeString) {
  final parsedTime = catchAndReturn(() {
    final List<String> timeParts = timeString.split(' ');
    final String time = timeParts[1];

    final String hour = translateBanglaNumberToEnglishString(
      time.substring(0, time.indexOf(':')),
    );
    final String minute = translateBanglaNumberToEnglishString(
      time.substring(time.indexOf(':') + 1),
    );
    final int hourInt = int.tryParse(hour) ?? 9;
    final int minuteInt = int.tryParse(minute) ?? 0;

    final int hourOfDay = hourInt;
    return TimeOfDay(hour: hourOfDay, minute: minuteInt);
  });

  return parsedTime ?? const TimeOfDay(hour: 9, minute: 0);
}

DateTime convertTimeOfDayToExpectedDateTime(
  TimeOfDay timeOfDay,
  int addedDayCount,
) {
  final DateTime? dateTime = catchAndReturn(() {
    final int addableDay = (addedDayCount <= 30 ? addedDayCount : (addedDayCount - 30)) - 1;
    final int addableMonth = (addedDayCount / 30).ceil() - 1;

    final DateTime now = DateTime.now();

    return now.copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: 50,
      day: now.day + addableDay,
      month: now.month + addableMonth,
    );
  });

  return dateTime ?? DateTime.now();
}

/// Translates a given Bangla number string to its equivalent English string
/// representation.
///
/// Uses a Map to lookup the Bangla characters and replace them with their
/// corresponding English counterparts.
///
/// Takes a numberString parameter as input and returns the translated string.
///
/// Returns the original numberString if there are any issues with the translation
/// process.
String translateBanglaNumberToEnglishString(String numberString) {
  final String? translatedNumber = catchAndReturn(() {
    const Map<String, String> banglaToEnglishNumber = {
      '০': '0',
      '১': '1',
      '২': '2',
      '৩': '3',
      '৪': '4',
      '৫': '5',
      '৬': '6',
      '৭': '7',
      '৮': '8',
      '৯': '9',
    };

    final StringBuffer englishNumberStringBuffer = StringBuffer();
    for (final String banglaNumber in numberString.split('')) {
      englishNumberStringBuffer.write(banglaToEnglishNumber[banglaNumber]);
    }

    return englishNumberStringBuffer.toString();
  });

  return translatedNumber ?? numberString;
}

/// Takes a [String] parameter containing Arabic text and applies HTML tags to
/// highlight the Arabic words in the text.
///
/// Splits the text into Arabic words and applies a span tag to highlight the word.
/// The span tag is then wrapped in an HTML body and returned as a [String].
/// If the input [String] does not contain any Arabic text, it is returned
/// unmodified.
///
/// If a matched Arabic word is longer than 30 characters, the function inserts
/// a line break before and after the span tag to improve readability.
/// The maximum length can be adjusted by changing the maxLengthForLongerTag
/// constant.
///
/// Used to highlight Arabic search results in the app.
String highlightArabicTextWithSpanAndLineBreaks(String? arabicText) {
  if (arabicText == null) return "";

  const int maxLengthForLongerTag = 30;

  final String? highlightedText = catchAndReturn(() {
    final bool hasArabicText = RegExp(r'[\u0600-\u06FF]+').hasMatch(arabicText);
    if (!hasArabicText) return arabicText;

    final String highlightedText = arabicText.splitMapJoin(
      RegExp(r"[(|\u0600-\u06EF ]+[\u0600-\u06EF|)]+"),
      onMatch: (arabicWord) {
        final String? matchedArabicWord = arabicWord.group(0);
        if (matchedArabicWord == null) return "";
        return (matchedArabicWord.length > maxLengthForLongerTag)
            ? ' <span>$matchedArabicWord</span> '
            : ' <span>$matchedArabicWord</span> ';
      },
    );
    return "<html><body>$highlightedText</body></html>";
  });

  return highlightedText ?? arabicText;
}

String removeHtml(String textWithHtml) => Bidi.stripHtmlIfNeeded(textWithHtml.trim()).replaceAll("</highlig", "");

const String arabicTag = "span";
const String multiLineArabicTag = "span";
const String _fileName = "text_utility.dart";
