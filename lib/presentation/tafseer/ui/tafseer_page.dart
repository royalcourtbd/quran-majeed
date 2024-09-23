import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/core/utility/ui_helper.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/build_tafseer_tab_item.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/show_tafseer_ayah_widget.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/tafseer_add_more_tab.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/view_tafseer_details.dart';

class TafseerPage extends StatelessWidget {
  TafseerPage({
    super.key,
    required this.surahID,
    required this.ayahID,
  });

  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  late final TafseerPresenter _tafseerPresenter = locate<TafseerPresenter>();
  late final AyahPresenter _ayahPresenter = locate<AyahPresenter>();
  final int surahID;
  final int ayahID;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String currentLanguage = getCurrentLanguage(context);
    final String surahName = _tafseerPresenter.getSurahName(
      surahId: surahID,
      currentLanguage: currentLanguage,
    );
    final int totalAyahs = CacheData.surahsCache[surahID - 1].totalAyah;
    return Scaffold(
      key: globalKey,
      endDrawer: MiniSettingsDrawer(
          showOnlyFontSettings: true, showTafseerFontSlider: true),
      //TODO: ei version e bottom navigation bar er proyojon nei, tai comment kore rakha hoyeche
      // bottomNavigationBar: ColoredBox(
      //   color: context.color.primaryColor.withOpacity(0.05),
      //   child: TafseerBottomNavigationBar(
      //     ayahPresenter: _ayahPresenter,
      //     audioPresenter: _audioPresenter,
      //     theme: theme,
      //     isTafseerPage: true,
      //   ),
      // ),
      appBar: CustomAppBar(
        key: const Key('TafseerPageCustomAppBar'),
        theme: theme,
        title: surahName,
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icSettings,
            onIconTap: () => globalKey.currentState!.openEndDrawer(),
          ),
          gapW8,
        ],
      ),
      body: PresentableWidgetBuilder(
        key: const Key('PresentableWidgetBuilder'),
        presenter: _tafseerPresenter,
        onInit: () async {
          UiHelper.doOnPageLoaded(() {
            _tafseerPresenter.pageController.jumpToPage(ayahID - 1);
          });
        },
        builder: () {
          final uiState = _tafseerPresenter.currentUiState;

          if (uiState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: RoundedScaffoldBody(
                  key: const Key('TafseerPageRoundedScaffoldBody'),
                  isColored: true,
                  child: PageView.builder(
                    key: const Key('TafseerPageViewBuilder'),
                    itemCount: totalAyahs,
                    reverse: true,
                    controller: _tafseerPresenter.pageController,
                    itemBuilder: (context, pageNo) {
                      return NestedScrollView(
                        key: Key('TafseerPageNestedScrollView$pageNo'),
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            key: Key('TafseerPageSliverToBoxAdapter$pageNo'),
                            child: Column(
                              children: [
                                ShowTafseerAyahWidget(
                                  key: Key('ShowTafseerAyahWidget$pageNo'),
                                  theme: theme,
                                  surahName: surahName,
                                  ayahPresenter: _ayahPresenter,
                                  surahID: surahID,
                                  ayahID: pageNo + 1,
                                ),
                                //TODO: Uncomment this code after implementing the NoteDetailsWidget
                                // Divider(
                                //     color: context.color.primaryColor
                                //         .withOpacity(.1),
                                //     height: 1),
                                // NoteDetailsWidget(
                                //   key: Key('NoteDetailsWidget$pageNo'),
                                //   theme: theme,
                                //   tafseerPresenter: _tafseerPresenter,
                                // ),
                              ],
                            ),
                          ),
                        ],
                        body: ColoredBox(
                          color: context.color.primaryColor.withOpacity(0.05),
                          child: Column(
                            children: [
                              TabBar(
                                controller: _tafseerPresenter.tabController,
                                isScrollable: true,
                                unselectedLabelColor:
                                    theme.textTheme.bodyMedium!.color!,
                                dividerColor:
                                    context.color.primaryColor.withOpacity(0.1),
                                labelPadding: EdgeInsets.zero,
                                tabAlignment: TabAlignment.start,
                                onTap: (index) => _tafseerPresenter
                                    .onTafseerSelected(index, surahID),
                                tabs: List.generate(
                                  _tafseerPresenter.tabController.length,
                                  (index) {
                                    if (index < uiState.selectedItems.length) {
                                      return BuildTafseerTabItem(
                                        key: Key('BuildTafseerTabItem$index'),
                                        onClose: (index) async =>
                                            await _tafseerPresenter.closeTab(
                                                index, surahID),
                                        theme: theme,
                                        index: index,
                                        tafseerName:
                                            uiState.selectedItems[index].name,
                                        language: uiState
                                            .selectedItems[index].languageCode,
                                        activeTabIndex: uiState.activeTabIndex,
                                        selectedItemsLength:
                                            uiState.selectedItems.length,
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () => context.navigatorPush(
                                          DownloadPage(
                                            presenter: _tafseerPresenter,
                                            title: context.l10n.tafseer,
                                            isTafseer: true,
                                            surahID: surahID,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 40.percentWidth,
                                          child: TafseerAddMoreTab(
                                            key: Key('TafseerAddMoreTab$index'),
                                            theme: theme,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tafseerPresenter.tabController,
                                  key: Key('TabBarView$pageNo'),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                    _tafseerPresenter.tabController.length,
                                    (index) => ViewTafseerDetails(
                                      key: Key('ViewTafseerDetails$index'),
                                      theme: theme,
                                      surahID: surahID,
                                      ayahID: pageNo + 1,
                                      isLoading: uiState.isLoading,
                                      isTabChanged: uiState.isTabChanged,
                                      ayahPresenter: _ayahPresenter,
                                      tafsirText:
                                          _tafseerPresenter.getTafsirText(
                                        surahID,
                                        pageNo + 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
