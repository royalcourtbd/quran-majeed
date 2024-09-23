import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetRecitersFromDatabaseUseCase extends BaseUseCase<List<Reciter>> {
  final ReciterRepository reciterRepository;

  GetRecitersFromDatabaseUseCase(
    this.reciterRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<List<Reciter>> call() async {
    return await reciterRepository.getReciters();
  }
}
