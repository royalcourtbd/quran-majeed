import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class FetchAvailableTafseerItemsCountUseCase extends BaseUseCase<int> {
  final TafseerRepository _tafseerRepository;

  FetchAvailableTafseerItemsCountUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<int> execute() async {
    return getRight(
      () async => _tafseerRepository.fetchAvailableItemsCount(),
    );
  }
}
