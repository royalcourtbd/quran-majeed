import 'package:quran_majeed/data/service/database/database_service.dart';

class DailyAyahLocalDataSource {
  DailyAyahLocalDataSource(
    this._quranDatabase,
  );

  final QuranDatabase _quranDatabase;

  Future<List<AyahDatabaseTableData>> getAllDailyAyahs() async {
    return _quranDatabase.getAllDailyAyahs();
  }
}
