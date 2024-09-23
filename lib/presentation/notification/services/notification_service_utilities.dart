import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/utility/exceptions.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';

class NotificationServiceUtilities {
  NotificationServiceUtilities._();

  static Future<void> delayManuallyAndRun(
    int addedDayCount, {
    required FutureOr<void> Function() run,
  }) async {
    await catchFutureOrVoid(() async {
      final Duration manualDelayDuration = _determineManualDelayDuration(addedDayCount);
      await Future<void>.delayed(manualDelayDuration, run);
    });
  }

  static Duration _determineManualDelayDuration(int addedDayCount) =>
      addedDayCount == 0 ? 3.inSeconds : Duration(seconds: Random().nextInt(3) + addedDayCount);

  static int get notificationScheduleDayCount => Random(DateTime.now().millisecondsSinceEpoch).nextInt(65) + 31;

  static NotificationContent buildNotificationContent({
    required int notificationId,
    required String channelKey,
    required Map<String, String?> payload,
  }) {
    final String notificationTitle = payload["title"] ?? "";
    final String notificationBody = payload["body"] ?? "";
    final bool invalidNotification = notificationTitle.isEmpty || notificationBody.isEmpty;
    if (invalidNotification) throw InvalidNotificationException();

    return NotificationContent(
      id: notificationId,
      channelKey: channelKey,
      title: notificationTitle,
      body: notificationBody,
      category: NotificationCategory.Recommendation,
      backgroundColor: QuranColor.primaryColorLight,
      notificationLayout: NotificationLayout.BigText,
      payload: payload,
      
    );
  }

  static Future<TimeOfDay> convertTimeIntoTimeAtMorning(TimeOfDay time) async {
    final TimeOfDay? morningTime = await catchAndReturnFuture(() async {
      return TimeOfDay(
        hour: time.hour >= 12 ? time.hour - 12 : time.hour,
        minute: time.minute,
      );
    });
    return morningTime ?? const TimeOfDay(hour: 9, minute: 0);
  }

  static Future<TimeOfDay> convertTimeIntoTimeAtEvening(TimeOfDay time) async {
    final TimeOfDay? eveningTime = await catchAndReturnFuture(() async {
      return TimeOfDay(
        hour: time.hour < 12 ? time.hour + 12 : time.hour,
        minute: time.minute,
      );
    });
    return eveningTime ?? const TimeOfDay(hour: 21, minute: 0);
  }
}
