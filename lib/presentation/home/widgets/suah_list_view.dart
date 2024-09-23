import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/widgets/surah_mobile_list_widget.dart';
import 'package:quran_majeed/presentation/home/widgets/tab_surah_grid_widget.dart';

class SurahListView extends StatelessWidget {
  SurahListView({
    super.key,
    required this.surahList,
    this.isHomeSurahList = true,
  });
  final bool? isHomeSurahList;
  final List<SurahEntity> surahList;
  final HomePresenter _homePresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return surahList.isEmpty
        ? LoadingIndicator(color: context.color.primaryColor, theme: theme)
        : isMobile
            ? SurahListViewWidget(
                surahList: surahList,
                theme: theme,
                homePresenter: _homePresenter,
                isHomeSurahList: isHomeSurahList,
              )
            : SurahTabGridWidget(
                surahList: surahList,
                theme: theme,
                homePresenter: _homePresenter,
              );
  }
}
