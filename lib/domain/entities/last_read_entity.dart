import 'package:equatable/equatable.dart';
import 'dart:convert';

List<LastReadEntity> mLastReadFromJson(String str) => List<LastReadEntity>.from(
    json.decode(str).map((x) => LastReadEntity.fromJson(x)));

String mLastReadToJson(List<LastReadEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LastReadEntity extends Equatable {
  const LastReadEntity({
    required this.ayahIndex,
    required this.surahIndex,
    required this.surahName,
  });

  final String surahName;
  final int ayahIndex;
  final int surahIndex;

  @override
  List<Object?> get props => [
        surahIndex,
        ayahIndex,
        surahName,
      ];
  factory LastReadEntity.fromJson(Map<String, dynamic> json) => LastReadEntity(
        surahName: json["surahName"],
        ayahIndex: json["ayahIndex"],
        surahIndex: json["surahIndex"],
      );
  LastReadEntity copyWith({
    required String surahName,
    required int ayahIndex,
    required int surahIndex,
  }) {
    return LastReadEntity(
      surahIndex: surahIndex,
      surahName: surahName,
      ayahIndex: ayahIndex,
    );
  }

  Map<String, dynamic> toJson() => {
        "surahName": surahName,
        "surahIndex": surahIndex,
        "ayahIndex": ayahIndex,
      };
}
