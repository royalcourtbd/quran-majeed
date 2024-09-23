import 'dart:async';

import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';

// By separating the mapper functions (toMap, fromMap, toEntity, fromEntity) from the entity class
// and placing them into separate files in the data layer, we gain more flexibility and scalability.
// For example, we can easily run these functions in an isolate to improve performance, or separate DTO
// object types from domain layer entities. This also makes it easier to swap out data sources in the future
// as the functions can be reused with minimal changes. Additionally, this promotes a separation of concerns
// and ensures that the entity class in the domain layer remains clean and focused on business logic.

// Keys and descriptions:
// 1. "icon": The icon associated with the notification.
// 2. "publish": The publication status of the notification, represented as a string.
// 3. "header_image_url": The URL of the header image for the notification.
// 4. "title": The title of the notification.
// 5. "subtitle": The subtitle of the notification.
// 6. "body": The main content or body of the notification.
// 7. "bkash_primary": The primary bKash information in the notification.
// 8. "bkash_secondary": The secondary bKash information in the notification.
// 9. "rocket_primary": The primary Rocket information in the notification.
// 10. "rocket_secondary": The secondary Rocket information in the notification.
// 11. "nagad_primary": The primary Nagad information in the notification.
// 12. "nagad_secondary": The secondary Nagad information in the notification.
// 13. "upay_primary": The primary UPay information in the notification.
// 14. "upay_secondary": The secondary UPay information in the notification.
// 15. "email": The email address associated with the notification.
// 16. "facebook_page_url": The URL of the Facebook page in the notification.
// 17. "facebook_group_url": The URL of the Facebook group in the notification.
// 18. "messenger_button_title": The title of the messenger button in the notification.
// 19. "messenger_button_url": The URL associated with the messenger button in the notification.
// 20. "facebook_button_title": The title of the Facebook button in the notification.
// 21. "facebook_button_url": The URL associated with the Facebook button in the notification.
// 22. "normal_button_text": The text displayed on the normal button in the notification.
// 23. "normal_button_link": The URL associated with the normal button in the notification.
// 24. "normal_button_color": The color of the normal button in hexadecimal format.
// 25. "normal_button_icon": The icon associated with the normal button in the notification.
// 26. "normal_button": The status of the normal button, represented as a string.
// 27. "bank_name": The name of the bank in the notification.
// 28. "bank_info_show": The visibility status of the bank information, represented as a string.
// 29. "bank_account_number": The account number associated with the bank in the notification.
// 30. "bank_account_name": The account name associated with the bank in the notification.
// 31. "bank_branch": The branch information of the bank in the notification.
// 32. "bank_routing": The routing information of the bank in the notification.
// 33. "bank_swift_code": The Swift code associated with the bank in the notification.
// 34. "whatsapp_button_title": The title of the WhatsApp button in the notification.
// 35. "whatsapp_button_url": The URL associated with the WhatsApp button in the notification.
// 36. "telegram_button_title": The title of the Telegram button in the notification.
// 37. "telegram_button_url": The URL associated with the Telegram button in the notification.
// 38. "link": The general link associated with the notification.

extension JsonMapToNotificationPayLoad on Map<String, String?> {
  Future<NotificationPayLoadEntity> toNotificationPayload() async =>
      compute(_convertJsonMapToNotificationPayLoadStatic, this);
}

extension NotificationPayLoadToJsonMap on NotificationPayLoadEntity {
  Future<Map<String, String>> toJsonMap() async => compute(_convertNotificationPayLoadToJsonMapStatic, this);
}

Map<String, String> _convertNotificationPayLoadToJsonMapStatic(
  NotificationPayLoadEntity payLoad,
) {
  return {
    "icon": payLoad.icon,
    "poster_url": payLoad.posterUrl,
    "publish": payLoad.publish.toString(),
    "header_image_url": payLoad.headerImageUrl,
    "title": payLoad.title,
    "subtitle": payLoad.subtitle,
    "body": payLoad.body,
    "bkash_primary": payLoad.bKashPrimary,
    "bkash_secondary": payLoad.bKashSecondary,
    "rocket_primary": payLoad.rocketPrimary,
    "rocket_secondary": payLoad.rocketSecondary,
    "nagad_primary": payLoad.nagadPrimary,
    "nagad_secondary": payLoad.nagadSecondary,
    "upay_primary": payLoad.uPayPrimary,
    "upay_secondary": payLoad.uPaySecondary,
    "email": payLoad.email,
    "facebook_page_url": payLoad.facebookPageUrl,
    "facebook_group_url": payLoad.facebookGroupUrl,
    "messenger_button_title": payLoad.messengerButtonTitle,
    "messenger_button_url": payLoad.messengerButtonUrl,
    "facebook_button_title": payLoad.facebookButtonTitle,
    "facebook_button_url": payLoad.facebookButtonUrl,
    "normal_button_text": payLoad.normalButtonText,
    "normal_button_link": payLoad.normalButtonLink,
    "normal_button_color": getHexFromColor(payLoad.normalButtonColor),
    "normal_button_icon": payLoad.normalButtonIcon,
    "normal_button": payLoad.normalButton.toString(),
    "bank_name": payLoad.bankName,
    "bank_info_show": payLoad.bankInfoShow.toString(),
    "bank_ac_number": payLoad.acNumber,
    "bank_ac_name": payLoad.acName,
    "bank_branch": payLoad.branch,
    "bank_routing": payLoad.routing,
    "bank_swift_code": payLoad.swiftCode,
    "whatsapp_button_title": payLoad.whatsappButtonTitle,
    "whatsapp_button_url": payLoad.whatsappButtonUrl,
    "telegram_button_title": payLoad.telegramButtonTitle,
    "telegram_button_url": payLoad.telegramButtonUrl,
    "link": payLoad.link,
    "link_text": payLoad.linkButtonText,
    "surah_id": payLoad.surahID.toString(), 
    "ayah_id": payLoad.ayahID.toString(), 
    "is_ayah": payLoad.isAyah.toString(),
  };
}

