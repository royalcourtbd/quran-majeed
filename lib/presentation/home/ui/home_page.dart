import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/model_class/home_category_model.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/presenter/home_ui_state.dart';
import 'package:quran_majeed/presentation/home/widgets/quick_access_surah_list_widgets.dart';
import 'package:quran_majeed/presentation/home/ui/announcement/home_page_announcement.dart';
import 'package:quran_majeed/presentation/home/widgets/home_page_app_bar.dart';
import 'package:quran_majeed/presentation/home/widgets/home_page_dashboard.dart';
import 'package:quran_majeed/presentation/home/widgets/home_page_fancy_background.dart';
import 'package:quran_majeed/presentation/home/widgets/quran_tab_content_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePresenter _homePresenter = locate<HomePresenter>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _homePresenter,
      builder: () {
        final HomeUiState uiState = _homePresenter.uiState.value;
        final List<HomeCategoryModel> categoryList = uiState.homeCategoryList;

        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  key: const Key("nested_scroll_view"),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      key: const Key("sliver_to_box_adapter"),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              const StartPageFancyBackgroundColor(
                                key: Key("fancy_background_color"),
                              ),
                              const HomePageFancyBackgroundImage(
                                key: Key("fancy_background_image"),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: QuranScreen.height * 0.12),
                                  HomePageAnnouncement(
                                    key: const Key(
                                        "announcement_repaint_boundary"),
                                    theme: theme,
                                    homePresenter: _homePresenter,
                                    announcement: uiState.announcement,
                                    onClose: (_) => _homePresenter
                                        .closeNoticeBox(userSeen: true),
                                  ),
                                  gapH10,
                                  HomePageDashboard(
                                    key:
                                        const Key("dashboard_repaint_boundary"),
                                    theme: theme,
                                    homePresenter: _homePresenter,
                                    categoryList: categoryList,
                                  ),

                                  gapH12,

                                  ///TODO: Jokhon Surah /Juz Tab er Kaj complete hobe tokhon ei widget ta uncomment korte hobe
                                  /* gapH15,
                                  QuickAccessSurahListWidgets(
                                    homePresenter: _homePresenter,
                                  ),
                                  */
                                ],
                              ),
                              HomePageAppBar(theme: theme),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  body: Column(
                    children: [
                      ///TODO: Jokhon Surah /Juz Tab er Kaj complete hobe tokhon QuickAccessSurahListWidgets ta remove korte hobe

                      QuickAccessSurahListWidgets(
                        homePresenter: _homePresenter,
                      ),
                      gapH10,

                      ///TODO: Jokhon Surah /Juz Tab er Kaj complete hobe tokhon ei widget ta uncomment korte hobe
                      /*  gapH15,
                      QuranTabWidget(
                        theme: theme,
                        homePresenter: _homePresenter,
                      ),*/
                      gapH10,
                      QuranTabContentWidget(
                        currentTabIndex:
                            _homePresenter.currentUiState.tabButtonCurrentIndex,
                        homePresenter: _homePresenter,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
