import 'package:drift/drift.dart';

class UniqueTafseerTable extends Table {
  IntColumn get id => integer()();
  IntColumn? get start => integer().nullable()();
  IntColumn? get end => integer().nullable()();
  TextColumn? get tafsirText => text().named("tafsir_text").nullable()();

  @override
  String get tableName => 'verses';
}
