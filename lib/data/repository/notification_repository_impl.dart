import 'package:quran_majeed/data/data_sources/remote_data_source/info_remote_data_source.dart';
import 'package:quran_majeed/data/service/backend_as_a_service.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';
import 'package:quran_majeed/domain/repositories/notification/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl(
    this.backendAsAService,
    this.quranDatabase,
    this.infoRemoteDataSource,
    this.localCacheService,
  );

  final BackendAsAService backendAsAService;
  final LocalCacheService localCacheService;
  final QuranDatabase quranDatabase;
  final InfoRemoteDataSource infoRemoteDataSource;

  Future<void> _getAndSaveDeviceToken() async {
    await backendAsAService.listenToDeviceToken(
      onTokenFound: (token) => localCacheService.saveData<String>(
        key: CacheKeys.fcmDeviceToken,
        value: token,
      ),
    );
  }

  @override
  Future<NotificationPayLoadEntity> getAyahAsNotificationPayLoad({
    DateTime? date,
  }) async {
    // final HadithEntity hadith =
    //     await hadithLocalDataSource.getSahihHadithByDate(date: date);

    // final String hadithText = await convertHadithToShareableString(
    //   hadith: hadith,
    //   shareWithArabicText: false,
    //   shareWithBanglaText: true,
    //   showGradeAndSource: false,
    // );
    final NotificationPayLoadEntity notificationPayLoad = NotificationPayLoadEntity.forAyah(
      surahID: 1,
      ayahID: 1,
      notificationTitle: "Daily Ayah",
      translation: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
    );
    return notificationPayLoad;
  }

  @override
  Future<void> setUpPushNotificationListeners() async {
    await _getAndSaveDeviceToken();
    await backendAsAService.listenToFirebaseNotification();
  }

}
