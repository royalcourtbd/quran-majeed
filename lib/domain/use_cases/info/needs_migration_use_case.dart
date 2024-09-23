import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class NeedsMigration extends BaseUseCase<bool> {
  
  NeedsMigration(this._userDataRepository,
    super.errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<bool> execute() async {
    return getRight(
      () async => _userDataRepository.needsMigration(),
    );
  }
 
}