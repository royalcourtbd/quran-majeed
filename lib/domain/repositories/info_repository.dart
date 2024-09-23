

import 'package:quran_majeed/domain/entities/our_project_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

abstract class InfoRepository {

  Future<void> getPromotionalMessage({
    required void Function(PromotionalMessageEntity?) onMessage,
  });

  Future<void> closePromotionalMessage({required bool userSeen});

  Future<String> getDonateMessage();

  Future<String> getHelpUsMessage();

  Future<String> getAboutOrganization();

  Future<String> getContactUsMessage();

  Future<String> getLibraryAddress();

  Future<String> getThanksMessage();

  Future<String> getVolunteerHelp();

  Future<String> getTopTenApps();

  Future<String> getPrivacyPolicy();

  Future<String> getAboutApp();

  Future<List<OurProjectEntity>> getOurProjects();
}
