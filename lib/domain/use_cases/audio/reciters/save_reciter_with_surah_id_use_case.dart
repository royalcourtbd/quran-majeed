import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveReciterWithSurahIdUseCase extends BaseUseCase<void>  {
  final ReciterRepository _reciterRepository;

  SaveReciterWithSurahIdUseCase(this._reciterRepository, ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> call(int surahId, Reciter reciter, {bool isDelete = false}) async {
    return await _reciterRepository.saveReciterWithSurahId(surahId, reciter,isDelete: isDelete);
  }
}