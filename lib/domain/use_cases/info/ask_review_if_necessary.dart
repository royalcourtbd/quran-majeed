

import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';

class AskReviewIfNecessaryUseCase extends BaseUseCase<bool> {
  AskReviewIfNecessaryUseCase(
    super.errorMessageHandler,
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  Future<bool> execute({required void Function() askForReview}) async {
    return getRight(
      () async =>
          _userDataRepository.askForReviewIfAllowed(askForReview: askForReview),
    );
  }
}
