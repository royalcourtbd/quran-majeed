
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/notification/notification_repository.dart';

class SetUpPushNotificationUseCase extends BaseUseCase<void> {
  SetUpPushNotificationUseCase(
    this._notificationRepository,
    super._errorMessageHandler,
  );

  final NotificationRepository _notificationRepository;

  Future<void> execute() async {
    return doVoid(
      () async => _notificationRepository.setUpPushNotificationListeners(),
    );
  }
}
