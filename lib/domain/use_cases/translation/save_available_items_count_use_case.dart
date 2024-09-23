import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveAvailableItemsCountUseCase extends BaseUseCase<void> {
  final TranslationRepository _translationRepository;

  SaveAvailableItemsCountUseCase(
    this._translationRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> execute(int count) async {
    return getRight(
      () async => _translationRepository.saveAvailableItemsCount(count),
    );
  }
}
