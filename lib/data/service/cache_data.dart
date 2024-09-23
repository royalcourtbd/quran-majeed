import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/database/word_by_word/word_by_word_database.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';

class CacheData {
  static Map<int, String> uniquePageIDwithSurahAndAyahID = {};
  static List<SurahEntity> surahsCache = [];
  static List<String> allSurahsName = [];
  static Map<String, Map<int, Map<int, String>>> translationList = {};
    static Map<String, Map<int, Map<int, List<WordByWordTableData>>>> wordByWordCache = {};

  static Map<String, Map<int, Map<int, String>>> tafseerCache = {};
  static Map<int, AudioFile> audioFiles = {};
  static Map<String, List<VerseTiming>> verseTimings = {};
}
