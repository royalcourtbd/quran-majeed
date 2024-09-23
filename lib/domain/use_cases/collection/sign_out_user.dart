import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/auth_repository.dart';


class SignOutUserUseCase extends BaseUseCase<String> {
  SignOutUserUseCase(
    this._authRepository,
    super.errorMessageHandler,
  );

  final AuthRepository _authRepository;

  Future<Either<String, String>> execute() async {
    return mapResultToEither(() async {
      await _authRepository.signOut();
      return "Signed out successfully";
    });
  }
}
