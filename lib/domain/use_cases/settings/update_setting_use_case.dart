
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';

class UpdateSettingsUseCase extends BaseUseCase<void> {
  UpdateSettingsUseCase(this._settingsRepository, super._errorMessageHandler);

  final SettingsRepository _settingsRepository;

  Future<void> execute({
    required SettingsStateEntity settingsState,
  }) async {
    return doVoid(
          () => _settingsRepository.updateSettings(settingsState: settingsState),
    );
  }
}
