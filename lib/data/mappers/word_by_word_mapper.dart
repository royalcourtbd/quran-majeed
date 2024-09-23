import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

extension DtoToWordByWordListMapper on List<WordByWordDatabaseTableData> {
  Future<List<WordByWordEntity>> toWordByWordListEntity() async {
    final List<WordByWordDatabaseTableData> dtoList = this;
    final List<WordByWordEntity> wordByWordList = await compute(_convertWordByWordDtoToWordByWordEntity, dtoList);
    return wordByWordList;
  }
}

extension DtoToWordByWordMapper on WordByWordDatabaseTableData {
  WordByWordEntity toWordByWordEntity() {
    final WordByWordDatabaseTableData wordByWordDto = this;
    return _convertDtoToWordByWordEntity(wordByWordDto);
  }
}

List<WordByWordEntity> _convertWordByWordDtoToWordByWordEntity(List<WordByWordDatabaseTableData> dtoList) =>
    dtoList.map(_convertDtoToWordByWordEntity).toList();

WordByWordEntity _convertDtoToWordByWordEntity(WordByWordDatabaseTableData wordByWordDto) {
  return WordByWordEntity(
    surah: wordByWordDto.surah,
    ayah: wordByWordDto.ayah,
    word: wordByWordDto.word,
    juz: wordByWordDto.juz,
    page: wordByWordDto.page,
    hijb: wordByWordDto.hijb,
    uthmani: wordByWordDto.uthmani,
    indopak: wordByWordDto.indopak,
    en: wordByWordDto.en,
    bn: wordByWordDto.bn,
    audio: wordByWordDto.audio,
  );
}
