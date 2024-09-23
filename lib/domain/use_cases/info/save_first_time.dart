import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class SaveFirstTimeUseCase extends BaseUseCase<void> {
  SaveFirstTimeUseCase(super.errorMessageHandler, this.userDataRepository);

  final UserDataRepository userDataRepository;

  Future<void> execute() async {
    await doVoid(userDataRepository.doneFirstTime);
  }
}
