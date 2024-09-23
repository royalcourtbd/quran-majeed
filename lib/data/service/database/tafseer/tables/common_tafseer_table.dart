import 'package:drift/drift.dart';

class CommonTafseerTable extends Table {
  IntColumn get id => integer()();
  IntColumn? get suraId => integer().nullable()();
  IntColumn? get ayahId => integer().nullable()();
  TextColumn? get tafsirText => text().named("tafsir_text").nullable()();

  @override
  String get tableName => 'verses';
}
