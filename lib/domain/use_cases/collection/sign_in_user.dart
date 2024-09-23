import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/auth_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';


class SignInUserUseCase extends BaseUseCase<String> {
  SignInUserUseCase(
    this._authRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final AuthRepository _authRepository;

  Future<Either<String, String>> execute() async {
    return mapResultToEither(() async {
      await _authRepository.signIn();

      return "Signed in successfully";
    });
  }
}
