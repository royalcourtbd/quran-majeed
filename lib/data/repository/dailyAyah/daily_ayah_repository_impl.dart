import 'package:quran_majeed/data/data_sources/local_data_source/dailyAyah/daily_ayah_local_data_source.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/dailyAyah/daily_ayah_repository.dart';

class DailyAyahRepositoryImpl extends DailyAyahRepository {
  DailyAyahRepositoryImpl(this._dailyAyahLocalDataSource);

  final DailyAyahLocalDataSource _dailyAyahLocalDataSource;

  @override
  Future<List<AyahDatabaseTableData>> getAllDailyAyahList() async {
    return _dailyAyahLocalDataSource.getAllDailyAyahs();
  }
}
