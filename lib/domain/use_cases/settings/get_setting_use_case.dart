

import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetSettingsStateUseCase extends BaseUseCase<SettingsStateEntity> {
  GetSettingsStateUseCase(
      this._settingsRepository,
      ErrorMessageHandler errorMessageHandler,
      ) : super(errorMessageHandler);

  final SettingsRepository _settingsRepository;

  Future<SettingsStateEntity> execute() async {
    return getRight(
          () async => _settingsRepository.getSettingsState(),
    );
  }
}
