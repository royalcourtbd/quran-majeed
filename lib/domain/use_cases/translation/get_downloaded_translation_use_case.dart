import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';

import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetDownloadedTranslationsUseCase extends BaseUseCase<List<String>> {
  
  
  GetDownloadedTranslationsUseCase(
    this._translationRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final TranslationRepository _translationRepository;

  Future<List<String>> execute() async {
    return getRight(
      () async => _translationRepository.getAvailableTranslations(),

    );
  }
}
