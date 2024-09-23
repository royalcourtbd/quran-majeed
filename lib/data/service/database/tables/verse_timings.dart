import 'package:drift/drift.dart';

@DataClassName('VerseTiming')
class VerseTimings extends Table {
  IntColumn get reciterId => integer()();
  IntColumn get surahId => integer()();
  IntColumn get ayah => integer()();
  IntColumn get time => integer()();
  TextColumn get words => text().nullable()();
}