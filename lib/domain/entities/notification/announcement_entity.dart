import 'package:equatable/equatable.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

class AnnouncementEntity extends Equatable {
  const AnnouncementEntity({
    required this.ayahList,
    required this.promotionalMessage,
    required this.announcementType,
  });

  factory AnnouncementEntity.empty() => AnnouncementEntity(
        ayahList: const [
          AyahDatabaseTableData(
            id: 1,
            surahId: 1,
            ayahID: 1,
            trEn: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
          ),
        ],
        promotionalMessage: PromotionalMessageEntity.empty(),
        announcementType: AnnouncementType.ayah,
      );

  final List<AyahDatabaseTableData> ayahList;
  final PromotionalMessageEntity? promotionalMessage;
  final AnnouncementType announcementType;

  @override
  List<Object?> get props => [ayahList, promotionalMessage, announcementType];

  AnnouncementEntity close() => AnnouncementEntity(
        ayahList: ayahList,
        promotionalMessage: null,
        announcementType: AnnouncementType.ayah,
      );
}

enum AnnouncementType { ayah, promotionalMessage }
