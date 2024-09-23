import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/translation/i_translation_and_tafseer_local_data_source.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';

class TranslationAndTafseerLocalDataSource implements ITranslationAndTafseerLocalDataSource {
  @override
  Future<TTJsonModel> loadTranslationAndTafseerData() async {
    String jsonString = await rootBundle.loadString("assets/jsonFile/trans_tafseer.json");
    final result = TTJsonModel.fromJson(jsonDecode(jsonString));
    return result;
  }
}
