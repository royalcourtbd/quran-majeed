import 'package:flutter/material.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';

abstract class SettingsRepository {
  Future<void> initSettings();

  Stream<SettingsStateEntity> get settingsStream;

  Future<void> updateSettings({required SettingsStateEntity settingsState});

    Future<void> scheduleNotification({
    required TimeOfDay time,
    required bool turnOn,
  });

  Future<SettingsStateEntity> getSettingsState();

  Future<void> dispose();


}
