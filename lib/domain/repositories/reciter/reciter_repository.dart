import 'package:quran_majeed/data/service/database/database_service.dart';

abstract class ReciterRepository {
  Future<List<Reciter>> getReciters();
  Future<void> saveRecitersList(List<Reciter> reciters);
  Future<List<Reciter>> loadRecitersList();
  Future<void> saveSelectedReciter(Reciter reciter);
  Future<Reciter> getSelectedReciter();
  Future<void> saveReciterWithSurahId(int surahId, Reciter reciter, {bool isDelete = false});
  Future<List<int>> getSurahIdsForReciter(Reciter reciter);
  Future<void> saveDownloadCount(int reciterId, int count);
}
