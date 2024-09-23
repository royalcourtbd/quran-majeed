import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/audio/audio_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/dailyAyah/daily_ayah_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/info_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/memorization/memorization_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/reciter/reciter_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/surah_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/tafseer/tafseer_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/translation/i_translation_and_tafseer_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/translation/translation_and_tafseer_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/translation/translation_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/user_data_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/info_remote_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/word_by_word/word_by_word_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/audio/audio_remote_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/translation_and_tafseer/translation_tafseer_remote_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/user_data_remote_data_source.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/word_by_word/word_by_word_remote_data_source.dart';

import 'package:quran_majeed/data/repository/audio/audio_repository_impl.dart';
import 'package:quran_majeed/data/repository/auth_repository_impl.dart';
import 'package:quran_majeed/data/repository/dailyAyah/daily_ayah_repository_impl.dart';
import 'package:quran_majeed/data/repository/info_repository_impl.dart';
import 'package:quran_majeed/data/repository/memorization/memorization_impl.dart';
import 'package:quran_majeed/data/repository/notification_repository_impl.dart';
import 'package:quran_majeed/data/repository/reciter/reciter_repository_impl.dart';
import 'package:quran_majeed/data/repository/setting_repository_impl.dart';
import 'package:quran_majeed/data/repository/surah_repository_impl.dart';
import 'package:quran_majeed/data/repository/tafseer/tafseer_repository_impl.dart';
import 'package:quran_majeed/data/repository/translation/translation_and_tafseer_repository_impl.dart';
import 'package:quran_majeed/data/repository/translation/translation_repository_impl.dart';
import 'package:quran_majeed/data/repository/user_data_repository_impl.dart';
import 'package:quran_majeed/data/repository/word_by_word_repository_impl.dart';
import 'package:quran_majeed/data/service/backend_as_a_service.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/collection/user_data_storage.dart';
import 'package:quran_majeed/data/service/error_message_handler_impl.dart';
import 'package:quran_majeed/data/service/file_service_presentable.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/audio/audio_repository.dart';
import 'package:quran_majeed/domain/repositories/auth_repository.dart';
import 'package:quran_majeed/domain/repositories/dailyAyah/daily_ayah_repository.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';
import 'package:quran_majeed/domain/repositories/memorization/memorization_repository.dart';
import 'package:quran_majeed/domain/repositories/notification/notification_repository.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';
import 'package:quran_majeed/domain/repositories/setting_repository.dart';
import 'package:quran_majeed/domain/repositories/surah_repository.dart';
import 'package:quran_majeed/domain/repositories/tafseer/tafseer_repository.dart';
import 'package:quran_majeed/domain/repositories/translation/i_translation_and_tafseer_repository.dart';
import 'package:quran_majeed/domain/repositories/translation/translation_repository.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';
import 'package:quran_majeed/domain/repositories/word_by_word_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';
import 'package:quran_majeed/domain/service/file_service.dart';
import 'package:quran_majeed/domain/service/notification_service.dart';
import 'package:quran_majeed/domain/use_cases/audio/add_to_playlist_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/clear_playlist_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/create_audio_file_path_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/delete_audio_by_surah_and_reciter.dart';
import 'package:quran_majeed/domain/use_cases/audio/download_and_save_audio_location_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/fetch_audio_files_and_verse_timings_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/get_audio_files_by_surah_and_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/get_audio_path_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/get_verse_timings_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/is_surah_audio_available_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/pause_playback_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/get_surah_ids_for_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/manage_reciters_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/play_surah_audio_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/play_verse_with_delay_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/manage_selected_reciter_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/save_download_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/resume_playback_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/seek_audio_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/stop_audio_use_case.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/create_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/delete_ayah_from_bookmar_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/delete_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_all_bookmark_entries.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_all_bookmark_folders.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_ayah_list_by_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/get_bookmarks_by_surah_and_ayah.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/migrate_old_bookmarks_use_case.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/save_bookmarks_to_ayah.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/search_bookmark.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/sort_bookmark.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/update_bookmark_folder.dart';
import 'package:quran_majeed/domain/use_cases/collection/check_authentication_status.dart';
import 'package:quran_majeed/domain/use_cases/collection/export_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/import_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/sign_in_user.dart';
import 'package:quran_majeed/domain/use_cases/collection/sign_out_user.dart';
import 'package:quran_majeed/domain/use_cases/collection/sync_collections.dart';
import 'package:quran_majeed/domain/use_cases/collection/bookmarks/validate_folder_name.dart';
import 'package:quran_majeed/domain/use_cases/get_all_surahs_use_case.dart';
import 'package:quran_majeed/domain/use_cases/info/ask_review_if_necessary.dart';
import 'package:quran_majeed/domain/use_cases/info/close_announcement.dart';
import 'package:quran_majeed/domain/use_cases/info/get_annoucement.dart';
import 'package:quran_majeed/domain/use_cases/info/review_ask_count_service.dart';
import 'package:quran_majeed/domain/use_cases/notification/daily_ayah_use_case.dart';
import 'package:quran_majeed/domain/use_cases/notification/schedule_notification.dart';
import 'package:quran_majeed/domain/use_cases/notification/set_up_push_notification.dart';
import 'package:quran_majeed/domain/use_cases/settings/get_setting_use_case.dart';
import 'package:quran_majeed/domain/use_cases/info/needs_migration_use_case.dart';
import 'package:quran_majeed/domain/use_cases/info/save_needs_migration_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/delete_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/download_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_available_wbw_languages_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_downloaded_wbw_languages_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_selected_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_words_for_surah.dart';
import 'package:quran_majeed/domain/use_cases/info/determine_first_run.dart';
import 'package:quran_majeed/domain/use_cases/info/save_first_time.dart';
import 'package:quran_majeed/domain/use_cases/info/set_up_app.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/get_reciters_from_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/audio/reciters/save_reciter_with_surah_id_use_case.dart';
import 'package:quran_majeed/domain/use_cases/settings/listen_settings_changes.dart';
import 'package:quran_majeed/domain/use_cases/preload_adjacent_surahs.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/delete_available_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/delete_tafseer_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/determine_if_its_first_time_in_tafseer_page.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/fetch_available_tafseer_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_default_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_downloaded_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_selected_tab_index_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_selected_tafseers_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/get_unique_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_available_tafseer_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_available_tafseer_items_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_selected_tab_index_use_case.dart';
import 'package:quran_majeed/domain/use_cases/tafseer/save_selected_tafseers_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/delete_available_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/delete_translation_database_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/fetch_available_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_default_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_downloaded_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_non_default_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_selected_translations_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/get_translation_and_tafseer_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_available_items_count_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_available_translation_items_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/save_selected_translations_use_case.dart';
import 'package:quran_majeed/domain/use_cases/translation/select_translation_use_case.dart';
import 'package:quran_majeed/domain/use_cases/settings/update_setting_use_case.dart';

