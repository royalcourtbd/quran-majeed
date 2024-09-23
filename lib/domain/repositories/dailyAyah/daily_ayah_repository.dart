

import 'package:quran_majeed/data/service/database/database_service.dart';

abstract class DailyAyahRepository {
    Future<List<AyahDatabaseTableData>> getAllDailyAyahList();
}
