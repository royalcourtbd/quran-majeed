import 'dart:convert';

import 'package:quran_majeed/data/service/cache_data.dart';

List<MemorizationEntity> memorizationEntityFromJson(String str) =>
    List<MemorizationEntity>.from(
        json.decode(str).map((x) => MemorizationEntity.fromJson(x)));

String memorizationEntityToJson(List<MemorizationEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemorizationEntity {
  String? id;
  String? planName;
  int? startSurah;
  int? startAyah;
  int? endSurah;
  int? endAyah;
  int? estimatedDay;
  bool? notification;
  String? notificationTime;

  MemorizationEntity({
    this.id,
    this.startSurah,
    this.planName,
    this.startAyah,
    this.endSurah,
    this.endAyah,
    this.estimatedDay,
    this.notification,
    this.notificationTime,
  });

  factory MemorizationEntity.fromJson(Map<String, dynamic> json) =>
      MemorizationEntity(
        id: json["id"],
        planName: json["planName"],
        startSurah: json["startSurah"],
        startAyah: json["startAyah"],
        endSurah: json["endSurah"],
        endAyah: json["endAyah"],
        estimatedDay: json["estimatedDay"],
        notification: json["notification"],
        notificationTime: json["notificationTime"],
      );

  totalSurah() {
    final surah = (endSurah ?? 0) - (startSurah ?? 0) + 1;
    return surah;
  }

  remainingDay() {
    final createdDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(id!));
    final diff = DateTime.now().difference(createdDate);
    final getRemaingDays = ((estimatedDay ?? 0) - diff.inDays);

    return getRemaingDays.isNegative ? 0 : getRemaingDays;
  }

  totalAyah() {
    final cachedSurah = CacheData.surahsCache;
    int totalAyah = 0;

    for (int i = 0; i < totalSurah(); i++) {
      totalAyah += cachedSurah[((startSurah ?? 0) - 1) + i].totalAyah;
    }
    totalAyah = totalAyah - ((startAyah ?? 0) - 1);
    totalAyah = totalAyah -
        (cachedSurah[((endSurah ?? 0) - 1)].totalAyah - (endAyah ?? 0));

    return totalAyah;
  }

  Map<String, dynamic> toJson() {
    final dateTimeId = DateTime.now().microsecondsSinceEpoch.toString();
    return {
      "id": dateTimeId,
      "startSurah": startSurah,
      "startAyah": startAyah,
      "endSurah": endSurah,
      "endAyah": endAyah,
      "estimatedDay": estimatedDay,
      "notification": notification,
      "notificationTime": notificationTime,
      "planName": planName,
    };
  }

  MemorizationEntity copyWith(
      {int? startSurah,
      int? startAyah,
      int? endSurah,
      int? endAyah,
      int? estimatedDay,
      bool? notification,
      String? notificationTime,
      String? planName}) {
    return MemorizationEntity(
      startAyah: startAyah ?? this.startAyah,
      startSurah: startSurah ?? this.startSurah,
      endAyah: endAyah ?? this.endAyah,
      endSurah: endSurah ?? this.endSurah,
      estimatedDay: estimatedDay ?? this.estimatedDay,
      notification: notification ?? this.notification,
      notificationTime: notificationTime ?? this.notificationTime,
      planName: planName ?? this.planName,
    );
  }
}
