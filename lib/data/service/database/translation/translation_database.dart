import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:quran_majeed/data/service/database/translation/verses.dart';
import 'package:quran_majeed/domain/entities/translation_entity.dart';

part 'translation_database.g.dart'; // The filename for the generated code will be my_database.g.dart

@DriftDatabase(tables: [Verses])
class TranslationDatabase extends _$TranslationDatabase {
  TranslationDatabase(File dbFile) : super(NativeDatabase(dbFile));

  @override
  int get schemaVersion => 1;

  Future<List<TranslationEntity>> getAllVerses() async {
    final query = select(verses).map((row) => TranslationEntity(
          surah: row.suraId,
          ayah: row.ayahId,
          translation: row.verseText,
        ));

    return query.get();
  }
}
