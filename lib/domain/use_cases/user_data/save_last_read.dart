import 'package:quran_majeed/domain/entities/last_read_entity.dart';

import '../../../core/base/base_use_case.dart';
import '../../repositories/user_data_repository.dart';

class SaveLastReadUseCase extends BaseUseCase<void> {
  SaveLastReadUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<void> execute({
    required LastReadEntity lastRead,
  }) async {
    await _userDataRepository.saveLastRead(lastRead: lastRead);
  }
}
