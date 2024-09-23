import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class GetSelectedTabIndexUseCase extends BaseUseCase<int> {
  final TafseerRepository _repository;

  GetSelectedTabIndexUseCase(this._repository, super.errorMessageHandler);

  Future<int> execute() async {
    return await _repository.getSelectedTabIndex();
  }
}