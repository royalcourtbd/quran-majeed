import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetSelectedTranslationsUseCase extends BaseUseCase<Set<String>> {
  final TranslationRepository _translationRepository;

  GetSelectedTranslationsUseCase(
    this._translationRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Set<String>> execute() async {
    return getRight(
      () async => _translationRepository.getSelectedTranslations(),
    
    );
  }
}