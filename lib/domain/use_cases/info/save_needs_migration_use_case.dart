
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class SaveNeedsMigration extends BaseUseCase<void> {
  
  SaveNeedsMigration(this._userDataRepository,
    super.errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<void> execute() async {
    return getRight(
      () async => _userDataRepository.saveNeedsMigration(),
    );
  }
 
}