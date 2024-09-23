import 'package:drift/drift.dart';

class Verses extends Table {
  IntColumn get id => integer().nullable()();
  IntColumn get suraId => integer().nullable()();
  IntColumn get ayahId => integer().nullable()();
  TextColumn get verseText => text().named("text").nullable()();
}
