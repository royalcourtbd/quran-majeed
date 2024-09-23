

import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/auth_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class CheckAuthenticationStatusUseCase extends BaseUseCase<bool> {
  CheckAuthenticationStatusUseCase(
    this._authRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);
  final AuthRepository _authRepository;

  Future<bool> execute() async {
    return getRight(
      () async {
        final bool isAuthenticated =
            await _authRepository.checkAuthenticationStatus();
        return isAuthenticated;
      },
  
    );
  }
}
