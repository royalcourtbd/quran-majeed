import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class WordbyWordLocalDataSource {
  final QuranDatabase _database;

  WordbyWordLocalDataSource(this._database);

  Future<List<Map<String, dynamic>>> getWordsByWordForSurah(int surahNumber) async {
    final List<WordByWordDatabaseTableData> words = await _database.getWordsByWord(surahNumber);
    return words.map((word) => word.toJson()).toList();
  }

  Future<Map<String, List<dynamic>>> getWordsByWordForSpecificAyah(int surahNumber, int ayahNumber) async {
    final List<WordByWordDatabaseTableData> words =
        await _database.getWordsByWordForSpecificAyah(surahNumber, ayahNumber);
    final List<Map<String, dynamic>> wordsJson = words.map((word) => word.toJson()).toList();
    return {
      'words': wordsJson,
    };
  }

  Future<WbwJsonModel> loadWbwData() async {
    try {
      String jsonString = await rootBundle.loadString("assets/jsonFile/word_by_word.json");
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return WbwJsonModel.fromJson(jsonData);
    } catch (e) {
      throw Exception("Failed to load Word by Word data: $e");
    }
  }

  Future<void> deleteWbwDatabase({required WbwDbFileModel file}) async {
    final dbFile = File(await getDatabaseFilePath(file.name));
    if (await dbFile.exists()) {
      try {
        await dbFile.delete();
      } catch (e) {
        throw Exception("Error deleting Word by Word database: $e");
      }
    } else {
      throw Exception("Word by Word database file not found");
    }
  }
}
