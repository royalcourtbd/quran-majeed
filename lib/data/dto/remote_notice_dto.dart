import 'package:quran_majeed/core/utility/trial_utility.dart';

class RemoteNoticeDto {
  RemoteNoticeDto(
      this.additionalButton,
      this.otherContacts,
      this.paymentBank,
      this.paymentMobile,
      this.platform,
      this.post,
      this.publish,
      this.socialMedia,
      );

  factory RemoteNoticeDto.fromJson(Map<String, dynamic> json) {
    AdditionalButtonDto? additionalButton;
    catchVoid(() {
      additionalButton = json.containsKey('additional_button') &&
          json['additional_button'] is Map<String, dynamic>
          ? AdditionalButtonDto.fromJson(
        json['additional_button'] as Map<String, dynamic>,
      )
          : null;
    });

    OtherContactsDto? otherContacts;
    catchVoid(() {
      otherContacts = json.containsKey('other_contacts') &&
          json['other_contacts'] is Map<String, dynamic>
          ? OtherContactsDto.fromJson(
        json['other_contacts'] as Map<String, dynamic>,
      )
          : null;
    });

    PaymentBankDto? paymentBank;
    catchVoid(() {
      paymentBank = json.containsKey('payment_bank') &&
          json['payment_bank'] is Map<String, dynamic>
          ? PaymentBankDto.fromJson(
        json['payment_bank'] as Map<String, dynamic>,
      )
          : null;
    });

    PaymenMobileDto? paymentMobile;
    catchVoid(() {
      paymentMobile = json.containsKey('payment_mobile') &&
          json['payment_mobile'] is Map<String, dynamic>
          ? PaymenMobileDto.fromJson(
        json['payment_mobile'] as Map<String, dynamic>,
      )
          : null;
    });

    PlatformDto? platform;
    catchVoid(() {
      platform = json.containsKey('platform') &&
          json['platform'] is Map<String, dynamic>
          ? PlatformDto.fromJson(json['platform'] as Map<String, dynamic>)
          : null;
    });

    PostDto? post;
    catchVoid(() {
      post = json.containsKey('post') && json['post'] is Map<String, dynamic>
          ? PostDto.fromJson(json['post'] as Map<String, dynamic>)
          : null;
    });

    PublishDto? publish;
    catchVoid(() {
      publish =
      json.containsKey('publish') && json['publish'] is Map<String, dynamic>
          ? PublishDto.fromJson(json['publish'] as Map<String, dynamic>)
          : null;
    });

    SocialMediaDto? socialMedia;
    catchVoid(() {
      socialMedia = json.containsKey('social_media') &&
          json['social_media'] is Map<String, dynamic>
          ? SocialMediaDto.fromJson(
        json['social_media'] as Map<String, dynamic>,
      )
          : null;
    });

    return RemoteNoticeDto(
      additionalButton,
      otherContacts,
      paymentBank,
      paymentMobile,
      platform,
      post,
      publish,
      socialMedia,
    );
  }

  final AdditionalButtonDto? additionalButton;
  final OtherContactsDto? otherContacts;
  final PaymentBankDto? paymentBank;
  final PaymenMobileDto? paymentMobile;
  final PlatformDto? platform;
  final PostDto? post;
  final PublishDto? publish;
  final SocialMediaDto? socialMedia;
}

class AdditionalButtonDto {
  AdditionalButtonDto({
    this.normalButton,
    this.normalButtonColor,
    this.normalButtonText,
    this.normalButtonIcon,
    this.normalButtonLink,
  });

  AdditionalButtonDto.fromJson(Map<String, dynamic> json) {
    normalButton = json['normal_button'] as bool?;
    normalButtonColor = json['normal_button_color'] as String?;
    normalButtonText = json['normal_button_text'] as String?;
    normalButtonIcon = json['normal_button_icon'] as String?;
    normalButtonLink = json['normal_button_link'] as String?;
  }

  bool? normalButton;
  String? normalButtonColor;
  String? normalButtonText;
  String? normalButtonIcon;
  String? normalButtonLink;
}

class OtherContactsDto {
  OtherContactsDto({this.facebookGroup, this.email, this.facebookPage});

  OtherContactsDto.fromJson(Map<String, dynamic> json) {
    facebookGroup = json['facebook_group'] as String?;
    email = json['email'] as String?;
    facebookPage = json['facebook_page'] as String?;
  }

