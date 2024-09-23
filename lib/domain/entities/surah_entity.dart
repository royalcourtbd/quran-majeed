import 'package:equatable/equatable.dart';

class SurahEntity extends Equatable {
  const SurahEntity({
    required this.serial,
    required this.totalAyah,
    required this.name,
    required this.nameEn,
    required this.meaning,
    required this.type,
    required this.nameBn,
    required this.meaningBn,
  });

  factory SurahEntity.empty() {
    return const SurahEntity(
      serial: -1,
      totalAyah: -1,
      name: "",
      nameBn: "",
      nameEn: "",
      meaning: "",
      meaningBn: "",
      type: "",
    );
  }

  final int serial;
  final int totalAyah;
  final String name;
  final String nameEn;
  final String meaning;
  final String type;
  final String nameBn;
  final String meaningBn;

  @override
  List<Object?> get props => [
        serial,
        totalAyah,
        name,
        nameEn,
        meaning,
        type,
        nameBn,
        meaningBn,
      ];

  SurahEntity removeDescription() {
    return SurahEntity(
      serial: serial,
      totalAyah: totalAyah,
      name: name,
      nameEn: nameEn,
      meaning: meaning,
      type: type,
      nameBn: nameBn,
      meaningBn: meaningBn,
    );
  }

  SurahEntity copyWith({
    int? serial,
    int? totalAyah,
    String? name,
    String? nameEn,
    String? meaning,
    String? type,
    String? nameBn,
    String? meaningBn,
  }) {
    return SurahEntity(
      serial: serial ?? this.serial,
      totalAyah: totalAyah ?? this.totalAyah,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      meaning: meaning ?? this.meaning,
      type: type ?? this.type,
      nameBn: nameBn ?? this.nameBn,
      meaningBn: meaningBn ?? this.meaningBn,
    );
  }
}
