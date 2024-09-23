import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/translation_entity.dart';

class TranslationLocalDataSource {
  TranslationLocalDataSource(this._quranDatabase);

  final QuranDatabase _quranDatabase;

  Future<List<TranslationEntity>> getDefaultTranslationData({required String language}) async {
    List<TranslationEntity> ayahFtsData = await _quranDatabase.getFullTranslationData(language: language);
    return ayahFtsData;
  }
}
