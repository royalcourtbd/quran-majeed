import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/daily_ayah/presenter/daily_ayah_presenter.dart';
import 'package:quran_majeed/presentation/daily_ayah/presenter/daily_ayah_ui_state.dart';
import 'package:quran_majeed/presentation/daily_ayah/widget/daily_ayah_custom_button.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';

class DailyAyahPage extends StatelessWidget {
  DailyAyahPage({super.key});
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  late final DailyAyahPresenter _dailyAyahPresenter = locate();
  late final AyahPresenter _ayahPresenter = locate();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      key: globalKey,
      endDrawer: MiniSettingsDrawer(),
      appBar: CustomAppBar(
        theme: theme,
        title: context.l10n.dailyAyah,
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icSettings,
            onIconTap: () => globalKey.currentState!.openEndDrawer(),
          ),
          gapW8,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PresentableWidgetBuilder(
                      presenter: _dailyAyahPresenter,
                      builder: () {
                        final DailyAyahUiState state =
                            _dailyAyahPresenter.currentUiState;
                        return AyahContainer(
                          index: 2,
                          surahID: state.surahID,
                          ayahNumber: state.ayahID,
                          ayahTopRowTitle:
                              '${CacheData.surahsCache[state.surahID - 1].nameEn} ${state.surahID} : ${state.ayahID}',
                          wordData: state.wordByWordEntity!,
                          onClickMore: () =>
                              _dailyAyahPresenter.onClickMoreButton(
                            context: context,
                            surahID: state.surahID,
                            ayahID: state.ayahID,
                            listOfWordByWordEntity: state.wordByWordEntity!,
                            isDirectButtonVisible: true,
                            idAddCollectionButtonVisible: true,
                            isAddMemorizationButtonVisible: true,
                          ),
                          ayahPresenter: _ayahPresenter,
                          theme: theme,
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: padding20,
        child: Row(
          children: [
            DailyAyahCustomButton(
              title: context.l10n.share,
              icon: SvgPath.icShare2,
              onTap: () async {
                await _dailyAyahPresenter.shareAyah();
              },
              theme: theme,
            ),
            gapW10,
            DailyAyahCustomButton(
              title: context.l10n.refresh,
              icon: SvgPath.icRefresh,
              onTap: () async {
                await _dailyAyahPresenter.fetchDailyAyah();
              },
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}
