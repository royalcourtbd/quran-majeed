import 'package:equatable/equatable.dart';

class TranslationEntity extends Equatable {
  const TranslationEntity({
    this.surah,
    this.ayah,
    this.translation,
  });

  factory TranslationEntity.empty() {
    return const TranslationEntity(
      surah: -1,
      ayah: -1,
      translation: "",
    );
  }

  final int? surah;
  final int? ayah;
  final String? translation;


  @override
  List<Object?> get props => [
    surah,
    ayah,
    translation,
  ];


  TranslationEntity copyWith({
    int? surah,
    int? ayah,
    String? translation,
  }) {
    return TranslationEntity(
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      translation: translation ?? this.translation,
    );
  }
}
