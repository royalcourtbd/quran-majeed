import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveAvailableTafseerItemsCountUseCase extends BaseUseCase<void> {
  final TafseerRepository _tafseerRepository;

  SaveAvailableTafseerItemsCountUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> execute(int count) async {
    return getRight(
      () async => _tafseerRepository.saveAvailableItemsCount(count),
    );
  }
}
