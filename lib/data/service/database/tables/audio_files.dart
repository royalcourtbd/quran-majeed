import 'package:drift/drift.dart';

@DataClassName('AudioFile')
class AudioFiles extends Table {
  IntColumn get reciterId => integer()();
  IntColumn get surahId => integer()();
  TextColumn get audioLink => text()();
}