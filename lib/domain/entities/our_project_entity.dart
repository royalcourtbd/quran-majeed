import 'package:equatable/equatable.dart';

class OurProjectEntity extends Equatable {
  const OurProjectEntity({
    required this.id,
    required this.banglaName,
    required this.englishName,
    required this.icon,
    required this.banglaDescription,
    required this.englishDescription,
    this.appStoreLink,
    required this.websiteLink,
    this.playStoreLink,
    required this.actionMessage,
    this.type = OurProjectType.app,
  });

  final int id;
  final String banglaName;
  final String englishName;
  final String icon;
  final String banglaDescription;
  final String englishDescription;
  final String websiteLink;
  final String? appStoreLink;
  final String? playStoreLink;
  final String actionMessage;
  final OurProjectType type;

  @override
  List<Object?> get props => [
        id,
        banglaName,
        englishName,
        icon,
        banglaDescription,
        englishDescription,
        appStoreLink,
        websiteLink,
        playStoreLink,
        actionMessage,
        type,
      ];
}

enum OurProjectType {
  app,
  website,
}
