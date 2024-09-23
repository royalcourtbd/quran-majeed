
import 'package:quran_majeed/data/service/database/tafseer/tafseer_database.dart';

class TafseerLocalDataSource {
  TafseerLocalDataSource();

  Future<List<CommonTafseerTableData>> getCommonTafseerData({
    required int surahID,
    required TafseerDatabase database,
  }) async {
    return await database.getTafsirTextFromCommonTafseerTable(surahID: surahID);
  }

  Future<List<UniqueTafseerTableData>> getUniqueTafseerData({
    required int id,
    required TafseerDatabase database,
  }) async {
  
    return await database.getTafsirTextFromUniqueTafseerTable(id: id);
  }
}
