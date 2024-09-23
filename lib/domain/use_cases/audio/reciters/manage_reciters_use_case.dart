import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class ManageRecitersUseCase extends BaseUseCase<List<Reciter>> {
  final ReciterRepository reciterRepository;

  ManageRecitersUseCase(
    this.reciterRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> saveRecitersList(List<Reciter> reciters) async {
    return await reciterRepository.saveRecitersList(reciters);
  }

  Future<List<Reciter>> loadRecitersList() async {
    return await reciterRepository.loadRecitersList();
  }
}