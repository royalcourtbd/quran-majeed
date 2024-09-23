import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/search/presenter/search_presenter.dart';
import 'package:quran_majeed/presentation/search/widgets/search_header_text_widget.dart';

class SearchHistoryPage extends StatelessWidget {
  SearchHistoryPage({
    super.key,
  });
//Dummy data
  final List<Map<String, dynamic>> data = [
    {
      'header': 'Today',
      'items': [
        {
          'icon': SvgPath.icTranslation,
          'title': 'Allah',
          'subtitle': '1 mins ago | Translation'
        },
        {
          'icon': SvgPath.icTimer,
          'title': 'الْـخَـبِـيـرُ بِـمَا تَـفْـعَـلُـونَ',
          'subtitle': '10:52 AM | Arabic'
        },
        {
          'icon': SvgPath.icTimer,
          'title': 'بِـسْمِ',
          'subtitle': '10:52 AM | Arabic'
        },
        {
          'icon': SvgPath.icTranslation,
          'title':
              'Prophet Muhammad (PBUH)Prophet Muhammad (PBUH) Prophet Muhammad (PBUH)',
          'subtitle': '2 mins ago | Hadith'
        },
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Surah Al-Fatiha',
          'subtitle': '3 mins ago | Quran'
        },
      ],
    },
    {
      'header': 'Yesterday',
      'items': [
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Allah knows...',
          'subtitle': '2:56 PM | Tafseer'
        },
        {
          'icon': SvgPath.icTranslation,
          'title': 'He is the Most Merciful',
          'subtitle': '1:15 PM | Translation'
        },
        {
          'icon': SvgPath.icTimer,
          'title': 'وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا',
          'subtitle': '11:30 AM | Arabic'
        },
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Surah An-Nas',
          'subtitle': '10:00 AM | Quran'
        },
      ],
    },
    {
      'header': 'Last Week',
      'items': [
        {
          'icon': SvgPath.icTranslation,
          'title': 'Faith',
          'subtitle': 'Monday | Translation'
        },
        {
          'icon': SvgPath.icTimer,
          'title': 'إِنَّ اللّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          'subtitle': 'Tuesday | Arabic'
        },
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Surah Al-Baqarah',
          'subtitle': 'Wednesday | Quran'
        },
        {
          'icon': SvgPath.icTranslation,
          'title': 'Gratitude',
          'subtitle': 'Thursday | Translation'
        },
      ],
    },
    {
      'header': 'Last Month',
      'items': [
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Surah Al-Ikhlas',
          'subtitle': '1st May | Quran'
        },
        {
          'icon': SvgPath.icTranslation,
          'title': 'Patience',
          'subtitle': '15th May | Translation'
        },
        {
          'icon': SvgPath.icTimer,
          'title': 'اللّهُ نُورُ السَّمَاوَاتِ وَالْأَرْضِ',
          'subtitle': '20th May | Arabic'
        },
        {
          'icon': SvgPath.icOpenBookOutline,
          'title': 'Surah Al-Kahf',
          'subtitle': '25th May | Quran'
        },
      ],
    },
  ];

  late final SearchPresenter searchPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        title: 'Search History',
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icEdit,
            onIconTap: () {
              RemoveDialog.show(
                context: context,
                title: 'Search History',
                onRemove: () async {},
              );
            },
          ),
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icFilter,
            onIconTap: () => searchPresenter.onClickSearchFilter(context),
          ),
          gapW8,
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, sectionIndex) {
          final section = data[sectionIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchHeaderTextWidget(
                title: section['header'] ?? 'Placeholder Header',
                theme: theme,
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: sixteenPx, vertical: fivePx),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: section['items'].length,
                itemBuilder: (context, itemIndex) {
                  final item = section['items'][itemIndex];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: tenPx, horizontal: fivePx),
                    child: Row(
                      children: [
                        Container(
                            padding: padding8,
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: radius8,
                            ),
                            child: SvgImage(
                              item['icon'],
                              width: twentyPx,
                              height: twentyPx,
                              color: context.color.primaryColor,
                            )),
                        gapW15,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontFamily.meQuran,
                                ),
                              ),
                              gapH2,
                              Text(
                                item['subtitle'],
                                style:
                                    context.quranText.lableExtraSmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: context.color.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
