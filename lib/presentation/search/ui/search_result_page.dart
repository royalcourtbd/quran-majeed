import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/positioned_scroll_bar.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/search/widgets/search_serult_over_view_card.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});
  late final AyahPresenter ayahPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        title: 'Search Result',
        subTitle: '16 Results Found',
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icSearch,
          ),
          gapW8,
        ],
      ),
      body: PositionedScrollBar(
        key: const Key('search_result_page'),
        controller: ayahPresenter.getScrollController(1),
        showScrollBar: true,
        listView: ScrollablePositionedList.builder(
            itemScrollController: ayahPresenter.getScrollController(1),
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, ayahIndex) {
              //TODO: Demo Data
              final bool isFirstAyah = ayahIndex == 0;
              final int ayahNumber = ayahIndex + 1;
              /////
              return Column(
                children: [
                  gapH10,
                  if (isFirstAyah)
                    SearchResultOverViewCard(
                      theme: theme,
                      query: 'Most Compassionate, Most Merciful.',
                    ),
                  AyahContainer(
                    index: ayahIndex,
                    surahID: 2,
                    ayahNumber: ayahNumber,
                    ayahTopRowTitle: 'Al-Baqarah 1:$ayahNumber',

                    wordData: const [],

                    isFromSpecificPage: true,

                    //TODO: Implement on More Button Click;
                    onClickMore: () => ayahPresenter.onClickMoreButton(
                      context: context,
                      surahID: 2,
                      ayahID: ayahIndex,
                      listOfWordByWordEntity: const [],
                      isDirectButtonVisible: true,
                      isAddMemorizationButtonVisible: false,
                      isAddCollectionButtonVisible: true,
                      isPlayButtonVisible: true,
                      isCopyAyahButtonVisible: true,
                    ),
                    ayahPresenter: ayahPresenter,
                    theme: theme,
                  ),
                  gapH15
                ],
              );
            }),
      ),
    );
  }
}
