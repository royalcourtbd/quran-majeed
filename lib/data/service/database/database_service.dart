import 'package:drift/drift.dart';
import 'package:quran_majeed/data/service/database/database_loader.dart';
import 'package:quran_majeed/data/service/database/tables/audio_files.dart';
import 'package:quran_majeed/data/service/database/tables/ayah_database_table.dart';
import 'package:quran_majeed/data/service/database/tables/reciters.dart';
import 'package:quran_majeed/data/service/database/tables/surah_database_table.dart';
import 'package:quran_majeed/data/service/database/tables/verse_timings.dart';
import 'package:quran_majeed/data/service/database/tables/word_by_word_database_table.dart';
import 'package:quran_majeed/domain/entities/translation_entity.dart';

part 'database_service.g.dart';

@DriftDatabase(
  tables: [
    SurahDatabaseTable,
    AyahDatabaseTable,
    WordByWordDatabaseTable,
    AudioFiles,
    Reciters,
    VerseTimings,
  ],
)
class QuranDatabase extends _$QuranDatabase {
  QuranDatabase({QueryExecutor? queryExecutor}) : super(queryExecutor ?? loadDatabase());

  @override
  int get schemaVersion => 1;

  Future<List<SurahDatabaseTableData>> getAllSurahs() => select(surahDatabaseTable).get();

  Future<List<AyahDatabaseTableData>> getIDsBySurahID({required int surahId}) async {
    return (select(ayahDatabaseTable)..where((tbl) => tbl.surahId.equals(surahId))).get();
  }

  Future<List<AudioFile>> getAudioFilesForReciter(int reciterId) {
    return (select(audioFiles)..where((t) => t.reciterId.equals(reciterId))).get();
  }

  Future<List<Reciter>> getAllReciters() => select(reciters).get();

  Future<AudioFile> getAudioFilesBySurahAndReciter(int surahId, int reciterId) {
    return (select(audioFiles)..where((t) => t.surahId.equals(surahId) & t.reciterId.equals(reciterId))).getSingle();
  }

  Future<List<AudioFile>> getAudioFilesByReciterId(int reciterId) =>
      (select(audioFiles)..where((tbl) => tbl.reciterId.equals(reciterId))).get();

  Future<List<VerseTiming>> getVerseTimingsBySurahId(int reciterID, int surahID) =>
      (select(verseTimings)..where((tbl) => tbl.reciterId.equals(reciterID) & tbl.surahId.equals(surahID))).get();

  Future<List<WordByWordDatabaseTableData>> getWordsByWord(int surahNumber) async {
    return (select(wordByWordDatabaseTable)..where((tbl) => tbl.surah.equals(surahNumber))).get();
  }

  Future<List<WordByWordDatabaseTableData>> getWordsByWordForSpecificAyah(int surahNumber, int ayahNumber) async {
    return (select(wordByWordDatabaseTable)
          ..where((tbl) => tbl.surah.equals(surahNumber) & tbl.ayah.equals(ayahNumber)))
        .get();
  }

  Future<List<TranslationEntity>> getFullTranslationData({required String language}) {
    final query = select(ayahDatabaseTable).map((row) => TranslationEntity(
          surah: row.surahId,
          ayah: row.ayahID,
          translation: language == "en" ? row.trEn : row.trBn,
        ));

    return query.get();
  }

  Future<List<AyahDatabaseTableData>> getAllDailyAyahs() {
    return ((select(ayahDatabaseTable))
          ..where((tbl) {
            return tbl.trEn.length.isBetween(
              const Variable(100),
              const Variable(130),
            );
          })
          ..orderBy([(t) => OrderingTerm(expression: const CustomExpression('RANDOM()'))])
          ..limit(25))
        .get();
  }

  Future<AyahDatabaseTableData> getDailyAyah() => ((select(ayahDatabaseTable))
        ..orderBy([(t) => OrderingTerm(expression: const CustomExpression('RANDOM()'))])
        ..limit(1))
      .getSingle();

  Future<AyahDatabaseTableData> getAyahBySurahAndAyahID({
    required int surahID,
    required int ayahID,
  }) =>
      ((select(ayahDatabaseTable))..where((tbl) => tbl.surahId.equals(surahID) & tbl.ayahID.equals(ayahID)))
          .getSingle();
}
