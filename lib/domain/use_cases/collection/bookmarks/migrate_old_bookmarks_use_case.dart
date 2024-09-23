import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class MigrateOldBookmarks extends BaseUseCase<void> {
  
  MigrateOldBookmarks(this._userDataRepository,
    super.errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<void> execute() async {
    return getRight(
      () async => _userDataRepository.migrateOldBookmarks(),
    );
  }
 
}