import 'dart:async';
import 'package:quran_majeed/core/utility/exceptions.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/backend_as_a_service.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._backendAsAService, this._localCacheService);

  final BackendAsAService _backendAsAService;
  final LocalCacheService _localCacheService;

  @override
  Future<void> signIn() async {
    await _validateInternetConnection();
    final String userId = await _backendAsAService.signIn();
    await _localCacheService.saveData(key: CacheKeys.userId, value: userId);
  }

  @override
  Future<void> signOut() async {
    await _validateInternetConnection();
    await _backendAsAService.signOut();
    await _localCacheService.saveData<String>(key: CacheKeys.userId, value: '');
  }

  Future<void> _validateInternetConnection() async {
    final bool isNetworkConnected = await checkInternetConnection();
    if (!isNetworkConnected) throw NoInternetException();
  }

  @override
  Future<bool> checkAuthenticationStatus() async {
    final bool isAuthenticated = await _backendAsAService.isAuthenticated;
    await _getAndSaveFcmToken();
    return isAuthenticated;
  }

  Future<void> _getAndSaveFcmToken() async {
    await catchAndReturnFuture(() async {
      await _backendAsAService.listenToDeviceToken(
        onTokenFound: (token) async {
          await _localCacheService.saveData<String>(
            key: CacheKeys.fcmDeviceToken,
            value: token,
          );
        },
      );
    });
  }
}
