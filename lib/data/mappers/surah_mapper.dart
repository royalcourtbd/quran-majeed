import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';

extension DtoToSurahListMapper on List<SurahDatabaseTableData> {
  Future<List<SurahEntity>> toPageListEntity() async {
    final List<SurahDatabaseTableData> dtoList = this;
    final List<SurahEntity> surahList = await compute(_convertSurahDtoToSurahEntity, dtoList);
    return surahList;
  }
}

List<SurahEntity> _convertSurahDtoToSurahEntity(List<SurahDatabaseTableData> dtoList) =>
    dtoList.map(_convertDtoToSurahEntity).toList();

SurahEntity _convertDtoToSurahEntity(SurahDatabaseTableData surahDto) {
  return SurahEntity(
      serial: surahDto.serial,
      name: surahDto.name,
      nameBn: surahDto.nameBn,
      meaning: surahDto.meaning,
      totalAyah: surahDto.totalAyah,
      nameEn: surahDto.nameEn,
      meaningBn: surahDto.meaningBn,
      type: surahDto.type);
}
