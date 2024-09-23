import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class DeleteTafseerDatabaseUseCase extends BaseUseCase<void> {
  DeleteTafseerDatabaseUseCase(this._tafseerRepository, super.errorMessageHandler);

  final TafseerRepository _tafseerRepository;

  Future<Either<String, void>> execute({required String fileName}) {
    return mapResultToEither(() => _tafseerRepository.deleteTafseerDatabase(fileName: fileName));
  }
}