import 'package:quran_majeed/domain/use_cases/user_data/delete_last_reads.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_words_for_surah_ayah.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/set_selected_wbw_language_use_case.dart';
import 'package:quran_majeed/firebase_option.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/daily_ayah/presenter/daily_ayah_presenter.dart';
import 'package:quran_majeed/presentation/dua/presenter/dua_presenter.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_presenter.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';
import 'package:quran_majeed/presentation/notification/services/notification_service_presentable.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/search/presenter/search_presenter.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/shane_nuzul/presenter/shane_nuzul_presenter.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_presenter.dart';
import '../../domain/use_cases/memorization/memorization_user_case.dart';
import '../../domain/use_cases/user_data/get_last_read.dart';
import '../../domain/use_cases/user_data/save_last_read.dart';

// Implementation Note:
//
// The app utilizes the **Service Locator Pattern** to manage dependencies.
//
// The Service Locator Pattern is a design pattern that improves modularity and
// maintainability in our codebase. By decoupling the code from direct dependency
// references, it allows for easier substitution or addition of dependencies in
// the future.
//
// To understand the Service Locator Pattern in more detail, you can refer to
// the following resource: https://stackify.com/service-locator-pattern/.
//
// This pattern simplifies the process of replacing or adding dependencies.
// Instead of modifying every object that relies on a particular dependency, we
// only need to update the service locator itself. This centralization reduces
// code changes and minimizes potential errors.
final GetIt _serviceLocator = GetIt.instance;

// This code implements a wrapper function around the `get` function from the
// `get_it` package. The purpose of this wrapper is to provide a simplified and
// centralized way of retrieving registered instances of classes.
//
// By using this wrapper instead of directly calling the get function, we avoid
// tight coupling to the specific service locator implementation, which can lead
// to vendor lock-in. This abstraction allows for flexibility in choosing a
// different service locator plugin in the future if needed.
//
// The wrapper function encapsulates the complexity of the service locator and
// provides a cleaner and more readable interface for retrieving dependencies
// throughout the codebase.

