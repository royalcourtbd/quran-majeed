import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class SaveSelectedTafseersUseCase extends BaseUseCase<void> {
  final TafseerRepository _tafseerRepository;

  SaveSelectedTafseersUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<void> execute(Set<String> selectedTafseers) async {
    return getRight(
      () async => _tafseerRepository.saveSelectedTafseers(selectedTafseers),
    );
  }
}