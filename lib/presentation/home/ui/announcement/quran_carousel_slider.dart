import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/carousel_slider/carousel_slider.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/presenter/home_ui_state.dart';
import 'carousel_item.dart';

class QuranCarouselSlider extends StatelessWidget {
  const QuranCarouselSlider({
    super.key,
    required this.theme,
    required this.ayahList,
    required this.homePresenter,
  });

  final ThemeData theme;
  final List<AyahDatabaseTableData> ayahList;
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    if (CacheData.surahsCache.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: PresentableWidgetBuilder(
        presenter: homePresenter,
        builder: () {
          final HomeUiState uiState = homePresenter.currentUiState;
          if (uiState.announcement.ayahList.isEmpty) {
            return const SizedBox();
          }
          final String language = getCurrentLanguage(context);
          return CarouselSlider.builder(
            itemBuilder: (__, index, _) {
              final AyahDatabaseTableData ayah =
                  uiState.announcement.ayahList[index];

              final String surahName = homePresenter.getSurahName(
                surahId: ayah.surahId!,
                language: language,
              );

              return CarouselItem(
                index: index,
                ayah: ayah,
                surahName: surahName,
                theme: theme,
                homePresenter: homePresenter,
              );
            },
            itemCount: uiState.announcement.ayahList.length,
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: 9.inSeconds,
              pauseAutoPlayOnTouch: false,
            ),
          );
        },
      ),
    );
  }
}
