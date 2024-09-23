import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/our_project_entity.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetOurProjectsUseCase extends BaseUseCase<List<OurProjectEntity>> {
  GetOurProjectsUseCase(
    this._infoRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final InfoRepository _infoRepository;

  Future<Either<String, List<OurProjectEntity>>> execute() async {
    return mapResultToEither(() async => _infoRepository.getOurProjects());
  }
}
