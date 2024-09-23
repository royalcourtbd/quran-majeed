import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetLastReadsUseCase extends BaseUseCase<List<LastReadEntity>> {
  GetLastReadsUseCase(
    this._userDataRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final UserDataRepository _userDataRepository;

  Future<List<LastReadEntity>> execute() async {
    return _userDataRepository.getLastReads();
  }
}
