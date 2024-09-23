import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class GetDefaultTafseerUseCase extends BaseUseCase<void> {
  GetDefaultTafseerUseCase(this._tafseerRepository, super.errorMessageHandler);

  final TafseerRepository _tafseerRepository;

  Future<Either<String, void>> execute({required String fileName}) {
    return mapResultToEither(() => _tafseerRepository.moveDefaultTafseerDbToInternalStorage(fileName: fileName));
  }
  
}
