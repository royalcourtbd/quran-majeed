import 'package:equatable/equatable.dart';

class AyahEntity extends Equatable {
  const AyahEntity({
    required this.id,
    required this.surahID,
    required this.ayahID,
    required this.juz,
    required this.hijb,
    required this.page,
    required this.clean,
    required this.qcf,
    required this.fonts,
    required this.tafsirKathir,
    required this.tafsirFmazid,
    required this.tafsirKathirMujibor,
    this.isBookmark,
    this.isMultiBookmark,
  });

  factory AyahEntity.empty() {
    return const AyahEntity(
      id: -1,
      surahID: -1,
      ayahID: -1,
      juz: -1,
      hijb: '',
      page: -1,
      clean: '',
      qcf: '',
      fonts: '',
      tafsirKathir: -1,
      tafsirFmazid: -1,
      tafsirKathirMujibor: -1,
      isBookmark: false,
      isMultiBookmark: false,
    );
  }

  final int id;
  final int surahID;
  final int ayahID;
  final int? juz;
  final String? hijb;
  final int? page;
  final String? clean;
  final String? qcf;
  final String? fonts;
  final int? tafsirKathir;
  final int? tafsirFmazid;
  final int? tafsirKathirMujibor;
  final bool? isBookmark;
  final bool? isMultiBookmark;

  @override
  List<Object?> get props => [
        id,
        surahID,
        ayahID,
        juz,
        hijb,
        page,
        clean,
        qcf,
        fonts,
        tafsirKathir,
        tafsirFmazid,
        tafsirKathirMujibor,
        isBookmark,
        isMultiBookmark,
      ];

  AyahEntity removeDescription() {
    return AyahEntity(
      id: id,
      surahID: surahID,
      ayahID: ayahID,
      juz: juz,
      hijb: hijb,
      page: page,
      clean: clean,
      qcf: qcf,
      fonts: fonts,
      tafsirKathir: tafsirKathir,
      tafsirFmazid: tafsirFmazid,
      tafsirKathirMujibor: tafsirKathirMujibor,
      isBookmark: isBookmark,
      isMultiBookmark: isMultiBookmark,
    );
  }

  AyahEntity copyWith({
    int? id,
    int? surahID,
    int? ayahID,
    int? juz,
    String? hijb,
    int? page,
    String? clean,
    String? qcf,
    String? fonts,
    int? tafsirKathir,
    int? tafsirFmazid,
    int? tafsirKathirMujibor,
    String? uthmani,
    String? indopak,
    bool? isBookmark,
    bool? isMultiBookmark,
  }) {
    return AyahEntity(
      id: id ?? this.id,
      surahID: surahID ?? this.surahID,
      ayahID: ayahID ?? this.ayahID,
      juz: juz ?? this.juz,
      hijb: hijb ?? this.hijb,
      page: page ?? this.page,
      clean: clean ?? this.clean,
      qcf: qcf ?? this.qcf,
      fonts: fonts ?? this.fonts,
      tafsirKathir: tafsirKathir ?? this.tafsirKathir,
      tafsirFmazid: tafsirFmazid ?? this.tafsirFmazid,
      tafsirKathirMujibor: tafsirKathirMujibor ?? this.tafsirKathirMujibor,
      isBookmark: isBookmark ?? this.isBookmark,
      isMultiBookmark: isMultiBookmark ?? this.isMultiBookmark,
    );
  }
}
