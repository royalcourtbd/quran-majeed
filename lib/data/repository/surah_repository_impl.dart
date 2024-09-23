import 'package:quran_majeed/data/data_sources/local_data_source/surah_local_data_source.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/domain/repositories/surah_repository.dart';

class SurahRepositoryImpl extends SurahRepository {
  SurahRepositoryImpl(this._surahLocalDataSource);

   final SurahLocalDataSource _surahLocalDataSource;

  @override
  Future<void> getAllSurahList() async {
    // we are caching the surahs 
    // in the memory, as we may need to access
    // them again and again in a short period of time. Keeping them in the
    // memory will reduce the reading time delay
    if (CacheData.surahsCache.isEmpty) {
      final List<SurahEntity> allBooks =
      await _surahLocalDataSource.getAllSurahs();
      CacheData.surahsCache = allBooks;
      CacheData.allSurahsName = allBooks.map((e) => e.name).toList();
    }
  }
  
}