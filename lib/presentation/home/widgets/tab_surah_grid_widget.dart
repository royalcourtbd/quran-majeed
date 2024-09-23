import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/common/show_surah_number_widget.dart';
import 'package:quran_majeed/presentation/common/surah_detail_widget.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class SurahTabGridWidget extends StatelessWidget {
  const SurahTabGridWidget(
      {super.key,
      required this.surahList,
      required this.theme,
      required this.homePresenter});

  final List<SurahEntity> surahList;
  final ThemeData theme;
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 10
            .percentWidth, // Ensure this is the intended usage, as it's uncommon.
        mainAxisSpacing: fivePx,
        crossAxisSpacing: fivePx,
      ),
      padding: EdgeInsets.symmetric(horizontal: tenPx),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: surahList.length,
      itemBuilder: (context, index) {
        final surah = surahList[index];
        // Pre-calculate values that depend on the current index but do not need to be recalculated within the itemBuilder.
        final String surahNumberFormatted =
            surah.serial < 10 ? '0${surah.serial}' : '${surah.serial}';
        final String surahName = surah.serial.toString().padLeft(3, '0');

        return OnTapWidget(
          theme: theme,
          onTap: () => homePresenter.navigateToSurahDetails(
            context,
            index,
          ),
          child: Container(
            padding: EdgeInsets.all(fivePx),
            decoration: BoxDecoration(
              borderRadius: radius5,
              border: Border.all(
                color: theme.cardColor.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowSurahNumberWidget(
                    formatSurahNumber: surahNumberFormatted, theme: theme),
                gapW5,
                SurahDetailWidget(
                  theme: theme,
                  surahName: surah.nameEn,
                  surahType: surah.type,
                  totalAyah: surah.totalAyah,
                ),
                const Spacer(),
                Text(
                  surahName,
                  style: context.quranText.surahName,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
