import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';

class GetTafseerUseCase extends BaseUseCase<Map<int, Map<int, String>>> {
  final TafseerRepository _tafseerRepository;

  GetTafseerUseCase(
    this._tafseerRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, Map<int, Map<int, String>>>> execute({
    required TTDbFileModel file,
    void Function(int percentage)? onProgress,
    required int surahID,
    required TafseerType tafseerType,
    required CancelToken cancelToken,
  }) async {
    return mapResultToEither(
      () async => _tafseerRepository.getTafseer(
        file: file,
        onProgress: onProgress,
        surahID: surahID,
        tafseerType: tafseerType,
        cancelToken: cancelToken,
      ),
    );
  }
}
