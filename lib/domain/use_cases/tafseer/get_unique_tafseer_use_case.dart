import 'package:collection/collection.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/database/tafseer/tafseer_database.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetUniqueTafseerUseCase extends BaseUseCase<List<UniqueTafseerTableData>> {
  final QuranDatabase _quranDatabase;

  GetUniqueTafseerUseCase(
    this._quranDatabase,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<List<UniqueTafseerTableData>> execute({
    required int surahId,
    required TafseerDatabase database,
  }) async {
    return getRight(
      () async {
        final List<AyahDatabaseTableData> ayahs =
            await _quranDatabase.getIDsBySurahID(surahId: surahId); // Get all ayahs for the Surah
        final List<int> tafsirIds = ayahs.map((ayah) => ayah.tafsirFmazid).whereNotNull().toList();

        // 2. Retrieve Tafsir text from the unique Tafsir DB
        final List<UniqueTafseerTableData> tafseerData = <UniqueTafseerTableData>[];
        for (var id in tafsirIds) {
          final List<UniqueTafseerTableData> tafseer =
              await database.getTafsirTextFromUniqueTafseerTable(id: id);
          tafseerData.addAll(tafseer);
        }

        return tafseerData;
      },
    );
  }
}
