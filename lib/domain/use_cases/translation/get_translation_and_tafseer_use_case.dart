import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/translation/i_translation_and_tafseer_repository.dart';

class GetTranslationAndTafseerUseCase extends BaseUseCase<TTJsonModel> {
  final ITranslationAndTafseerRepository repository;

  GetTranslationAndTafseerUseCase(this.repository, super.errorMessageHandler);

  Future<Either<String, TTJsonModel>> execute() async => mapResultToEither(() => repository.getTranslationAndTafseer());
}
