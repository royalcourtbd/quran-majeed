import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/throttle_service.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/notification_entity_mapper.dart';
import 'package:quran_majeed/data/mappers/promotional_message_mapper.dart';
import 'package:quran_majeed/data/mappers/setting_entity_mapper.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/service/notification_service.dart';
import 'package:quran_majeed/presentation/daily_ayah/ui/daily_ayah_page.dart';
import 'package:quran_majeed/presentation/home/ui/notice/notice_dialog.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_enums.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_information.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_utilities.dart';
import 'package:quran_majeed/presentation/notification/services/static_virtual_machine_entry_points.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';

class NotificationServicePresentable extends NotificationService {
  NotificationServicePresentable(
    this._notificationService,
    this._localCacheService,
  );

  final AwesomeNotifications _notificationService;
  final LocalCacheService _localCacheService;

  late final SettingsPresenter _presenter = locate();

  @override
  Future<void> scheduleNotificationAutomatically() async {
    await catchFutureOrVoid(() async {
      final SettingsStateEntity settingsState = await getSettingState();
      if (!settingsState.showDailyNotification) return;
      await scheduleNotification(
        turnOn: true,
        time: settingsState.dailyNotificationTime,
      );
    });
  }

  Future<SettingsStateEntity> getSettingState() async {
    final SettingsStateEntity? settingState =
        await catchAndReturnFuture(() async {
      final String? settingsStateSerialised =
          _localCacheService.getData(key: CacheKeys.settingsState);
      if (settingsStateSerialised == null) return SettingsStateEntity.empty();
      final SettingsStateEntity settingsState =
          await settingsStateSerialised.toSettingStateEntity();
      return settingsState;
    });
    return settingState ?? SettingsStateEntity.empty();
  }

  @override
  Future<void> scheduleNotification({
    required bool turnOn,
    required TimeOfDay time,
  }) async {
    // // on ios, the notification permission is optional,
    // // so when the user turns on notification, but he denied the permission before
    // // we would just ignore his/her request
    // final bool isNotificationGranted = await isNotificationAllowed();
    // if (!isNotificationGranted && Platform.isIOS) return;
    await catchFutureOrVoid(
      () async =>
          _notificationService.removeChannel(dailyNotificationChannelKey),
    );
    await _createDailyNotificationChannel();
    // but, the case is different for android, we would navigate him
    // to permission settings page to grant permission, if he wants to receive
    // permission
    await askNotificationPermission(
      onGrantedOrSkippedForNow: () async {
        if (turnOn) {
          final String timeZone =
              await _notificationService.getLocalTimeZoneIdentifier();
          await _scheduleMorningNotifications(time, timeZone);
          await _scheduleEveningNotifications(time, timeZone);
        }
      },
      onDenied: _openNotificationSettings,
    );
  }

  static const String _notificationTitle =
      "Did you forget to read Quran today?";
  static const String _notificationBody =
      "Read Quran and get blessings from Allah";

  Future<void> _scheduleMorningNotifications(
    TimeOfDay time,
    String timeZone,
  ) async {
    final TimeOfDay morningTimeDay =
        await NotificationServiceUtilities.convertTimeIntoTimeAtMorning(time);

    final NotificationContent content = NotificationContent(
      id: 22348,
      channelKey: dailyNotificationChannelKey,
      title: _notificationTitle,
      body: _notificationBody,
      category: NotificationCategory.Recommendation,
      backgroundColor: QuranColor.primaryColorLight,
      notificationLayout: NotificationLayout.BigText,
    );
    final NotificationCalendar schedule = NotificationCalendar(
      hour: morningTimeDay.hour,
      minute: morningTimeDay.minute,
      second: 0,
      millisecond: 0,
      timeZone: timeZone,
      allowWhileIdle: true,
      repeats: true,
    );

    await _notificationService.createNotification(
      content: content,
      schedule: schedule,
    );
  }

  Future<void> _scheduleEveningNotifications(
    TimeOfDay time,
    String timeZone,
  ) async {
    final TimeOfDay eveningTimeOfDay =
        await NotificationServiceUtilities.convertTimeIntoTimeAtEvening(time);

    final NotificationContent content = NotificationContent(
      id: 29384,
      channelKey: dailyNotificationChannelKey,
      title: _notificationTitle,
      body: _notificationBody,
      category: NotificationCategory.Recommendation,
      backgroundColor: QuranColor.primaryColorLight,
      notificationLayout: NotificationLayout.BigText,
    );

    final NotificationCalendar schedule = NotificationCalendar(
      hour: eveningTimeOfDay.hour,
      minute: eveningTimeOfDay.minute,
      repeats: true,
      second: 0,
      millisecond: 0,
      allowWhileIdle: true,
      timeZone: timeZone,
    );

    await _notificationService.createNotification(
      content: content,
      schedule: schedule,
    );
  }

