
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';


class PreloadAdjacentSurahs extends BaseUseCase<void> {
  PreloadAdjacentSurahs(this._wordByWordRepository, ErrorMessageHandler errorMessageHandler)
      : super(errorMessageHandler);
  
  final WordByWordRepository _wordByWordRepository;

  Future<Either<String, void>> execute(int currentSurah) async {
    return mapResultToEither(
      () async => _wordByWordRepository.preloadAdjacentSurahs(currentSurah),
    );
  }
}