import 'package:drift/drift.dart';

class Bookmark extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foldername => text()();
  TextColumn get color => text()();
  IntColumn get suraId => integer()();
  IntColumn get ayahId => integer()();
  DateTimeColumn get createdAt => dateTime().named("created_at")();
  DateTimeColumn get updatedAt => dateTime().named("updated_at")();
}
