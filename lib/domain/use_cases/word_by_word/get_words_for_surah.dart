
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';


class GetWordsForSurah extends BaseUseCase<List<WordByWordEntity>> {
  GetWordsForSurah(this._wordByWordRepository, ErrorMessageHandler errorMessageHandler)
      : super(errorMessageHandler);
  final WordByWordRepository _wordByWordRepository;

  Future<Either<String, List<WordByWordEntity>>> execute(int surahNumber) async {
    return mapResultToEither(
      () async => _wordByWordRepository.getWordsForSurah(surahNumber),
    );
  }
}