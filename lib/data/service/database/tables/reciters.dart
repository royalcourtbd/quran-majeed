import 'package:drift/drift.dart';

@DataClassName('Reciter')
class Reciters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}