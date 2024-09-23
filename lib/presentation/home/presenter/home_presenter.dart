import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/home_category_model.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';
import 'package:quran_majeed/domain/entities/notification/announcement_entity.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/domain/use_cases/get_all_surahs_use_case.dart';
import 'package:quran_majeed/domain/use_cases/info/ask_review_if_necessary.dart';
import 'package:quran_majeed/domain/use_cases/info/close_announcement.dart';
import 'package:quran_majeed/domain/use_cases/info/get_annoucement.dart';
import 'package:quran_majeed/domain/use_cases/notification/set_up_push_notification.dart';
import 'package:quran_majeed/presentation/ayah_detail/ui/ayah_details_page.dart';
import 'package:quran_majeed/presentation/home/presenter/home_ui_state.dart';
import 'package:quran_majeed/presentation/home/widgets/suah_list_view.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_presenter.dart';
import 'package:quran_majeed/presentation/last_read/ui/last_read_page.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/our_projects.dart';
import 'package:quran_majeed/presentation/shane_nuzul/ui/shane_nuzul_detail_page.dart';

class HomePresenter extends BasePresenter<HomeUiState> {
  HomePresenter(
    this._allSurahsUseCase,
    this._getAnnouncement,
    this._closeAnnouncement,
    this._setUpPushNotificationUseCase,
    this._askReviewIfNecessary,
  );
  final GetAllSurahsUseCase _allSurahsUseCase;
  final GetAnnouncementUseCase _getAnnouncement;
  final CloseAnnouncementUseCase _closeAnnouncement;

  RxInt bottomBarCurrentIndex = 0.obs;

  final Obs<HomeUiState> uiState = Obs(HomeUiState.empty());
  late final MainPagePresenter drawerPresenter = locate<MainPagePresenter>();

  HomeUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async =>
      await showMessage(message: message);

  void changeTabIndex(int index) {
    uiState.value = currentUiState.copyWith(tabButtonCurrentIndex: index);
  }

  @override
  Future<void> onInit() async {
    // getCategoryList();
    await _fetchHomePageData();
    hideStatusBar();
    super.onInit();
  }

  Future<void> _fetchHomePageData() async {
    await toggleLoading(loading: true);
    await getSurahList();
    await _fetchAnnouncements();
    await _setUpPushNotification();
    await toggleLoading(loading: false);
  }

  getDashboardItem({
    required int index,
    required BuildContext context,
  }) {
    switch (index) {
      case 0:
        return HomeCategoryModel(
          title: context.l10n.last,
          iconPath: SvgPath.icLastRead,
          category: QuranCategory.last,
        );
      case 1:
        return HomeCategoryModel(
          title: context.l10n.musaf,
          iconPath: SvgPath.icMusaf,
          category: QuranCategory.musaf,
        );
      case 2:
        return HomeCategoryModel(
          title: context.l10n.hifz,
          iconPath: SvgPath.icHifz,
          category: QuranCategory.hifz,
        );
      case 3:
        return HomeCategoryModel(
          title: context.l10n.support,
          iconPath: SvgPath.icSupport,
          category: QuranCategory.support,
        );
      case 4:
        return HomeCategoryModel(
          title: context.l10n.apps,
          iconPath: SvgPath.icmoreApp,
          category: QuranCategory.apps,
        );
      case 5:
        return HomeCategoryModel(
          title: context.l10n.duas,
          iconPath: SvgPath.icDua,
          category: QuranCategory.duas,
        );

      case 6:
        return HomeCategoryModel(
          title: context.l10n.nuzul,
          iconPath: SvgPath.icNuzul,
          category: QuranCategory.nuzul,
        );
      case 7:
        return HomeCategoryModel(
          title: context.l10n.info,
          iconPath: SvgPath.icInfo,
          category: QuranCategory.info,
        );
      default:
        throw Exception('Invalid index');
    }
  }

  String getQuickAccessSurahName({
    required int surahNumber,
    required BuildContext context,
  }) {
    switch (surahNumber) {
      case 67:
        return context.l10n.alMulk;
      case 18:
        return context.l10n.alKahf;
      case 36:
        return context.l10n.yasin;
      case 112:
        return context.l10n.alIkhlas;
      case 32:
        return context.l10n.asSajdah;
      case 56:
        return context.l10n.alWaqiah;
      default:
        return 'Invalid Surah';
    }
  }

  final SetUpPushNotificationUseCase _setUpPushNotificationUseCase;

  Future<void> _setUpPushNotification() async {
    await _setUpPushNotificationUseCase.execute();
  }

  final AskReviewIfNecessaryUseCase _askReviewIfNecessary;

  Future<void> askForReview({required VoidCallback askForReview}) async {
    await Future<void>.delayed(5.inSeconds);
    await _askReviewIfNecessary.execute(askForReview: askForReview);
  }

