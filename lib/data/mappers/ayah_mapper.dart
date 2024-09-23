import 'package:quran_majeed/core/utility/text_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/ayah_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

extension DtoToAyahMapper on List<AyahDatabaseTableData> {
  Future<List<AyahEntity>> toAyahEntity() async {
    final List<AyahDatabaseTableData> dtoList = this;
    final List<AyahEntity> ayahEntityList = await compute(_convertAyahFtsToAyahEntity, dtoList);
    return ayahEntityList;
  }
}

List<AyahEntity> _convertAyahFtsToAyahEntity(List<AyahDatabaseTableData> dtoList) =>
    dtoList.map(_convertDtoToAyahEntity).toList();

AyahEntity _convertDtoToAyahEntity(AyahDatabaseTableData ayahDto) {
  return AyahEntity(
    id: ayahDto.id,
    surahID: ayahDto.surahId!,
    ayahID: ayahDto.ayahID!,
    juz: ayahDto.juz,
    hijb: ayahDto.hijb,
    page: ayahDto.page,
    clean: ayahDto.clean,
    qcf: ayahDto.qcf,
    fonts: ayahDto.fonts,
    tafsirKathir: ayahDto.tafsirKathir,
    tafsirFmazid: ayahDto.tafsirFmazid,
    tafsirKathirMujibor: ayahDto.tafsirKathirMujibor,
  );
}

Future<String> convertAyahToSharableString({
  required int surahID,
  required int ayahID,
  required List<WordByWordEntity> listOfWordByWordEntity,
  required String surahName,
  required List<String> translatorName,
  required List<String> translation,
  required bool shareWithArabicText,
  required bool shareWithTranslation,
}) async {
  final String shareableString = await compute(
    _convertAyahToShareableString,
    (
      surahID,
      ayahID,
      listOfWordByWordEntity,
      surahName,
      translatorName,
      translation,
      shareWithArabicText,
      shareWithTranslation
    ),
  );
  return shareableString;
}

Future<String> _convertAyahToShareableString(
  (int, int, List<WordByWordEntity>, String, List<String>, List<String>, bool, bool) param,
) async {
  final (
    surahID,
    ayahID,
    listOfWordByWordEntity,
    surahName,
    translatorName,
    translation,
    shareWithArabicText,
    shareWithTranslation
  ) = param;
  final StringBuffer shareableString = StringBuffer();

  const String invisibleText = "‎";

  shareableString.write(invisibleText);

  if (shareWithArabicText) {
    final String arabicText = listOfWordByWordEntity.map((wordByWordEntity) => wordByWordEntity.uthmani).join(" ");
    shareableString.write(arabicText);
  }
  if (shareWithTranslation) {
    for (int i = 0; i < translation.length; i++) {
      shareableString.write("\n\n");
      shareableString.write("${translatorName[i]}\n\n");
      shareableString.write(translation[i]);
    }
  }
  shareableString.write("\n\n");
  shareableString.write("$surahName - Ayah $ayahID\n");
  const String dueCredit = "\nSource: Quran Majeed App, IRD Foundation";
  shareableString.write(dueCredit);

  return removeHtml(shareableString.toString());
}
