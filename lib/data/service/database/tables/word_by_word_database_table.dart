import 'package:drift/drift.dart';

class WordByWordDatabaseTable extends Table {
  IntColumn get surah => integer().nullable()();

  IntColumn get ayah => integer().nullable()();

  TextColumn get hijb => text().nullable()();

  IntColumn get juz => integer().nullable()();

   IntColumn get word => integer().nullable()();

  IntColumn get page => integer().nullable()();

  TextColumn get uthmani => text().nullable()();

  TextColumn get indopak => text().nullable()();

  TextColumn get en => text().nullable()();

  TextColumn get bn => text().nullable()();

  TextColumn get audio => text().nullable()();

}