  @override
  void onClose() {
    _fetchAnnouncementsSub?.cancel();
    super.onClose();
  }

  StreamSubscription<Either<String, AnnouncementEntity>>?
      _fetchAnnouncementsSub;

  Future<void> _fetchAnnouncements() async {
    await handleStreamEvents(
      stream: _getAnnouncement.execute(),
      onData: (data) =>
          uiState.value = currentUiState.copyWith(announcement: data),
      subscription: _fetchAnnouncementsSub,
    );
  }

  Future<void> closeNoticeBox({bool userSeen = false}) async {
    await parseDataFromEitherWithUserMessage(
      task: () async => _closeAnnouncement.execute(userSeen: userSeen),
      onDataLoaded: (_) => uiState.value = currentUiState.copyWith(
        announcement: currentUiState.announcement.close(),
      ),
    );
  }

  String getSurahName({required int surahId, required String language}) {
    if (CacheData.surahsCache.isEmpty) {
      return '';
    }
    final SurahEntity surah = CacheData.surahsCache[surahId - 1];
    return language == 'bn' ? surah.nameBn : surah.nameEn;
  }

  Future<void> getSurahList() async {
    await _allSurahsUseCase.execute();
    uiState.value = currentUiState.copyWith(surahList: CacheData.surahsCache);
  }

  Color? getColor(BuildContext context, int currentIndex, int index) {
    return currentIndex == index
        ? context.color.whiteColor
        : context.color.subtitleColor;
  }

  Widget getContentWidget(int index) {
    switch (index) {
      case 0:
        return SurahListView(
          key: const Key("surah_list_view"),
          surahList: currentUiState.surahList,
        );
      case 1:
        return SurahListView(
          key: const Key("surah_list_view"),
          surahList: currentUiState.surahList,
        );
      case 2:
        return SurahListView(
          key: const Key("surah_list_view"),
          surahList: currentUiState.surahList,
        );
      default:
        return SurahListView(
          key: const Key("surah_list_view"),
          surahList: currentUiState.surahList,
        );
    }
  }

  Future<void> goToLastReadPage(BuildContext context) async {
    final LastReadPresenter lastReadPresenter = locate<LastReadPresenter>();
    await lastReadPresenter.getLastReadList();
    final List<LastReadEntity> lastReads =
        lastReadPresenter.uiState.value.lastReadList;
    if (lastReads.isEmpty) {
      addUserMessage("No last read found");
      return;
    }
    final LastReadPage lastReadPage = LastReadPage();
    if (context.mounted) {
      await context.navigatorPush(lastReadPage);
    }
  }

  void goToOurProjectsPage(BuildContext context) {
    final OurProjectsPage ourProjectsPage = OurProjectsPage();
    context.navigatorPush(ourProjectsPage);
  }

  Future<void> handleCategoryTap(
    BuildContext context,
    QuranCategory category,
  ) async {
    switch (category) {
      case QuranCategory.last:
        await goToLastReadPage(context);
        break;
      case QuranCategory.musaf:
        showComingSoonMessage(context: context);
        break;
      case QuranCategory.hifz:
        drawerPresenter.changeTabIndex(3);
        break;
      case QuranCategory.support:
        drawerPresenter.onClickSadaqa(context);
        break;
      case QuranCategory.apps:
        goToOurProjectsPage(context);
        break;
      case QuranCategory.duas:
      case QuranCategory.nuzul:
      case QuranCategory.info:
        showComingSoonMessage(context: context);
        break;
    }
  }

  void navigateToSurahDetails(BuildContext context, index) async {
    final AyahDetailsPage ayahPage =
        await Future.microtask(() => AyahDetailsPage(
              initialPageIndex: index,
              initialAyahIndex: 0,
            ));
    if (context.mounted) await context.navigatorPush<void>(ayahPage);
  }

  Future<void> goToSurahDetailsPageWithSpecificAyah({
    required BuildContext context,
    required int? surahIndex,
    required int? ayahIndex,
  }) async {
    final AyahDetailsPage ayahPage =
        await Future.microtask(() => AyahDetailsPage(
              initialPageIndex: surahIndex!,
              initialAyahIndex: ayahIndex!,
            ));
    if (context.mounted) await context.navigatorPush<void>(ayahPage);
  }

  void onTapOnSurahFromNuzul({
    required BuildContext context,
    required int index,
  }) async {
    final ShaneNuzulDetailPage shaneNuzulDetailsPage =
        await Future.microtask(() => ShaneNuzulDetailPage());

    if (context.mounted) {
      await context.navigatorPush<void>(shaneNuzulDetailsPage);
    }
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  List<String> quranTabButtonTextList = [
    'Surah',
    'Juz',
    'Pages',
    'Hizb',
  ];
}
