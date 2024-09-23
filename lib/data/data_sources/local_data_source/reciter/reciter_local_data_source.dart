import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class ReciterLocalDataSource {
  final QuranDatabase _quranDatabase;

  ReciterLocalDataSource(this._quranDatabase);

  Future<List<Reciter>> getReciters() async {
    try {
      return await _quranDatabase.getAllReciters();
    } catch (e) {
      logErrorStatic('Error in getReciters: $e', 'ReciterLocalDataSource');
      rethrow;
    }
  }
}
