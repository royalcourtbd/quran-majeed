import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:quran_majeed/data/service/database/tafseer/tables/common_tafseer_table.dart';
import 'package:quran_majeed/data/service/database/tafseer/tables/unique_tafseer_table.dart';

part 'tafseer_database.g.dart';

@DriftDatabase(tables: [CommonTafseerTable, UniqueTafseerTable])
class TafseerDatabase extends _$TafseerDatabase {
  final String dbPath;

  TafseerDatabase._internal(File dbFile)
      : dbPath = dbFile.path,
        super(NativeDatabase(dbFile));

  static final Map<String, TafseerDatabase> _instances = {};
  static final Map<String, Completer<void>> _closeCompleters = {};

  factory TafseerDatabase(File dbFile) {
    return _instances.putIfAbsent(
      dbFile.path,
      () {
        final db = TafseerDatabase._internal(dbFile);
        _closeCompleters[dbFile.path] = Completer<void>();
        return db;
      },
    );
  }

  @override
  int get schemaVersion => 1;

  Future<List<CommonTafseerTableData>> getTafsirTextFromCommonTafseerTable({
    required int surahID,
  }) async {
    return await (select(commonTafseerTable)..where((tbl) => tbl.suraId.equals(surahID))).get();
  }

  Future<List<UniqueTafseerTableData>> getTafsirTextFromUniqueTafseerTable({
    required int id,
  }) async {
    return await (select(uniqueTafseerTable)..where((tbl) => tbl.id.equals(id))).get();
  }

  @override
  Future<void> close() async {
    final completer = _closeCompleters[dbPath];
    if (completer != null && !completer.isCompleted) {
      await super.close();
      completer.complete();
      _instances.remove(dbPath);
      _closeCompleters.remove(dbPath);
    }
  }

  static Future<void> closeAll() async {
    for (var db in _instances.values) {
      await db.close();
    }
    _instances.clear();
    _closeCompleters.clear();
  }

  static Future<void> waitForClose(String path) async {
    final completer = _closeCompleters[path];
    if (completer != null) {
      await completer.future;
    }
  }
}