import 'package:flutter/material.dart';

import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';


class ScheduleNotificationUseCase extends BaseUseCase<String> {
  ScheduleNotificationUseCase(
    this._settingsRepository,
    super._errorMessageHandler,
  );

  final SettingsRepository _settingsRepository;

  Future<Either<String, String>> execute({
    required TimeOfDay time,
    required bool turnOn,
  }) async {
    return mapResultToEither(() async {
      await _settingsRepository.scheduleNotification(
        time: time,
        turnOn: turnOn,
      );

      final String successMessage =
          _generateSuccessMessage(turnOn: turnOn, time: time);
      return successMessage;
    });
  }

  String _generateSuccessMessage({
    required bool turnOn,
    required TimeOfDay time,
  }) {
    return turnOn
        ? 'Notification has been enabled at $time'
        : 'Notification has been disabled';
  }
}