  String? facebookGroup;
  String? email;
  String? facebookPage;
}

class PaymentBankDto {
  PaymentBankDto({
    this.branch,
    this.acName,
    this.acNumber,
    this.bankInfoShow,
    this.bankName,
    this.swiftcode,
    this.routing,
  });

  PaymentBankDto.fromJson(Map<String, dynamic> json) {
    branch = json['branch'] as String?;
    acName = json['ac_name'] as String?;
    acNumber = json['ac_number'] as String?;
    bankInfoShow = json['bank_info_show'] as bool?;
    bankName = json['bank_name'] as String?;
    swiftcode = json['swiftcode'] as String?;
    routing = json['routing'] as String?;
  }

  String? branch;
  String? acName;
  String? acNumber;
  bool? bankInfoShow;
  String? bankName;
  String? swiftcode;
  String? routing;
}

class PaymenMobileDto {
  PaymenMobileDto({
    this.upaySecondary,
    this.bkashSecondary,
    this.nagadPrimary,
    this.nagadSecondary,
    this.rocketSecondary,
    this.upayPrimary,
    this.rocketPrimary,
    this.bkashPrimary,
  });

  PaymenMobileDto.fromJson(Map<String, dynamic> json) {
    upaySecondary = json['upay_secondary'] as String?;
    bkashSecondary = json['bkash_secondary'] as String?;
    nagadPrimary = json['nagad_primary'] as String?;
    nagadSecondary = json['nagad_secondary'] as String?;
    rocketSecondary = json['rocket_secondary'] as String?;
    upayPrimary = json['upay_primary'] as String?;
    rocketPrimary = json['rocket_primary'] as String?;
    bkashPrimary = json['bkash_primary'] as String?;
  }

  String? upaySecondary;
  String? bkashSecondary;
  String? nagadPrimary;
  String? nagadSecondary;
  String? rocketSecondary;
  String? upayPrimary;
  String? rocketPrimary;
  String? bkashPrimary;
}

class PlatformDto {
  PlatformDto({this.android, this.ios});

  PlatformDto.fromJson(Map<String, dynamic> json) {
    android = json['android'] as bool?;
    ios = json['ios'] as bool?;
  }

  bool? android;
  bool? ios;
}

class PostDto {
  PostDto({
    this.subtitle,
    this.headerImageUrl,
    this.title,
    this.body,
    this.headerText,
    this.posterUrl,
  });

  PostDto.fromJson(Map<String, dynamic> json) {
    subtitle = json['subtitle'] as String?;
    headerImageUrl = json['header_image_url'] as String?;
    posterUrl = json['poster_url'] as String?;
    title = json['title'] as String?;
    body = json['body'] as String?;
    headerText = json['header_text'] as String?;
  }

  String? subtitle;
  String? headerImageUrl;
  String? title;
  String? body;
  String? headerText;
  String? posterUrl;
}

class PublishDto {
  PublishDto({this.id, this.publish});

  PublishDto.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    publish = json['publish'] as bool?;
    debugOnly = json['debug_only'] as bool?;
  }

  int? id;
  bool? publish;
  bool? debugOnly;
}

class SocialMediaDto {
  SocialMediaDto({
    this.messengerButtonTitle,
    this.facebookButtonUrl,
    this.telegramButtonUrl,
    this.whatsappButtonTitle,
    this.messengerButtonUrl,
    this.whatsappButtonUrl,
    this.facebookButtonTitle,
    this.telegramButtonTitle,
  });

  SocialMediaDto.fromJson(Map<String, dynamic> json) {
    messengerButtonTitle = json['messenger_button_title'] as String?;
    facebookButtonUrl = json['facebook_button_url'] as String?;
    telegramButtonUrl = json['telegram_button_url'] as String?;
    whatsappButtonTitle = json['whatsapp_button_title'] as String?;
    messengerButtonUrl = json['messenger_button_url'] as String?;
    whatsappButtonUrl = json['whatsapp_button_url'] as String?;
    facebookButtonTitle = json['facebook_button_title'] as String?;
    telegramButtonTitle = json['telegram_button_title'] as String?;
  }

  String? messengerButtonTitle;
  String? facebookButtonUrl;
  String? telegramButtonUrl;
  String? whatsappButtonTitle;
  String? messengerButtonUrl;
  String? whatsappButtonUrl;
  String? facebookButtonTitle;
  String? telegramButtonTitle;
}
