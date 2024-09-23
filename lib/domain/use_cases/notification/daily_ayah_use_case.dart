import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class GetDailyAyahUseCase extends BaseUseCase<AyahDatabaseTableData> {
  GetDailyAyahUseCase(
    this._quranDatabase,
    super._errorMessageHandler,
  );
  final QuranDatabase _quranDatabase;

  Future<AyahDatabaseTableData> execute() async {
    return getRight(() async => await _quranDatabase.getDailyAyah());
  }
}
