import 'package:quran_majeed/data/data_sources/local_data_source/translation/i_translation_and_tafseer_local_data_source.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/translation/i_translation_and_tafseer_repository.dart';

class TranslationAndTafseerRepository implements ITranslationAndTafseerRepository {
  final ITranslationAndTafseerLocalDataSource localDataSource;

  TranslationAndTafseerRepository(this.localDataSource);

  @override
  Future<TTJsonModel> getTranslationAndTafseer() async {
    return await localDataSource.loadTranslationAndTafseerData();
  }
}
