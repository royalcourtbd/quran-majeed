import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/mappers/promotional_message_mapper.dart';
import 'package:quran_majeed/data/service/backend_as_a_service.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

class InfoRemoteDataSource {
  InfoRemoteDataSource(
    this._backendAsAService,
  );

  final BackendAsAService _backendAsAService;

  Future<void> getPromotionalMessage({
    required void Function(PromotionalMessageEntity) onMessage,
  }) async {
    await _backendAsAService.getRemoteNotice(
      onNotification: (map) async {
        await catchFutureOrVoid(() async {
          final Map<String, Object?> remoteNoticeMap = map.map(MapEntry.new);
          final PromotionalMessageEntity promotionalMessage =
              await convertJsonMapToPromotionalMessage(map: remoteNoticeMap);
          onMessage(promotionalMessage);
        });
      },
    );
  }

  Future<void> logPromotionMessageSeen({required int messageId}) async {
    await _backendAsAService.logPromotionMessageSeen(messageId: messageId);
  }
}
