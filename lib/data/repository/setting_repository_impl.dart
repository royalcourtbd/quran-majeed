import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/user_data_local_data_source.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';
import 'package:quran_majeed/domain/service/notification_service.dart';
import 'package:synchronized/synchronized.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(
    this._userDataLocalDataSource,
    this._notificationService,
  ) {
    initSettings();
  }

  final UserDataLocalDataSource _userDataLocalDataSource;
    final NotificationService _notificationService;


  final StreamController<SettingsStateEntity> _streamController = StreamController<SettingsStateEntity>.broadcast();

  final Lock _initSettingsLock = Lock();

  @override

  /// Initializes the settings lock and executes the provided asynchronous function
  /// within the synchronized block.
  ///
  /// This method ensures that the provided function is executed atomically,
  /// preventing concurrent access to the settings.
  ///
  /// Usage:
  /// ```dart
  /// await _initSettingsLock.synchronized(() async {
  ///   // Code to be executed within the synchronized block
  /// });
  /// ```
  ///
  /// Note: The `_initSettingsLock` should be initialized before calling this method.
  ///
  /// Throws an exception if the provided function throws an exception.
  Future<void> initSettings() async {
    await _initSettingsLock.synchronized(() async {
      final SettingsStateEntity currentState = await _userDataLocalDataSource.getSettingState();
      _streamController.add(currentState);
    });
  }

  final Lock _updateSettingsLock = Lock();

  @override
  Future<void> updateSettings({
    required SettingsStateEntity settingsState,
  }) async {
    await _updateSettingsLock.synchronized(() async {
      _streamController.add(settingsState);
      await _userDataLocalDataSource.saveSettingState(
        settingsState: settingsState,
      );
    });
  }

    @override
  Future<void> scheduleNotification({
    required TimeOfDay? time,
    required bool turnOn,
  }) async {
    await _notificationService.setUp();
    await _notificationService.scheduleNotification(
      turnOn: turnOn,
      time: time ?? const TimeOfDay(hour: 9, minute: 0),
    );
  }


  @override
  Future<void> dispose() async {
    await _streamController.close();
  }

  @override
  Stream<SettingsStateEntity> get settingsStream => _streamController.stream;

  @override
  Future<SettingsStateEntity> getSettingsState() => _userDataLocalDataSource.getSettingState();
}
