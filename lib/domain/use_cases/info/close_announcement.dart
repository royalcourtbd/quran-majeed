import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class CloseAnnouncementUseCase extends BaseUseCase<Unit> {
  CloseAnnouncementUseCase(
    this._infoRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final InfoRepository _infoRepository;

  Future<Either<String, Unit>> execute({required bool userSeen}) async {
    return mapResultToEither(() async {
      await _infoRepository.closePromotionalMessage(userSeen: userSeen);
      return unit;
    });
  }
}
