import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class ManageSelectedReciterUseCase extends BaseUseCase<Reciter> {
  final ReciterRepository _reciterRepository;

  ManageSelectedReciterUseCase(this._reciterRepository, ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> saveSelectedReciter(Reciter reciter) async {
    await _reciterRepository.saveSelectedReciter(reciter);
  }

  Future<Reciter> getSelectedReciter() async {
    return await _reciterRepository.getSelectedReciter();
  }
}