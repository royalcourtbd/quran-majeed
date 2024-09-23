import 'package:flutter/material.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';

abstract class NotificationService {
  Future<void> scheduleNotification({
    required bool turnOn,
    required TimeOfDay time,
  });

  Future<void> scheduleNotificationAutomatically();

  Future<void> setUp();

  Future<void> showNotification({
    DateTime? sentTime,
    required NotificationPayLoadEntity payLoad,
  });

  Future<bool> isNotificationAllowed();

  Future<void> onOpenedFromNotification();

  Future<void> askNotificationPermission({
    required VoidCallback onGrantedOrSkippedForNow,
    required VoidCallback onDenied,
  });

  Future<void> onNotificationClickedForPushNotification({
    required NotificationPayLoadEntity payLoad,
    required String actionButtonKey,
  });
}
