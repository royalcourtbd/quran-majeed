import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetSurahIdsForReciterUseCase extends BaseUseCase<List<int>>  {
  final ReciterRepository _reciterRepository;

  GetSurahIdsForReciterUseCase(this._reciterRepository, ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<List<int>> call(Reciter reciter) async {
    return await _reciterRepository.getSurahIdsForReciter(reciter);
  }
}