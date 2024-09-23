import 'package:quran_majeed/data/mappers/surah_mapper.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';

class SurahLocalDataSource {
  SurahLocalDataSource(this._quranDatabase);

  final QuranDatabase _quranDatabase;

  Future<List<SurahEntity>> getAllSurahs() async {
    List<SurahDatabaseTableData> surahsDto = await _quranDatabase.getAllSurahs();
    return surahsDto.toPageListEntity();
  }
}
