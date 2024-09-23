import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class SaveSelectedTabIndexUseCase extends BaseUseCase<void> {
  final TafseerRepository _repository;

  SaveSelectedTabIndexUseCase(this._repository, super.errorMessageHandler);

  Future<void> execute(int index) async {
    await _repository.saveSelectedTabIndex(index);
  }
}
