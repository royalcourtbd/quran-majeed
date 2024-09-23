import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class DetermineIfItsFirstTimeInTafseerPage extends BaseUseCase<bool> {
  final TafseerRepository _repository;

  DetermineIfItsFirstTimeInTafseerPage(this._repository,
    super.errorMessageHandler,
  );

  Future<bool> execute() async {
    return await _repository.isFirstTimeInTafseerPage();
  }
}