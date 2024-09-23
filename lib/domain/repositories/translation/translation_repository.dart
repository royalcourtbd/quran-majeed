import 'package:dio/dio.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';

abstract class TranslationRepository {
  Future<void> getNonDefaultTranslation({required TTDbFileModel file,  void Function(int percentage)? onProgress, required CancelToken cancelToken,});
  Future<void> getDefaultTranslation(TTDbFileModel file);
  Future<void> deleteTranslationDatabase({required String fileName});
  Future<List<String>> getAvailableTranslations();
  Future<void> saveAvailableTranslations({required Set<String> availableTranslations, required String newItem});
  Future<void> selectTranslation({required TTDbFileModel file});
  Future<void> deleteAvailableTranslation({required TTDbFileModel file});
  Future<Set<String>> getSelectedTranslations();
  Future<void> saveSelectedTranslations(Set<String> selectedTranslations);
   Future<void> saveAvailableItemsCount(int count);
   Future<int> fetchAvailableItemsCount(); 
}
