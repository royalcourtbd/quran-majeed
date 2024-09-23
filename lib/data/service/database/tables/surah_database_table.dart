import 'package:drift/drift.dart';


class SurahDatabaseTable extends Table {
  IntColumn get serial => integer().autoIncrement()();

  IntColumn get totalAyah => integer()();

  TextColumn get name => text()();

  TextColumn get nameEn => text()();

  TextColumn get meaning => text()();

  TextColumn get type => text()();

  TextColumn get nameBn => text()();

  TextColumn get meaningBn => text()();
}