NotificationPayLoadEntity _convertJsonMapToNotificationPayLoadStatic(
  Map<String, String?> map,
) {
  final NotificationPayLoadEntity? notificationPayLoad = catchAndReturn(() {
    final String link = (map['link'] ?? "").trim();
    final int surahID = int.tryParse(map['surah_id'] ?? "-1") ?? -1;
    final int ayahID = int.tryParse(map['ayah_id'] ?? "-1") ?? -1;
    final bool isAyah = ayahID > 0;

    final String body = _concatenateBodies(map);

    return NotificationPayLoadEntity(
      icon: map["icon"] ?? "",
      publish: map['publish'] == "true",
      headerImageUrl: map['header_image_url'] ?? "",
      title: (map['title'] ?? "").isEmpty ? map["notification_title"] ?? "" : map["title"] ?? "",
      subtitle: map['subtitle'] ?? "",
      body: body,
      bKashPrimary: map['bkash_primary'] ?? "",
      bKashSecondary: map['bkash_secondary'] ?? "",
      rocketPrimary: map['rocket_primary'] ?? "",
      rocketSecondary: map['rocket_secondary'] ?? "",
      nagadPrimary: map['nagad_primary'] ?? "",
      nagadSecondary: map['nagad_secondary'] ?? "",
      uPayPrimary: map['upay_primary'] ?? "",
      uPaySecondary: map['upay_secondary'] ?? "",
      email: map['email'] ?? "",
      facebookPageUrl: map['facebook_page_url'] ?? "",
      facebookGroupUrl: map['facebook_group_url'] ?? "",
      messengerButtonTitle: map['messenger_button_title'] ?? "",
      messengerButtonUrl: map['messenger_button_url'] ?? "",
      facebookButtonTitle: map['facebook_button_title'] ?? "",
      facebookButtonUrl: map['facebook_button_url'] ?? "",
      normalButtonText: map['normal_button_text'] ?? "",
      normalButtonLink: map['normal_button_link'] ?? "",
      normalButtonColor: getColorFromHex(map['normal_button_color']),
      normalButtonIcon: map['normal_button_icon'] ?? "",
      normalButton: map['normal_button'] == "true",
      bankName: map['bank_name'] ?? "",
      bankInfoShow: map['bank_info_show'] == "true",
      acNumber: map['bank_ac_number'] ?? "",
      acName: map['bank_ac_name'] ?? "",
      branch: map['bank_branch'] ?? "",
      routing: map['bank_routing'] ?? "",
      swiftCode: map['bank_swift_code'] ?? "",
      whatsappButtonTitle: map['whatsapp_button_title'] ?? "",
      whatsappButtonUrl: map['whatsapp_button_url'] ?? "",
      telegramButtonTitle: map['telegram_button_title'] ?? "",
      telegramButtonUrl: map['telegram_button_url'] ?? "",
      surahID: surahID,
      ayahID: ayahID,
      isAyah: isAyah,
      link: link,
      openInBrowser: link.isNotEmpty,
      linkButtonText: map["link_text"] ?? "",
      blogId: int.tryParse(map["blog_id"] ?? "-1") ?? -1,
      headerText: map["header_text"] ?? "",
      posterUrl: map["poster_url"] ?? "",
    );
  });
  return notificationPayLoad ?? NotificationPayLoadEntity.empty();
}

String _concatenateBodies(Map<String, String?> map) {
  final StringBuffer bodyStringBuffer = StringBuffer();
  final List<String> keys = map.keys.toList()..sort();
  final List<String> bodyKeys = keys.where((String key) => key.contains("body")).toList(growable: false);
  for (final String key in bodyKeys) {
    bodyStringBuffer
      ..write(map[key])
      ..write("<br><br>");
  }
  final String body = bodyStringBuffer.toString().trim();
  return body;
}
