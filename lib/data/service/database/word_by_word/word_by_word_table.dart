import 'package:drift/drift.dart';

class WordByWordTable extends Table {
  IntColumn get sura => integer()();
  IntColumn get ayah => integer()();
  IntColumn get word => integer()();
  TextColumn get translation => text().nullable()();
}
