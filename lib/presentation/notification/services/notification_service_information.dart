import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/static/constants.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_enums.dart';


const String dailyNotificationChannelKey = "${packageName}_daily_notification";
const String dailyNotificationChannelName = "Daily Ayah Notification";
const String dailyNotificationChannelDescription = "Daily Ayah Notification";
const String pushNotificationChannelKey = "${packageName}_push_notification";
const String pushNotificationChannelName = "Push Notification Channel";
const String pushNotificationChannelDescription = "Push Notification Channel";

const int dailyNotificationId = 2938;
const int pushNotificationId = 3847;

const String notificationIconSource = 'resource://drawable/notification';
const String _notificationSoundSource = 'resource://raw/rng_notification';
const String _localNotificationSoundSource = 'resource://raw/custom_notification';

final List<NotificationChannel> initialNotificationChannels = [
  dailyNotificationChannel,
  _pushNotificationChannel,
];

final NotificationChannel _pushNotificationChannel = NotificationChannel(
  channelKey: pushNotificationChannelKey,
  channelName: pushNotificationChannelName,
  channelDescription: pushNotificationChannelDescription,
  icon: notificationIconSource,
  defaultColor: QuranColor.primaryColorLight,
  playSound: true,
  soundSource: _notificationSoundSource,
);

final NotificationChannel dailyNotificationChannel = NotificationChannel(
  channelKey: dailyNotificationChannelKey,
  channelName: dailyNotificationChannelName,
  channelDescription: dailyNotificationChannelDescription,
  icon: notificationIconSource,
  defaultColor: QuranColor.primaryColorLight,
  playSound: true,
  soundSource: _localNotificationSoundSource,
);

final List<NotificationActionButton> pushNotificationActionButtons = [
  NotificationActionButton(
    key: LocalNotificationActions.read.name,
    label: 'Read Ayah',
  ),
  NotificationActionButton(
    key: LocalNotificationActions.share.name,
    label: 'Share Ayah',
  ),
  NotificationActionButton(
    key: LocalNotificationActions.bookmark.name,
    label: 'Bookmark Ayah',
  ),
];
