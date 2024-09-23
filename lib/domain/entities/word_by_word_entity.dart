import 'package:equatable/equatable.dart';

class WordByWordEntity extends Equatable {
  final int? surah;
  final int? ayah;
  final int? word;
  final int? juz;
  final int? page;
  final String? hijb;
  final String? uthmani;
  final String? indopak;
  final String? en;
  final String? bn;
  final String? de;
  final String? indo;
  final String? audio;

  const WordByWordEntity({
    this.surah,
    this.ayah,
    this.word,
    this.juz,
    this.page,
    this.hijb,
    this.uthmani,
    this.indopak,
    this.en,
    this.bn,
    this.de,
    this.indo,
    this.audio,
  });

  @override
  List<Object?> get props => [
        surah,
        ayah,
        word,
        juz,
        page,
        hijb,
        uthmani,
        indopak,
        en,
        bn,
        de,
        indo,
        audio,
      ];
}