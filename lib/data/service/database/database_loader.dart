import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

const String _dbPath = "assets/database";
const String _quranDbFileName = "quran_main.db";
const String _quranDbPath = "$_dbPath/$_quranDbFileName";

LazyDatabase loadDatabase() => LazyDatabase(() => _databaseOpener);

Future<bool> isDatabaseFileFound() async {
  final bool? fileFound = await catchAndReturnFuture(() async {
    final File file = await getDatabaseFile(fileName: _quranDbFileName);
    final bool exists = await file.exists();
    if (!exists) return false;
    return true;
  });
  return fileFound ?? false;
}

Future<void> deleteDatabase() async {
  await catchFutureOrVoid(() async {
    final File file = await getDatabaseFile(fileName: _quranDbFileName);
    // ignore: avoid_slow_async_io
    final bool exists = await file.exists();
    if (exists) await file.delete();
  });
}

Future<QueryExecutor> get _databaseOpener async {
  final File file = await getDatabaseFile(fileName: _quranDbFileName);
  await moveDatabaseFromAssetToInternal(
    file: file,
    assetPath: _quranDbPath,
  );
  return NativeDatabase.createInBackground(file);
}

LazyDatabase loadUserDatabase() => LazyDatabase(() => _userDatabaseOpener);

Future<QueryExecutor> get _userDatabaseOpener async {
  final File file =
      await getDatabaseFile(fileName: "quran_mazid_user_data.sqlite");
  return NativeDatabase.createInBackground(
    file,
  );
}
