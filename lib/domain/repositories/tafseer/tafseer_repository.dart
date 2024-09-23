import 'package:dio/dio.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';

abstract class TafseerRepository {
  Future<Map<int, Map<int, String>>> getTafseer({
    required TTDbFileModel file,
    void Function(int percentage)? onProgress,
    required int surahID,
    required TafseerType tafseerType,
    required CancelToken cancelToken,
  });
  Future<void> deleteTafseerDatabase({required String fileName});
  List<String> getAvailableTafseers();
  Future<void> saveAvailableTafseers({required Set<String> availableTafseers, required String newItem});
  Future<void> selectTafseer({required TTDbFileModel file, required int surahID, required TafseerType tafseerType});
  Future<void> deleteAvailableTafseer({required TTDbFileModel file});
  Future<Set<String>> getSelectedTafseers();
  Future<void> saveSelectedTafseers(Set<String> selectedTafseers);
  Future<void> moveDefaultTafseerDbToInternalStorage({required String fileName});
  Future<bool> isFirstTimeInTafseerPage();
  Future<void> saveSelectedTabIndex(int index);
  Future<int> getSelectedTabIndex();
  Future<void> saveAvailableItemsCount(int count);
  Future<int> fetchAvailableItemsCount();
}