/// Provides a way to retrieve an instance of a class registered
/// with the service locator.
T locate<T extends Object>() => _serviceLocator.get<T>();

void dislocate<T extends BasePresenter>() => unloadPresenterManually<T>();

class ServiceLocator {
  ServiceLocator._();

  /// Sets up the whole dependency injection system by calling various setup
  /// methods in a certain order.
  ///
  /// Also provides an optional flag to only start services and skip the other
  /// setup steps.
  ///
  /// Ensures that all necessary dependencies are initialized before starting
  /// the application.
  static Future<void> setUp({bool startOnlyService = false}) async {
    final ServiceLocator locator = ServiceLocator._();
    await locator._setUpServices();
    if (startOnlyService) return;
    await locator._setUpDataSources();
    await locator._setUpRepositories();
    await locator._setUpUseCase();
    await locator._setUpPresenters();
  }

  Future<void> _setUpFirebaseServices() async {
    await catchFutureOrVoid(() async {
      final FirebaseApp? firebaseApp = await catchAndReturnFuture(() async {
        return Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      });
      if (firebaseApp == null) return;
      if (kDebugMode) return;

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
          printDetails: true,
        );
        return true;
      };
    });
  }

  Future<void> _setUpAudioService() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ihadis.quran.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }

  Future<void> _setUpRepositories() async {
    _serviceLocator
      ..registerLazySingleton<SurahRepository>(
        () => SurahRepositoryImpl(locate()),
      )
      ..registerLazySingleton<NotificationRepository>(
        () => NotificationRepositoryImpl(
          locate(),
          locate(),
          locate(),
          locate(),
        ),
      )
      ..registerLazySingleton<TranslationRepository>(
        () => TranslationRepositoryImpl(
          locate(),
          locate(),
          locate(),
        ),
      )
      ..registerLazySingleton<DailyAyahRepository>(
        () => DailyAyahRepositoryImpl(
          locate(),
        ),
      )
      ..registerLazySingleton<TafseerRepository>(
        () => TafseerRepositoryImpl(
          locate(),
          locate(),
          locate(),
          locate(),
        ),
      )
      ..registerLazySingleton<UserDataRepository>(
        () => UserDataRepositoryImpl(
          locate(),
          locate(),
          locate(),
        ),
      )
      ..registerLazySingleton<InfoRepository>(
        () => InfoRepositoryImpl(
          locate(),
          locate(),
        ),
      )
      ..registerLazySingleton<NotificationService>(
        () => NotificationServicePresentable(locate(), locate()),
      )
      ..registerLazySingleton<MemorizationRepositoryImpl>(
        () => MemorizationRepositoryImpl(
          locate(),
        ),
      )
      ..registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
            locate(),
            locate(),
          ))
      ..registerLazySingleton<AudioRepository>(() => AudioRepositoryImpl(
            locate(),
            locate(),
          ))
      ..registerLazySingleton<WordByWordRepository>(
          () => WordByWordRepositoryImpl(
                locate(),
                locate(),
                locate(),
              ))
      ..registerLazySingleton<ReciterRepository>(() => ReciterRepositoryImpl(
            locate(),
            locate(),
          ))
      ..registerLazySingleton<ITranslationAndTafseerRepository>(
          () => TranslationAndTafseerRepository(
                locate(),
              ))
      ..registerLazySingleton<MemorizationRepository>(
          () => MemorizationRepositoryImpl(
                locate(),
              ))
      ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
            locate(),
            locate(),
          ))
      ..registerLazySingleton<ITranslationAndTafseerLocalDataSource>(
          () => TranslationAndTafseerLocalDataSource());
    final NotificationService notificationService = locate();
    await notificationService.setUp();
  }

  Future<void> _setUpServices() async {
    await _setUpAudioService();
    await _setUpFirebaseServices();
    _serviceLocator
      ..registerLazySingleton(QuranDatabase.new)
      ..registerLazySingleton(UserDataStorage.new)
      ..registerLazySingleton(LocalCacheService.new)
      ..registerLazySingleton<ErrorMessageHandler>(ErrorMessageHandlerImpl.new)
      ..registerSingleton<AwesomeNotifications>(AwesomeNotifications())
      ..registerLazySingleton(BackendAsAService.new)
      ..registerLazySingleton(() => ReviewAskCountService(locate()))
      ..registerLazySingleton(() => InAppReview.instance)
      ..registerLazySingleton(CacheData.new)
      ..registerFactory<FileService>(() => FileServicePresentable())
      ..registerLazySingleton<Dio>(() => Dio());

    await LocalCacheService.setUp();
  }

  Future<void> _setUpDataSources() async {
    _serviceLocator
      ..registerLazySingleton(() => SurahLocalDataSource(locate()))
      ..registerLazySingleton(() => AudioLocalDataSource(
            locate(),
            locate(),
          ))
      ..registerLazySingleton(() => DailyAyahLocalDataSource(
            locate(),
          ))
      ..registerLazySingleton(() => AudioRemoteDataSource())
      ..registerLazySingleton(() => InfoRemoteDataSource(locate()))
      ..registerLazySingleton(() => InfoLocalDataSource(
            locate(),
            locate(),
          ))
      ..registerLazySingleton(() => TafseerLocalDataSource())
      ..registerLazySingleton(() => TranslationLocalDataSource(locate()))
      ..registerLazySingleton(() => TranslationAndTafseerRemoteDataSource())
      ..registerLazySingleton(() => WordbyWordLocalDataSource(locate()))
      ..registerLazySingleton(() => WbwRemoteDataSource())
      ..registerLazySingleton(() => UserDataLocalDataSource(
            locate(),
            locate(),
          ))
      ..registerLazySingleton(() => UserDataRemoteDataSource(
            locate(),
          ))
      ..registerLazySingleton(() => ReciterLocalDataSource(locate()))
      ..registerLazySingleton(
        () => MemorizationLocalDataSource(
          locate(),
        ),
      );
  }

  Future<void> _setUpPresenters() async {
    _serviceLocator
      ..registerFactory(() => loadPresenter(HomePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(AyahPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(TafseerPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(DailyAyahPresenter(
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(ShaneNuzulPresenter()))
      // ..registerLazySingleton(() => loadPresenter(SubjectwiseQuranPresenter()))
      ..registerLazySingleton(() => loadPresenter(LastReadPresenter(
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(MemorizationPresenter()))
      ..registerLazySingleton(() => loadPresenter(CollectionPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(
        () => loadPresenter(OnBoardingPresenter(
          locate(),
          locate(),
          locate(),
        )),
      )
      ..registerLazySingleton(() => loadPresenter(SettingsPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(WordByWordPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(MainPagePresenter()))
      ..registerLazySingleton(() => loadPresenter(AudioPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(ReciterPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(TranslationPresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(DuaPresenter()))
      ..registerLazySingleton(() => loadPresenter(SearchPresenter()))
      ..registerLazySingleton(() => loadPresenter(MoreMenuPresenter()));
  }

  Future<void> _setUpUseCase() async {
    _serviceLocator
      ..registerFactory(() => GetSettingsStateUseCase(locate(), locate()))
      ..registerFactory(() => GetAllSurahsUseCase(locate(), locate()))
      ..registerFactory(() => UpdateSettingsUseCase(locate(), locate()))
      ..registerFactory(() => DetermineFirstRun(locate(), locate()))
      ..registerFactory(() => SetUpAppUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveFirstTimeUseCase(locate(), locate()))
      ..registerFactory(() => SaveLastReadUseCase(locate(), locate()))
      ..registerFactory(() => GetLastReadsUseCase(locate(), locate()))
      ..registerFactory(() => DeleteLastReadUseCase(locate(), locate()))
      ..registerFactory(() => GetDefaultTranslationUseCase(locate(), locate()))
      ..registerFactory(
          () => GetNonDefaultTranslationUseCase(locate(), locate()))
      ..registerFactory(
          () => GetDownloadedTranslationsUseCase(locate(), locate()))
      ..registerFactory(
          () => GetTranslationAndTafseerUseCase(locate(), locate()))
      ..registerFactory(
          () => DeleteTranslationDatabaseUseCase(locate(), locate()))
      ..registerFactory(
          () => SaveAvailableTranslationItemsUseCase(locate(), locate()))
      ..registerFactory(() => SelectTranslationUseCase(locate(), locate()))
      ..registerFactory(
          () => DeleteAvailableTranslationUseCase(locate(), locate()))
      ..registerFactory(
          () => SaveSelectedTranslationsUseCase(locate(), locate()))
      ..registerFactory(
          () => GetSelectedTranslationsUseCase(locate(), locate()))
      ..registerFactory(() => PlaySurahAudioUseCase(locate(), locate()))
      ..registerFactory(() => IsSurahAudioAvailableUseCase(locate(), locate()))
      ..registerFactory(() => PlayVerseWithDelayUseCase(locate(), locate()))
      ..registerFactory(
          () => DownloadAndSaveAudioLocationUseCase(locate(), locate()))
      ..registerFactory(() => GetAudioPathUseCase(locate(), locate()))
      ..registerFactory(() => AddToPlaylistUseCase(locate(), locate()))
      ..registerFactory(
          () => GetAudioFilesBySurahAndReciterUseCase(locate(), locate()))
      ..registerFactory(() => GetVerseTimingsUseCase(locate(), locate()))
      ..registerFactory(() => SeekAudioUseCase(locate(), locate()))
      ..registerFactory(
          () => GetRecitersFromDatabaseUseCase(locate(), locate()))
      ..registerFactory(() => ManageRecitersUseCase(locate(), locate()))
      ..registerFactory(() => SaveDownloadCountUseCase(locate(), locate()))
      ..registerFactory(() => ManageSelectedReciterUseCase(locate(), locate()))
      ..registerFactory(() => SaveReciterWithSurahIdUseCase(locate(), locate()))
      ..registerFactory(() => GetSurahIdsForReciterUseCase(locate(), locate()))
      ..registerFactory(() => ClearPlaylistUseCase(locate(), locate()))
      ..registerFactory(() => CreateAudioFilePathUseCase(locate(), locate()))
      ..registerFactory(() => StopAudioUseCase(locate(), locate()))
      ..registerFactory(() => PausePlaybackUseCase(locate(), locate()))
      ..registerFactory(() => ResumePlaybackUseCase(locate(), locate()))
      ..registerFactory(() => FetchAudioFilesAndVerseTimingsUseCase(
            locate(),
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetDownloadedTafseerUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteAvailableTafseerUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteTafseerDatabaseUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveSelectedTafseersUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetTafseerUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetSelectedTafseersUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveAvailableTafseerItemsUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetUniqueTafseerUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetDefaultTafseerUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DetermineIfItsFirstTimeInTafseerPage(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveSelectedTabIndexUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetSelectedTabIndexUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveAvailableItemsCountUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => FetchAvailableItemsCountUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveAvailableTafseerItemsCountUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => FetchAvailableTafseerItemsCountUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => ListenSettingsChangesUseCase(
            locate(),
          ))
      ..registerFactory(() => GetAllBookmarkFoldersUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => ValidateFolderNameUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => CreateBookmarkFolderUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveBookmarksToAyahUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SyncCollectionUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteBookmarkFolderUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => UpdateBookmarkFolderUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SearchBookmarkUseCase(
            locate(),
          ))
      ..registerFactory(() => SortBookmarkUseCase(
            locate(),
          ))
      ..registerFactory(() => SignInUserUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SignOutUserUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => CheckAuthenticationStatusUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetBookmarksBySurahAndAyahUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetWordsForSurah(
            locate(),
            locate(),
          ))
      ..registerFactory(() => PreloadAdjacentSurahs(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetAllBookmarkEntries(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetWordsForSurahAyah(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetAyahListByBookmarkFolder(
            locate(),
            locate(),
          ))
      ..registerFactory(() => NeedsMigration(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SaveNeedsMigration(
            locate(),
            locate(),
          ))
      ..registerFactory(() => MigrateOldBookmarks(
            locate(),
            locate(),
          ))
      ..registerFactory(() => ExportCollectionsUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => ImportCollectionsUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteAyahFromBookmarksUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteAudioBySurahAndReciter(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetAvailableWbwLanguagesUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetDownloadedWbwLanguagesUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DownloadWbwLanguageUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => DeleteWbwLanguageUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => SetSelectedWbwLanguageUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetSelectedWbwLanguageUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => CloseAnnouncementUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetAnnouncementUseCase(
            locate(),
            locate(),
            locate(),
          ))
      ..registerFactory(() => SetUpPushNotificationUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => AskReviewIfNecessaryUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => GetDailyAyahUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => ScheduleNotificationUseCase(
            locate(),
            locate(),
          ))
      ..registerFactory(() => MemorizationUseCase());
  }
}
