import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';


class ListenSettingsChangesUseCase {
  ListenSettingsChangesUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  /// Executes the listen settings changes use case.
  /// This method initializes the settings repository and returns a stream of [Either] containing either a [String] or [SettingsStateEntity].
  /// The stream emits the updated settings whenever a change occurs.
  Stream<Either<String, SettingsStateEntity>> execute() async* {
    await _settingsRepository.initSettings();
    yield* _settingsRepository.settingsStream.map(right);
  }
}
