import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/dto/remote_notice_dto.dart';
import 'package:quran_majeed/domain/entities/notification/notification_payload_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

// By separating the mapper functions (toMap, fromMap, toEntity, fromEntity) from the entity class
// and placing them into separate files in the data layer, we gain more flexibility and scalability.
// For example, we can easily run these functions in an isolate to improve performance, or separate DTO
// object types from domain layer entities. This also makes it easier to swap out data sources in the future
// as the functions can be reused with minimal changes. Additionally, this promotes a separation of concerns
// and ensures that the entity class in the domain layer remains clean and focused on business logic.

Future<PromotionalMessageEntity> convertJsonMapToPromotionalMessage({
  required Map<String, Object?> map,
}) async {
  final PromotionalMessageEntity message = await compute(_convertJsonMapToPromotionalMessage, map);
  return message;
}

Future<PromotionalMessageEntity> convertNotificationPayLoadToPromotionalMessage({
  required NotificationPayLoadEntity payLoad,
}) async {
  final PromotionalMessageEntity message = await compute(
    _convertNotificationPayLoadToPromotionalMessage,
    payLoad,
  );
  return message;
}

PromotionalMessageEntity _convertNotificationPayLoadToPromotionalMessage(
  NotificationPayLoadEntity payLoad,
) {
  final PromotionalMessageAdditionalButton additionalButton = PromotionalMessageAdditionalButton(
    buttonColor: payLoad.normalButtonColor,
    buttonIconUrl: payLoad.normalButtonIcon,
    buttonText: payLoad.normalButtonText,
    buttonUrl: payLoad.normalButtonLink,
    showButton: payLoad.normalButton,
  );
  final PromotionalMessageOtherContacts otherContacts = _payLoadToOtherContacts(payLoad);
  final PromotionalMessagePaymentBank paymentBank = _payLoadToPaymentBank(payLoad);
  final PromotionalMessagePaymentMobile paymentMobile = _payLoadToPaymentMobile(payLoad);
  final PromotionalMessagePost post = _payLoadToMessagePost(payLoad);
  final PromotionalMessageSocialMedia socialMedia = _payLoadToSocialMedia(payLoad);

  return PromotionalMessageEntity(
    id: DateTime.now().microsecond,
    publish: true,
    additionalButton: additionalButton,
    otherContacts: otherContacts,
    paymentBank: paymentBank,
    paymentMobile: paymentMobile,
    post: post,
    socialMedia: socialMedia,
    blogId: payLoad.blogId,
    headerText: payLoad.headerText,
  );
}

PromotionalMessageOtherContacts _payLoadToOtherContacts(
  NotificationPayLoadEntity payLoad,
) {
  return PromotionalMessageOtherContacts(
    email: payLoad.email,
    facebookGroupUrl: payLoad.facebookGroupUrl,
    facebookPageUrl: payLoad.facebookPageUrl,
  );
}

PromotionalMessagePaymentBank _payLoadToPaymentBank(
  NotificationPayLoadEntity payLoad,
) {
  return PromotionalMessagePaymentBank(
    accountName: payLoad.acName,
    accountNumber: payLoad.acNumber,
    showBankInfo: payLoad.bankInfoShow,
    bankName: payLoad.bankName,
    bankBranch: payLoad.branch,
    swiftCode: payLoad.swiftCode,
    routingNumber: payLoad.routing,
  );
}

PromotionalMessagePaymentMobile _payLoadToPaymentMobile(
  NotificationPayLoadEntity payLoad,
) {
  return PromotionalMessagePaymentMobile(
    bKashPrimary: payLoad.bKashPrimary,
    bKashSecondary: payLoad.bKashSecondary,
    nagadPrimary: payLoad.nagadPrimary,
    nagadSecondary: payLoad.nagadSecondary,
    rocketPrimary: payLoad.rocketPrimary,
    rocketSecondary: payLoad.rocketSecondary,
    uPayPrimary: payLoad.uPayPrimary,
    uPaySecondary: payLoad.uPaySecondary,
  );
}

PromotionalMessagePost _payLoadToMessagePost(
  NotificationPayLoadEntity payLoad,
) {
  return PromotionalMessagePost(
    title: payLoad.title,
    subtitle: payLoad.subtitle,
    body: payLoad.body,
    headerImageUrl: payLoad.headerImageUrl,
    posterUrl: payLoad.posterUrl,
  );
}

PromotionalMessageSocialMedia _payLoadToSocialMedia(
  NotificationPayLoadEntity payLoad,
) {
  return PromotionalMessageSocialMedia(
    messengerButtonTitle: payLoad.messengerButtonTitle,
    messengerButtonUrl: payLoad.messengerButtonUrl,
    telegramButtonTitle: payLoad.telegramButtonTitle,
    telegramButtonUrl: payLoad.telegramButtonUrl,
    whatsappButtonTitle: payLoad.whatsappButtonTitle,
    whatsappButtonUrl: payLoad.whatsappButtonUrl,
    facebookButtonTitle: payLoad.facebookButtonTitle,
    facebookButtonUrl: payLoad.facebookButtonUrl,
  );
}

