import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/notification/announcement_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/domain/repositories/dailyAyah/daily_ayah_repository.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetAnnouncementUseCase extends BaseUseCase<AnnouncementEntity> {
  GetAnnouncementUseCase(
    this._infoRepository,
    this._dailyAyahRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final InfoRepository _infoRepository;
  final DailyAyahRepository _dailyAyahRepository;

  late final StreamController<Either<String, AnnouncementEntity>> _announcementStreamController = StreamController();

  Stream<Either<String, AnnouncementEntity>> execute() async* {
    await _fetchAyahListAsAnnouncement();
    await _fetchPromotionalMessageAsAnnouncement();
    yield* _announcementStreamController.stream;
  }

  List<AyahDatabaseTableData> ayahList = [];

  Future<void> _fetchAyahListAsAnnouncement() async {
    // we are first returning a static list, to give user faster perceived
    // performance
    final Either<String, AnnouncementEntity> cachedResult = await mapResultToEither(_getCachedAyahListAsAnnouncement);
    _announcementStreamController.add(cachedResult);

    final Either<String, AnnouncementEntity> result = await mapResultToEither(_getAyahListAsAnnouncement);
    _announcementStreamController.add(result);
  }

  Future<AnnouncementEntity> _getAyahListAsAnnouncement() async {
    ayahList = await _ayahListAsTexts;
    return const AnnouncementEntity(
      ayahList: [],
      promotionalMessage: null,
      announcementType: AnnouncementType.ayah,
    );
  }

  AnnouncementEntity _getCachedAyahListAsAnnouncement() {
    final AnnouncementEntity announcement = AnnouncementEntity(
      ayahList: ayahList,
      promotionalMessage: null,
      announcementType: AnnouncementType.ayah,
    );
    return announcement;
  }

  Future<void> _fetchPromotionalMessageAsAnnouncement() async {
    await _infoRepository.getPromotionalMessage(
      onMessage: (notification) async {
        final Either<String, AnnouncementEntity> result = await mapResultToEither(
          () => _createAnnouncementEntityFromPromotionalMessage(notification),
        );
        _announcementStreamController.add(result);
      },
    );
  }

  AnnouncementEntity _createAnnouncementEntityFromPromotionalMessage(
    PromotionalMessageEntity? promotionalMessage,
  ) {
    // if returned notification is null, that means we got the notification
    // from the server, but there was something wrong, which could be
    // we are getting notification with same id, or the publish tag
    // could be false.
    // in such cases, we won't show the notification.
    final AnnouncementType announcementType =
        promotionalMessage != null ? AnnouncementType.promotionalMessage : AnnouncementType.ayah;
    return AnnouncementEntity(
      ayahList: ayahList,
      promotionalMessage: promotionalMessage,
      announcementType: announcementType,
    );
  }

  // we are separating it into a function for easier error handling.
  Future<List<AyahDatabaseTableData>> get _ayahListAsTexts async {
    try {
      final List<AyahDatabaseTableData> ayahList = await _dailyAyahRepository.getAllDailyAyahList();
      return ayahList;
    } catch (e) {
      logError(e);
      return [];
    }
  }

  Future<void> dispose() async {
    await _announcementStreamController.close();
  }
}
