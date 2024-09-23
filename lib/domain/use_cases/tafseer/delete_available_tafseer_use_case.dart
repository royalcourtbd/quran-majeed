import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';

class DeleteAvailableTafseerUseCase extends BaseUseCase<void> {
  DeleteAvailableTafseerUseCase(this._tafseerRepository, super.errorMessageHandler);

  final TafseerRepository _tafseerRepository;

  Future<Either<String, void>> execute({required TTDbFileModel file}) {
    return mapResultToEither(() => _tafseerRepository.deleteAvailableTafseer(file: file));
  }
}