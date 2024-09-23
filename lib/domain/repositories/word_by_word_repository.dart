import 'package:dio/dio.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';

abstract class WordByWordRepository {
  Future<List<WordByWordEntity>> getWordsForSurah(int surahNumber);
  Future<void> preloadAdjacentSurahs(int currentSurah);
  Future<List<WordByWordEntity>> getWordsForSpecificAyah(int surahNumber, int ayahNumber);
   Future<WbwJsonModel> getAvailableWbwLanguages();
  Future<List<String>> getDownloadedWbwLanguages();
  Future<void> downloadWbwLanguage(
    WbwDbFileModel wbwFile,
    void Function(int) onProgress,
    CancelToken cancelToken,
  );
  Future<void> deleteWbwLanguage(WbwDbFileModel file);
  Future<void> setSelectedWbwLanguage(String fileName);
  Future<String> getSelectedWbwLanguage();
}