PromotionalMessageEntity _convertJsonMapToPromotionalMessage(
  Map<String, Object?> map,
) {
  final PromotionalMessageEntity? promotionalMessage = catchAndReturn(() {
    final RemoteNoticeDto remoteNoticeDto = RemoteNoticeDto.fromJson(map);
    final int id = remoteNoticeDto.publish?.id ?? -1;
    final bool shouldPublish = _determineIfShouldPublish(remoteNoticeDto);

    final PromotionalMessageAdditionalButton additionalButton =
        _dtoToAdditionalButton(remoteNoticeDto.additionalButton);

    final PromotionalMessageOtherContacts otherContacts = _dtoToOtherContacts(remoteNoticeDto.otherContacts);

    final PromotionalMessagePaymentBank paymentBank = _dtoToPaymentBank(remoteNoticeDto.paymentBank);

    final PromotionalMessagePaymentMobile paymentMobile = _dtoToPaymentMobile(remoteNoticeDto.paymentMobile);

    final PromotionalMessageSocialMedia socialMedia = _dtoToSocialMedia(remoteNoticeDto.socialMedia);

    final PromotionalMessagePost post = _dtoToPost(remoteNoticeDto.post);

    return PromotionalMessageEntity(
      id: id,
      publish: shouldPublish,
      additionalButton: additionalButton,
      otherContacts: otherContacts,
      paymentBank: paymentBank,
      paymentMobile: paymentMobile,
      post: post,
      socialMedia: socialMedia,
      blogId: map["blog_id"] as int? ?? -1,
      headerText: remoteNoticeDto.post?.headerText ?? "",
    );
  });
  return promotionalMessage ?? PromotionalMessageEntity.empty();
}

PromotionalMessagePost _dtoToPost(PostDto? dto) {
  if (dto == null) return PromotionalMessagePost.empty();
  return PromotionalMessagePost(
    title: dto.title ?? "",
    subtitle: dto.subtitle ?? "",
    body: dto.body ?? "",
    headerImageUrl: dto.headerImageUrl ?? "",
    posterUrl: dto.posterUrl ?? "",
  );
}

PromotionalMessageSocialMedia _dtoToSocialMedia(SocialMediaDto? dto) {
  if (dto == null) return PromotionalMessageSocialMedia.empty();
  return PromotionalMessageSocialMedia(
    messengerButtonTitle: dto.messengerButtonTitle ?? "",
    messengerButtonUrl: dto.messengerButtonUrl ?? "",
    telegramButtonTitle: dto.telegramButtonTitle ?? "",
    telegramButtonUrl: dto.telegramButtonUrl ?? "",
    whatsappButtonTitle: dto.whatsappButtonTitle ?? "",
    whatsappButtonUrl: dto.whatsappButtonUrl ?? "",
    facebookButtonTitle: dto.facebookButtonTitle ?? "",
    facebookButtonUrl: dto.facebookButtonUrl ?? "",
  );
}

PromotionalMessagePaymentMobile _dtoToPaymentMobile(PaymenMobileDto? dto) {
  if (dto == null) return PromotionalMessagePaymentMobile.empty();
  return PromotionalMessagePaymentMobile(
    bKashPrimary: dto.bkashPrimary ?? "",
    bKashSecondary: dto.bkashSecondary ?? "",
    rocketPrimary: dto.rocketPrimary ?? "",
    rocketSecondary: dto.rocketSecondary ?? "",
    nagadPrimary: dto.nagadPrimary ?? "",
    nagadSecondary: dto.nagadSecondary ?? "",
    uPayPrimary: dto.upayPrimary ?? "",
    uPaySecondary: dto.upaySecondary ?? "",
  );
}

PromotionalMessagePaymentBank _dtoToPaymentBank(PaymentBankDto? dto) {
  if (dto == null) return PromotionalMessagePaymentBank.empty();
  return PromotionalMessagePaymentBank(
    accountName: dto.acName ?? "",
    accountNumber: dto.acNumber ?? "",
    bankName: dto.bankName ?? "",
    bankBranch: dto.branch ?? "",
    routingNumber: dto.routing ?? "",
    swiftCode: dto.swiftcode ?? "",
    showBankInfo: dto.bankInfoShow ?? false,
  );
}

PromotionalMessageOtherContacts _dtoToOtherContacts(OtherContactsDto? dto) {
  if (dto == null) return PromotionalMessageOtherContacts.empty();
  return PromotionalMessageOtherContacts(
    email: dto.email ?? "",
    facebookGroupUrl: dto.facebookGroup ?? "",
    facebookPageUrl: dto.facebookPage ?? "",
  );
}

PromotionalMessageAdditionalButton _dtoToAdditionalButton(
  AdditionalButtonDto? dto,
) {
  if (dto == null) return PromotionalMessageAdditionalButton.empty();
  return PromotionalMessageAdditionalButton(
    showButton: dto.normalButton ?? false,
    buttonText: dto.normalButtonText ?? "",
    buttonUrl: dto.normalButtonLink ?? "",
    buttonIconUrl: dto.normalButtonIcon ?? "",
    buttonColor: getColorFromHex(
      dto.normalButtonColor,
    ),
  );
}

bool _determineIfShouldPublish(RemoteNoticeDto remoteNoticeDto) {
  // show notification box while in testing phase.
  final bool debugOnly = (remoteNoticeDto.publish?.debugOnly ?? false) && kDebugMode;
  if (debugOnly) return true;

  final bool shouldPublish = remoteNoticeDto.publish?.publish ?? false;
  if (!shouldPublish) return false;

  final bool shouldPublishInCurrentPlatform =
      Platform.isAndroid ? (remoteNoticeDto.platform?.android ?? false) : (remoteNoticeDto.platform?.ios ?? false);

  return shouldPublish && shouldPublishInCurrentPlatform;
}
