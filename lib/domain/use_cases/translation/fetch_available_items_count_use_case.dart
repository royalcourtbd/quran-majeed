import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class FetchAvailableItemsCountUseCase extends BaseUseCase<int> {
  final TranslationRepository _translationRepository;

  FetchAvailableItemsCountUseCase(
    this._translationRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<int> execute() async {
    return getRight(
      () async => _translationRepository.fetchAvailableItemsCount(),
    );
  }
}
