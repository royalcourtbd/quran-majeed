import 'package:equatable/equatable.dart';

class SubjectWiseEnEntity extends Equatable {
  const SubjectWiseEnEntity({
    required this.id,
    required this.title,
    required this.surahAyat,
  });

  factory SubjectWiseEnEntity.empty() {
    return const SubjectWiseEnEntity(
      id: -1,
      title: "",
      surahAyat: "",
    );
  }

  final int id;
  final String title;
  final String surahAyat;

  @override
  List<Object?> get props => [
        id,
        title,
        surahAyat,
      ];

  SubjectWiseEnEntity removeDescription() {
    return SubjectWiseEnEntity(
      id: id,
      title: title,
      surahAyat: surahAyat,
    );
  }

  SubjectWiseEnEntity copyWith({
   int? id,
    String? title,
    String? surahAyat,
  }) {
    return SubjectWiseEnEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      surahAyat: surahAyat ?? this.surahAyat,
    );
  }
}
