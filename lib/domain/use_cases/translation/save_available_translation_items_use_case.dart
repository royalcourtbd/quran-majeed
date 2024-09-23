import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveAvailableTranslationItemsUseCase extends BaseUseCase<void> {
  final TranslationRepository _translationRepository;

  SaveAvailableTranslationItemsUseCase(
    this._translationRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> execute( {required Set<String> availableTranslations, required String newItem}) async {
    return getRight(
      () async => _translationRepository.saveAvailableTranslations(
          availableTranslations: availableTranslations, newItem: newItem),

    );
  }
}