  Future<bool> _openNotificationSettings() async {
    if (!Platform.isAndroid) return false;
    const notificationAndroid = OpenSettingsPlusAndroid();

    final bool isOpened = await notificationAndroid.appNotification();
    if (isOpened) return true;

    await showMessage(message: "Something went wrong, please try again");
    return false;
  }

  int _dateTimeToId(DateTime? time) {
    final id = catchAndReturn(() {
      if (time == null) return pushNotificationId;
      return time.millisecondsSinceEpoch.toSigned(20);
    });
    return id ?? time.hashCode;
  }

  @override
  Future<void> setUp() async {
    await catchFutureOrVoid(() async {
      final bool initialised = await _notificationService.initialize(
        notificationIconSource,
        initialNotificationChannels,
        debug: !kReleaseMode,
      );
      if (!initialised) return;
      _addNotificationListeners(_notificationService);

      await _createDailyNotificationChannel();
    });
  }

  Future<void> _createDailyNotificationChannel() async {
    await _notificationService.setChannel(NotificationChannel(
      channelKey: dailyNotificationChannelKey,
      channelName: dailyNotificationChannelName,
      channelDescription: dailyNotificationChannelDescription,
      defaultColor: QuranColor.primaryColorLight,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    ));
  }

  @override
  Future<bool> isNotificationAllowed() async {
    final bool? isNotificationAllowed = await catchAndReturnFuture(() async {
      final bool isNoNeedForPermission = await determineIfNoNeedForPermission();
      if (isNoNeedForPermission) return true;

      final bool isNotificationAllowed =
          await _notificationService.isNotificationAllowed();
      return isNotificationAllowed;
    });
    return isNotificationAllowed ?? false;
  }

