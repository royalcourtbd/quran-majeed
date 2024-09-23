
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';

abstract class NotificationRepository {
  Future<NotificationPayLoadEntity> getAyahAsNotificationPayLoad({
    DateTime? date,
  });

  Future<void> setUpPushNotificationListeners();
}
