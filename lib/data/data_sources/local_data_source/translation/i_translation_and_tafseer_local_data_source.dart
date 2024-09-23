import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';

abstract class ITranslationAndTafseerLocalDataSource {
  Future<TTJsonModel> loadTranslationAndTafseerData();
}
