import 'package:drift/drift.dart';

class AyahDatabaseTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surahId => integer().nullable()();

  IntColumn get ayahID => integer().named("ayah_id").nullable()();

  IntColumn get juz => integer().nullable()();

  TextColumn get hijb => text().nullable()();

  IntColumn get page => integer().nullable()();

  TextColumn get clean => text().nullable()();

  TextColumn get trBn => text().nullable()();

  TextColumn get trEn => text().nullable()();

  TextColumn get qcf => text().nullable()();

  TextColumn get fonts => text().nullable()();

  IntColumn get tafsirKathir => integer().nullable()();

  IntColumn get tafsirFmazid => integer().nullable()();

  IntColumn get tafsirKathirMujibor => integer().nullable()();
}
