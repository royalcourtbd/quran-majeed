import 'dart:ui';

import 'package:equatable/equatable.dart';

class PromotionalMessageEntity extends Equatable {
  const PromotionalMessageEntity({
    required this.id,
    required this.publish,
    required this.additionalButton,
    required this.otherContacts,
    required this.paymentBank,
    required this.paymentMobile,
    required this.post,
    required this.socialMedia,
    required this.blogId,
    required this.headerText,
  });

  factory PromotionalMessageEntity.empty() => PromotionalMessageEntity(
    id: -1,
    publish: false,
    additionalButton: PromotionalMessageAdditionalButton.empty(),
    otherContacts: PromotionalMessageOtherContacts.empty(),
    paymentBank: PromotionalMessagePaymentBank.empty(),
    paymentMobile: PromotionalMessagePaymentMobile.empty(),
    post: PromotionalMessagePost.empty(),
    socialMedia: PromotionalMessageSocialMedia.empty(),
    blogId: -1,
    headerText: '',
  );

  final int id;
  final bool publish;
  final PromotionalMessageAdditionalButton additionalButton;
  final PromotionalMessageOtherContacts otherContacts;
  final PromotionalMessagePaymentBank paymentBank;
  final PromotionalMessagePaymentMobile paymentMobile;
  final PromotionalMessagePost post;
  final PromotionalMessageSocialMedia socialMedia;
  final int blogId;
  final String headerText;

  bool get isBlog => blogId != -1;

  @override
  List<Object?> get props => [
    id,
    publish,
    additionalButton,
    otherContacts,
    paymentBank,
    paymentMobile,
    post,
    socialMedia,
    blogId,
    headerText,
  ];
}

class PromotionalMessageAdditionalButton extends Equatable {
  const PromotionalMessageAdditionalButton({
    required this.showButton,
    required this.buttonColor,
    required this.buttonIconUrl,
    required this.buttonUrl,
    required this.buttonText,
  });

  factory PromotionalMessageAdditionalButton.empty() =>
      const PromotionalMessageAdditionalButton(
        showButton: false,
        buttonColor: Color(0xFF000000),
        buttonIconUrl: '',
        buttonUrl: '',
        buttonText: '',
      );

  final bool showButton;
  final Color buttonColor;
  final String buttonIconUrl;
  final String buttonUrl;
  final String buttonText;

  @override
  List<Object?> get props => [
    showButton,
    buttonColor,
    buttonIconUrl,
    buttonUrl,
    buttonText,
  ];
}

class PromotionalMessageOtherContacts extends Equatable {
  const PromotionalMessageOtherContacts({
    required this.email,
    required this.facebookGroupUrl,
    required this.facebookPageUrl,
  });

  factory PromotionalMessageOtherContacts.empty() =>
      const PromotionalMessageOtherContacts(
        email: '',
        facebookGroupUrl: '',
        facebookPageUrl: '',
      );

  final String email;
  final String facebookGroupUrl;
  final String facebookPageUrl;

  @override
  List<Object?> get props => [
    email,
    facebookGroupUrl,
    facebookPageUrl,
  ];
}

class PromotionalMessagePaymentBank extends Equatable {
  const PromotionalMessagePaymentBank({
    required this.accountName,
    required this.accountNumber,
    required this.showBankInfo,
    required this.bankName,
    required this.bankBranch,
    required this.routingNumber,
    required this.swiftCode,
  });

  factory PromotionalMessagePaymentBank.empty() =>
      const PromotionalMessagePaymentBank(
        accountName: '',
        accountNumber: '',
        showBankInfo: false,
        bankName: '',
        bankBranch: '',
        routingNumber: '',
        swiftCode: '',
      );

  final String accountName;
  final String accountNumber;
  final bool showBankInfo;
  final String bankName;
  final String bankBranch;
  final String routingNumber;
  final String swiftCode;

  @override
  List<Object?> get props => [
    accountName,
    accountNumber,
    showBankInfo,
    bankName,
    bankBranch,
    routingNumber,
    swiftCode,
  ];
}

class PromotionalMessagePaymentMobile extends Equatable {
  const PromotionalMessagePaymentMobile({
    required this.bKashPrimary,
    required this.bKashSecondary,
    required this.nagadPrimary,
    required this.nagadSecondary,
    required this.rocketPrimary,
    required this.rocketSecondary,
    required this.uPayPrimary,
    required this.uPaySecondary,
  });

  factory PromotionalMessagePaymentMobile.empty() =>
      const PromotionalMessagePaymentMobile(
        bKashPrimary: '',
        bKashSecondary: '',
        nagadPrimary: '',
        nagadSecondary: '',
        rocketPrimary: '',
        rocketSecondary: '',
        uPayPrimary: '',
        uPaySecondary: '',
      );

  final String bKashPrimary;
  final String bKashSecondary;
  final String nagadPrimary;
  final String nagadSecondary;
  final String rocketPrimary;
  final String rocketSecondary;
  final String uPayPrimary;
  final String uPaySecondary;

  @override
  List<Object?> get props => [
    bKashPrimary,
    bKashSecondary,
    nagadPrimary,
    nagadSecondary,
    rocketPrimary,
    rocketSecondary,
    uPayPrimary,
    uPaySecondary,
  ];
}

class PromotionalMessagePost extends Equatable {
  const PromotionalMessagePost({
    required this.body,
    required this.headerImageUrl,
    required this.subtitle,
    required this.title,
    required this.posterUrl,
  });

  factory PromotionalMessagePost.empty() => const PromotionalMessagePost(
    body: '',
    headerImageUrl: '',
    subtitle: '',
    title: '',
    posterUrl: '',
  );

  final String body;
  final String headerImageUrl;
  final String subtitle;
  final String title;
  final String posterUrl;

  @override
  List<Object?> get props => [
    body,
    headerImageUrl,
    posterUrl,
    subtitle,
    title,
  ];
}

class PromotionalMessageSocialMedia extends Equatable {
  const PromotionalMessageSocialMedia({
    required this.facebookButtonTitle,
    required this.facebookButtonUrl,
    required this.messengerButtonTitle,
    required this.messengerButtonUrl,
    required this.telegramButtonTitle,
    required this.telegramButtonUrl,
    required this.whatsappButtonTitle,
    required this.whatsappButtonUrl,
  });

  factory PromotionalMessageSocialMedia.empty() =>
      const PromotionalMessageSocialMedia(
        facebookButtonTitle: '',
        facebookButtonUrl: '',
        messengerButtonTitle: '',
        messengerButtonUrl: '',
        telegramButtonTitle: '',
        telegramButtonUrl: '',
        whatsappButtonTitle: '',
        whatsappButtonUrl: '',
      );

  final String facebookButtonTitle;
  final String facebookButtonUrl;
  final String messengerButtonTitle;
  final String messengerButtonUrl;
  final String telegramButtonTitle;
  final String telegramButtonUrl;
  final String whatsappButtonTitle;
  final String whatsappButtonUrl;

  @override
  List<Object?> get props => [
    facebookButtonTitle,
    facebookButtonUrl,
    messengerButtonTitle,
    messengerButtonUrl,
    telegramButtonTitle,
    telegramButtonUrl,
    whatsappButtonTitle,
    whatsappButtonUrl,
  ];
}
