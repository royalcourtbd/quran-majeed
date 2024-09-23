import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetSelectedTafseersUseCase extends BaseUseCase<Set<String>> {
  final TafseerRepository _tafseerRepository;

  GetSelectedTafseersUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Set<String>> execute() async {
    return getRight(
      () async => _tafseerRepository.getSelectedTafseers(),
    );
  }
}