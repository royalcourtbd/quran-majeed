import 'dart:async';
import 'package:quran_majeed/data/data_sources/local_data_source/info_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/info_remote_data_source.dart';
import 'package:quran_majeed/domain/entities/our_project_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';

class InfoRepositoryImpl extends InfoRepository {
  InfoRepositoryImpl(
    this._infoLocalDataSource,
    this._infoRemoteDataSource,
  );

  final InfoLocalDataSource _infoLocalDataSource;
  final InfoRemoteDataSource _infoRemoteDataSource;


  late PromotionalMessageEntity? notification;

  @override
  Future<void> getPromotionalMessage({
    required void Function(PromotionalMessageEntity?) onMessage,
  }) async {
    await _infoRemoteDataSource.getPromotionalMessage(
      onMessage: (promotionalMessage) async {
        // Checks if the promotional message should be published
        final bool shouldPublish = await _infoLocalDataSource
            .shouldPublishPromotionalMessage(notification: promotionalMessage);

        // If the promotional message should not be published, the onNotification
        // callback is called with null to indicate that the message should not
        // be displayed to the user.
        if (!shouldPublish) {
          onMessage(null);
          return;
        }

        notification = promotionalMessage;

        // If the promotional message should be published, the message ID is
        // saved locally as shown, and the onNotification callback is called
        // with the notification payload to display the message.
        onMessage(promotionalMessage);
      },
    );
  }

  @override
  Future<void> closePromotionalMessage({required bool userSeen}) async {
    if (notification == null) return;
    await _infoLocalDataSource.savePromotionalMessageShown(
      promotionalMessageId: notification!.id,
    );
    if (!userSeen) return;
    await _infoRemoteDataSource.logPromotionMessageSeen(
      messageId: notification!.id,
    );
  }


  @override
  Future<String> getAboutApp() => _infoLocalDataSource.getAboutApp();

  @override
  Future<String> getAboutOrganization() =>
      _infoLocalDataSource.getAboutOrganization();

  @override
  Future<String> getContactUsMessage() =>
      _infoLocalDataSource.getContactUsMessage();

  @override
  Future<String> getDonateMessage() => _infoLocalDataSource.getDonateMessage();

  @override
  Future<String> getHelpUsMessage() => _infoLocalDataSource.getHelpUsMessage();

  @override
  Future<String> getLibraryAddress() =>
      _infoLocalDataSource.getLibraryAddress();

  @override
  Future<String> getVolunteerHelp() => _infoLocalDataSource.getVolunteerHelp();

  @override
  Future<String> getThanksMessage() => _infoLocalDataSource.getThanksMessage();

  @override
  Future<String> getTopTenApps() => _infoLocalDataSource.getTopTenApps();

  @override
  Future<String> getPrivacyPolicy() => _infoLocalDataSource.getPrivacyPolicy();


  @override
  Future<List<OurProjectEntity>> getOurProjects() =>
      _infoLocalDataSource.getOtherProjects();
}
