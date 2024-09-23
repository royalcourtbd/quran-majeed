import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/data/mappers/notification_entity_mapper.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';
import 'package:quran_majeed/domain/service/notification_service.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_information.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_presentable.dart';

/// Handles the actions that should be taken when a notification is clicked while
/// the app is in the foreground.
@pragma("vm:entry-point")
Future<void> onNotificationClickedWhenAppInForeground(Object? action) async {
  if (action == null) return;
  if (action is! ReceivedAction) return;

  if (action.channelKey == dailyNotificationChannelKey) {
    await NotificationServicePresentable.onNotificationClickedForDailyNotification();
    return;
  }

  if (action.channelKey == pushNotificationChannelKey) {
    final Map<String, String?>? payLoadMap = action.payload;
    if (payLoadMap == null) return;
    final NotificationPayLoadEntity payLoad = await payLoadMap.toNotificationPayload();
    final NotificationService notificationService = locate<NotificationService>();
    final String buttonKey = action.buttonKeyPressed;
    await notificationService.onNotificationClickedForPushNotification(
      payLoad: payLoad,
      actionButtonKey: buttonKey,
    );
  }
}

/// Called when a background push notification is received.
///
/// Checks if the received message is not null and is an instance of
/// RemoteMessage class.
/// Then maps the data payload of the message to a Map<String, String?> object
/// and converts the Map to a NotificationPayLoadEntity object using a helper
/// function named convertJsonMapToNotificationPayLoad().
///
/// If the payload of the notification is related to a Ayah, it returns and
/// exits the function.
///
/// Otherwise, it initializes an AwesomeNotifications instance and a
/// NotificationServicePresentable instance.
/// It then shows the notification using the
/// notificationService.showNotification(payLoad: payLoad) method.
@pragma("vm:entry-point") // Marks this function as an entry point for the VM
Future<void> onBackgroundPushNotificationReceived(Object? message) async {
  // Exit early if the message is null
  if (message == null) return;
  // Exit early if the message is not a RemoteMessage
  if (message is! RemoteMessage) return;

  // Extracts a map of String keys to nullable String values from the data
  // field of the message
  final Map<String, String?> payLoadMap =
      message.data.map((key, value) => MapEntry(key, (value as Object?)?.toString()));

  // Converts the payload map into a NotificationPayLoadEntity object
  final NotificationPayLoadEntity payLoad = await payLoadMap.toNotificationPayload();

  // Create instances of AwesomeNotifications and NotificationServicePresentable
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  await awesomeNotifications.cancelNotificationsByChannelKey(pushNotificationChannelKey);
  final NotificationService notificationService = locate<NotificationService>();

  // Show the notification using the notification service
  await notificationService.showNotification(
    sentTime: message.sentTime,
    payLoad: payLoad,
  );
}
