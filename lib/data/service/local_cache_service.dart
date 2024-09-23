import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';

const String _secretVaultName = "local_cache";

class LocalCacheService {
  static Future<void> setUp() async {
    final Directory document = await getApplicationDocumentsDirectory();
    final String documentPath = document.path;
    Hive.init(documentPath);
    await Hive.openBox<Object>(_storageFileName);
  }

  static String get _storageFileName => "${_secretVaultName}_239090";

  /// Saves the provided `value` to the persistent storage using the specified `key`.
  ///
  /// The type parameter `T` represents the type of the `value` being saved,
  /// and it must be a subtype of `Object`.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await saveData(key: CacheKeys.userId, value: 'sufi_bhai_28283');
  /// ```
  Future<void> saveData<T extends Object>({
    required String key,
    required T value,
  }) async {
    await catchFutureOrVoid(() async {
      if (key.isEmpty) return;
      await _hiveBox.put(key, value);
    });
  }

  // Future<String?> getOldBookmarkJsonFile() async {
  //   bool hasPermission = await PermissionService.checkPermission();

  //   if (hasPermission) {
  //     const String bookmarkFilePath = '/storage/emulated/0/quranAppBookmark/bookmark.json';
  //     final File bookmarkFile = File(bookmarkFilePath);
  //     if (await bookmarkFile.exists()) {
  //       return await bookmarkFile.readAsString();
  //     }
  //   }
  //   return null;
  // }

  Future<String?> getOldBookmarkJsonFile() async {
    const MethodChannel platformMethodChannel = MethodChannel("com.ihadis.quran/legacy");

    if (!Platform.isAndroid) {
      logError("Platform is not android, skipping legacy data retrieval");
      return null;
    }

    final bool alreadyRetrieved = getData(key: CacheKeys.retrievedPreviousBookmarks) ?? false;

    if (alreadyRetrieved) {
      logError("Already retrieved legacy data, skipping");
      return null;
    }

    try {
      final String? legacyBookmarkJson = await platformMethodChannel.invokeMethod<String>("fetch_bookmarks");
      
      if (legacyBookmarkJson == null || legacyBookmarkJson.isEmpty) {
        logError("Legacy bookmark json is null or empty");
        return null;
      }

      await saveData(key: CacheKeys.retrievedPreviousBookmarks, value: true);
      return legacyBookmarkJson;
    } catch (e) {
      logError("Error fetching legacy bookmarks: $e");
      return null;
    }
  }

  /// Retrieves data from persistent storage using the specified `key`.
  ///
  /// The type parameter `T` represents the type of the data being retrieved,
  /// and it allows writing type-safe and reusable code that can operate on
  /// different data types.
  ///
  ///
  /// If an error occurs during the retrieval process, an error message is logged,
  /// and `null` is returned.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// String? userId = getData<String>(key: CacheKeys.userId);
  /// bool? isFirstTime = getData<bool>(key: CacheKeys.firstTime);
  /// ```
  ///
  /// Note: This function assumes that the `_hiveBox` instance is properly initialized
  /// and accessible within the scope of this function.
  T? getData<T>({required String key}) {
    try {
      final T? result = _hiveBox.get(key) as T?;
      return result;
    } catch (e) {
      logError("getData: key: $key\nerror: $e");
      return null;
    }
  }

  /// Deletes data from persistent storage for the specified `key`.
  ///
  /// If the `key` does not exist, the operation completes without any effect.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await deleteData(key: CacheKeys.userId);
  /// ```
  Future<void> deleteData({required String key}) async {
    await catchFutureOrVoid(() async {
      if (key.isEmpty) return;
      await _hiveBox.delete(key);
    });
  }

  late final Box<Object> _hiveBox = Hive.box(_storageFileName);
}

/// Utility class that provides constant values for cache keys used in the application.
///
///
/// Example usage:
///
/// ```dart
/// String userIdKey = CacheKeys.userId;
/// String fcmDeviceTokenKey = CacheKeys.fcmDeviceToken;
/// ```
///
/// Rationale:
///
/// - Avoids hardcoding cache keys as strings in different parts of the codebase,
///   reducing the likelihood of typos or inconsistencies.
/// - Improves code readability and maintainability by providing a single source
///   of truth for cache keys.
/// - Facilitates easy modification or updating of cache keys, as changes only
///   need to be made in one place.
///
/// Recommended to use these cache keys when interacting with the cache
/// to ensure consistency and reduce the risk of errors related to cache key usage.
class CacheKeys {
  CacheKeys._();

  static const String userId = 'userId_key';
  static const String fcmDeviceToken = "fcm_device_token_key";
  static const String lastReads = "last_reads_list_key";
  static const String lastSyncDate = "last_sync_date_key";
  static const String settingsState = "settings_state_key";
  static const String promotionalMessageId = "promotional_message_id_key";
  static const String firstTime = "first_time_key";
  static const String ifItsUpdatedFromv3 = "if_its_updated_from_v3_key";
  static const String previousVersion = "previous_version_key";
  static const String lastTimeOnNotification = "last_time_on_notification_key";
  static const String retrievedPreviousBookmarks = "retrieved_previous_bookmarks_key";
  static const String searchHistories = "search_histories_key";
  static const String launchCount = "launch_count_key";
  static const String availableTranslations = "available_translations_key";
  static const String selectedTranslations = "selected_translations_key";
  static const String availableTafseer = "available_tafseer_key";
  static const String selectedTafseer = "selected_tafseer_key";
  static const String isFirstTimeInTafseerPage = "is_first_time_in_tafseer_page_key";
  static const String selectedTafseerTabIndex = "selected_tafseer_tab_index_key";
  static const String memorization = "memorization";
  static const String includeDefaultTafseer = "include_default_tafseer_key";
  static const String selectedWbwLanguage = "selected_wbw_language_key";
  static const String downloadedWbwLanguages = "downloaded_wbw_languages_key";
}
