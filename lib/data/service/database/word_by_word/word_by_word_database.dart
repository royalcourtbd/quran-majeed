import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:quran_majeed/data/service/database/word_by_word/word_by_word_table.dart';

part 'word_by_word_database.g.dart';

@DriftDatabase(tables: [WordByWordTable])
class WordByWordDatabase extends _$WordByWordDatabase {
  WordByWordDatabase(File dbFile) : super(NativeDatabase(dbFile));

  @override
  int get schemaVersion => 1;

  Future<List<WordByWordTableData>> getWordByWordFromDB() async {
    return (select(wordByWordTable)).get();
  }
}
