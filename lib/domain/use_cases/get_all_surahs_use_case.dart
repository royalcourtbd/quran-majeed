
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/surah_repository.dart';

class GetAllSurahsUseCase extends BaseUseCase<void> {
  GetAllSurahsUseCase(this._surahRepository, super.errorMessageHandler);

  final SurahRepository _surahRepository;

  Future<Either<String, void>> execute() async {
    return mapResultToEither(_surahRepository.getAllSurahList);
  }
}