  static Future<bool> determineIfNoNeedForPermission() async {
    final bool? noNeedForPermission = await catchAndReturnFuture(() async {
      if (Platform.isIOS) return false;
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 28) return true;
      return false;
    });
    return noNeedForPermission ?? false;
  }

  @override
  Future<void> askNotificationPermission({
    required VoidCallback onGrantedOrSkippedForNow,
    required VoidCallback onDenied,
  }) async {
    Throttle.throttle("askNotificationPermissionThrottle", 1.inSeconds,
        () async {
      await catchFutureOrVoid(() async {
        final bool noNeedForInformation =
            await determineIfNoNeedForPermission();
        if (noNeedForInformation) {
          onGrantedOrSkippedForNow();
          return;
        }

        final bool isNotificationAllowed =
            await _notificationService.isNotificationAllowed();
        if (isNotificationAllowed) {
          onGrantedOrSkippedForNow();
          return;
        }

        final bool isNotificationAccepted =
            await _notificationService.requestPermissionToSendNotifications();

        if (!isNotificationAccepted && Platform.isAndroid) {
          await _openNotificationSettings();
          onDenied();
        }

        // we are making ios permission optional
        if (isNotificationAccepted || Platform.isIOS) {
          await FirebaseMessaging.instance.requestPermission();
          onGrantedOrSkippedForNow();
          return;
        }

        if (!isNotificationAccepted) {
          await _notificationService.requestPermissionToSendNotifications();
          onGrantedOrSkippedForNow();
        }
      });
    });
  }

  void _addNotificationListeners(
    AwesomeNotifications awesomeNotifications,
  ) {
    awesomeNotifications.setListeners(
      onActionReceivedMethod: onNotificationClickedWhenAppInForeground,
    );
  }

  @override
  Future<void> onOpenedFromNotification() async {
    try {
      final ReceivedAction? receivedAction =
          await _notificationService.getInitialNotificationAction();
      if (receivedAction == null) return;

      final bool isDailyNotification =
          receivedAction.channelKey == dailyNotificationChannelKey;
      if (isDailyNotification) {
        await onNotificationClickedForDailyNotification();
        return;
      }

      final bool isPushNotification =
          receivedAction.channelKey == pushNotificationChannelKey;
      if (isPushNotification) {
        if (_appContext.mounted) {
          await _onOpenedFromPushNotification(
            receivedAction: receivedAction,
            context: _appContext,
          );
        }
        return;
      }
    } catch (e) {
      logErrorStatic(e, _fileName);
      await showMessage(message: "Can't open notification");
    }
  }

  Future<void> _onOpenedFromPushNotification({
    required ReceivedAction receivedAction,
    required BuildContext context,
  }) async {
    final Map<String, String?>? payloadMap = receivedAction.payload;
    if (payloadMap == null) return;
    final NotificationPayLoadEntity payLoad =
        await payloadMap.toNotificationPayload();
    if (payLoad.openInBrowser) {
      await openUrl(url: payLoad.link);
      return;
    }
    final PromotionalMessageEntity notice =
        await convertNotificationPayLoadToPromotionalMessage(payLoad: payLoad);
    if (context.mounted) {
      await NoticeDialog.show(
        notice: notice,
        onClose: _presenter.closeNoticeBox,
        context: context,
      );
    }
  }

  static Future<void> onNotificationClickedForDailyNotification() async {
    await _goToSingleHadithPage(
      isBookmarkButtonClicked: false,
      isShareButtonClicked: false,
      context: _appContextStatic,
    );
  }

  BuildContext get _appContext => QuranMajeed.globalContext;

  static BuildContext get _appContextStatic => QuranMajeed.globalContext;

  static Future<void> _goToSingleHadithPage({
    required bool isBookmarkButtonClicked,
    required bool isShareButtonClicked,
    required BuildContext context,
  }) async {
    final DailyAyahPage dailyAyahPage = DailyAyahPage();
    await context.navigatorPush<void>(dailyAyahPage);
  }

  @override
  Future<void> onNotificationClickedForPushNotification({
    required NotificationPayLoadEntity payLoad,
    required String actionButtonKey,
  }) async {
    final bool isDonateUsClicked =
        actionButtonKey == PushNotificationActions.donateUs.name;
    final bool isLinkClicked =
        actionButtonKey == PushNotificationActions.link.name;

    if (payLoad.openInBrowser || isLinkClicked) {
      await openUrl(url: payLoad.link);
      return;
    }

    if (payLoad.isAyah) {
      await _goToSingleHadithPage(
        isBookmarkButtonClicked: false,
        isShareButtonClicked: false,
        context: _appContext,
      );
    }

    if (isDonateUsClicked) {
      // if (_appContext.mounted) await _appContext.navigatorPush<void>(supportUsPage);

      return;
    }

    final PromotionalMessageEntity notice =
        await convertNotificationPayLoadToPromotionalMessage(payLoad: payLoad);
    if (_appContext.mounted) {
      await NoticeDialog.show(
        notice: notice,
        onClose: _presenter.closeNoticeBox,
        context: _appContext,
      );
    }
    return;
  }

  @override
  Future<void> showNotification({
    DateTime? sentTime,
    required NotificationPayLoadEntity payLoad,
  }) async {
    final bool isNotificationAllowed =
        await _notificationService.isNotificationAllowed();
    if (!isNotificationAllowed) return;

    final int notifyId = _dateTimeToId(sentTime);
    await catchFutureOrVoid(
      () async {
        // when we use firebase_messaging package for push notifications
        // it automatically sends a notification without proper sound or icon
        // so we have to first hide the previously shown notification by firebase,
        // and then show the new one, we have created with proper sound and icon
        await Future<void>.delayed(const Duration(seconds: 2));
        await _notificationService.dismissAllNotifications();
      },
    );

    final Map<String, String?> payLoadMap = await payLoad.toJsonMap();

    await _notificationService.createNotification(
      content: NotificationServiceUtilities.buildNotificationContent(
        notificationId: notifyId,
        payload: payLoadMap,
        channelKey: pushNotificationChannelKey,
      ),
      actionButtons: [
        if (payLoad.openInBrowser)
          NotificationActionButton(
            key: PushNotificationActions.link.name,
            label: payLoad.linkButtonText.isNotEmpty
                ? payLoad.linkButtonText
                : "লিংকে যান",
          ),
        if (!payLoad.openInBrowser)
          NotificationActionButton(
            key: PushNotificationActions.readMore.name,
            label: "Read More",
          ),
        if (!payLoad.openInBrowser)
          NotificationActionButton(
            key: payLoad.isAyah
                ? PushNotificationActions.ayah.name
                : PushNotificationActions.donateUs.name,
            label: payLoad.isAyah ? "Read Ayah" : "Support Us",
          ),
      ],
    );
  }
}

const String _fileName = "notification_service_presentable.dart";
