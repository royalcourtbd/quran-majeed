import '../../../core/base/base_use_case.dart';
import '../../entities/last_read_entity.dart';
import '../../repositories/user_data_repository.dart';

class DeleteLastReadUseCase extends BaseUseCase<void> {
  DeleteLastReadUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<List<LastReadEntity>> execute({
    required List<int> deletedItem,
  }) async {
    return await _userDataRepository.deleteLastReads(deletedItem: deletedItem);
  }
}
