import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NotificationPayLoadEntity extends Equatable {
  const NotificationPayLoadEntity({
    required this.bKashSecondary,
    required this.uPayPrimary,
    required this.rocketPrimary,
    required this.rocketSecondary,
    required this.uPaySecondary,
    required this.nagadPrimary,
    required this.bKashPrimary,
    required this.nagadSecondary,
    required this.normalButtonColor,
    required this.normalButton,
    required this.normalButtonText,
    required this.normalButtonLink,
    required this.normalButtonIcon,
    required this.facebookGroupUrl,
    required this.facebookPageUrl,
    required this.email,
    required this.subtitle,
    required this.title,
    required this.body,
    required this.headerImageUrl,
    required this.publish,
    required this.icon,
    required this.routing,
    required this.acName,
    required this.swiftCode,
    required this.bankName,
    required this.bankInfoShow,
    required this.acNumber,
    required this.branch,
    required this.messengerButtonTitle,
    required this.whatsappButtonTitle,
    required this.facebookButtonTitle,
    required this.messengerButtonUrl,
    required this.facebookButtonUrl,
    required this.whatsappButtonUrl,
    required this.telegramButtonTitle,
    required this.isAyah,
    required this.surahID,
    required this.ayahID,
    required this.telegramButtonUrl,
    required this.link,
    required this.openInBrowser,
    required this.blogId,
    required this.linkButtonText,
    required this.headerText,
    required this.posterUrl,
  });

  factory NotificationPayLoadEntity.empty() {
    return const NotificationPayLoadEntity(
      bKashSecondary: '',
      uPayPrimary: '',
      rocketPrimary: '',
      rocketSecondary: '',
      uPaySecondary: '',
      nagadPrimary: '',
      bKashPrimary: '',
      nagadSecondary: '',
      normalButtonColor: Colors.transparent,
      normalButton: false,
      normalButtonText: '',
      normalButtonLink: '',
      normalButtonIcon: '',
      facebookGroupUrl: '',
      facebookPageUrl: '',
      email: '',
      subtitle: '',
      title: '',
      body: '',
      headerImageUrl: '',
      publish: false,
      icon: '',
      routing: '',
      acName: '',
      swiftCode: '',
      bankName: '',
      bankInfoShow: false,
      acNumber: '',
      branch: '',
      messengerButtonTitle: '',
      whatsappButtonTitle: '',
      facebookButtonTitle: '',
      messengerButtonUrl: '',
      facebookButtonUrl: '',
      whatsappButtonUrl: '',
      telegramButtonTitle: '',
      telegramButtonUrl: '',
      ayahID: 1,
      surahID: 1,
      isAyah: false,
      link: '',
      openInBrowser: false,
      linkButtonText: "",
      blogId: -1,
      headerText: "",
      posterUrl: "",
    );
  }

  factory NotificationPayLoadEntity.forAyah({
    required int surahID,
    required int ayahID,
    required String notificationTitle,
    required String translation,
  }) {
    return NotificationPayLoadEntity(
      bKashSecondary: '',
      uPayPrimary: '',
      rocketPrimary: '',
      rocketSecondary: '',
      uPaySecondary: '',
      nagadPrimary: '',
      bKashPrimary: '',
      nagadSecondary: '',
      normalButtonColor: Colors.transparent,
      normalButton: false,
      normalButtonText: '',
      normalButtonLink: '',
      normalButtonIcon: '',
      facebookGroupUrl: '',
      facebookPageUrl: '',
      email: '',
      subtitle: '',
      title: notificationTitle,
      body: translation,
      headerImageUrl: '',
      publish: false,
      icon: '',
      routing: '',
      acName: '',
      swiftCode: '',
      bankName: '',
      bankInfoShow: false,
      acNumber: '',
      branch: '',
      messengerButtonTitle: '',
      whatsappButtonTitle: '',
      facebookButtonTitle: '',
      messengerButtonUrl: '',
      facebookButtonUrl: '',
      whatsappButtonUrl: '',
      telegramButtonTitle: '',
      telegramButtonUrl: '',
      surahID: surahID,
      ayahID: ayahID,
      isAyah: true,
      link: '',
      openInBrowser: false,
      linkButtonText: "",
      blogId: -1,
      headerText: "",
      posterUrl: "",
    );
  }

  final String bKashSecondary;
  final String uPayPrimary;
  final String rocketPrimary;
  final String rocketSecondary;
  final String uPaySecondary;
  final String nagadPrimary;
  final String bKashPrimary;
  final String nagadSecondary;
  final Color normalButtonColor;
  final bool normalButton;
  final String normalButtonText;
  final String normalButtonLink;
  final String normalButtonIcon;
  final String facebookGroupUrl;
  final String facebookPageUrl;
  final String email;
  final String subtitle;
  final String title;
  final String body;
  final String headerImageUrl;
  final bool publish;
  final String icon;
  final String posterUrl;
  final String routing;
  final String acName;
  final String swiftCode;
  final String bankName;
  final bool bankInfoShow;
  final String acNumber;
  final String branch;
  final String messengerButtonTitle;
  final String whatsappButtonTitle;
  final String facebookButtonTitle;
  final String messengerButtonUrl;
  final String facebookButtonUrl;
  final String whatsappButtonUrl;
  final String telegramButtonTitle;
  final String telegramButtonUrl;
  final int surahID;
  final int ayahID;
  final bool isAyah;
  final String link;
  final String linkButtonText;
  final bool openInBrowser;
  final int blogId;
  final String headerText;

  @override
  List<Object?> get props => [
        bKashSecondary,
        uPayPrimary,
        rocketPrimary,
        rocketSecondary,
        uPaySecondary,
        nagadPrimary,
        bKashPrimary,
        nagadSecondary,
        normalButtonColor,
        normalButton,
        normalButtonText,
        normalButtonLink,
        normalButtonIcon,
        facebookGroupUrl,
        facebookPageUrl,
        email,
        subtitle,
        title,
        body,
        headerImageUrl,
        publish,
        icon,
        blogId,
        routing,
        acName,
        swiftCode,
        bankName,
        bankInfoShow,
        acNumber,
        branch,
        headerText,
        messengerButtonTitle,
        whatsappButtonTitle,
        facebookButtonTitle,
        messengerButtonUrl,
        facebookButtonUrl,
        whatsappButtonUrl,
        telegramButtonTitle,
        openInBrowser,
        telegramButtonUrl,
        ayahID,
        isAyah,
        link,
        posterUrl,
      ];
}
