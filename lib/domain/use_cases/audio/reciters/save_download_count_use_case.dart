import 'package:quran_majeed/core/base/base_use_case.dart';

import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';

class SaveDownloadCountUseCase extends BaseUseCase<void> {
  final ReciterRepository _reciterRepository;

  SaveDownloadCountUseCase(this._reciterRepository, super.errorMessageHandler);

  Future<void> saveDownloadCount(int reciterId, int count) async {
    return await _reciterRepository.saveDownloadCount(reciterId, count);
  }
}
