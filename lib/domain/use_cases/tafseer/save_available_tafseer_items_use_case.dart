import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveAvailableTafseerItemsUseCase extends BaseUseCase<void> {
  final TafseerRepository _tafseerRepository;

  SaveAvailableTafseerItemsUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> execute( {required Set<String> availableTafseers, required String newItem}) async {
    return getRight(
      () async => _tafseerRepository.saveAvailableTafseers(
          availableTafseers: availableTafseers, newItem: newItem),

    );
  }
}
