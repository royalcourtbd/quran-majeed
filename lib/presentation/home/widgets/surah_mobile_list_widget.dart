import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/common/show_surah_number_widget.dart';
import 'package:quran_majeed/presentation/common/surah_detail_widget.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class SurahListViewWidget extends StatelessWidget {
  final List<SurahEntity> surahList;
  final ThemeData theme;
  final HomePresenter _homePresenter;
  final bool? isHomeSurahList;

  const SurahListViewWidget({
    super.key,
    required this.surahList,
    required this.theme,
    this.isHomeSurahList = true,
    required HomePresenter homePresenter,
  }) : _homePresenter = homePresenter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: surahList.length + 1,
      itemBuilder: (context, index) {
        if (index == surahList.length) {
          return Padding(
            padding: padding20,
            child: GestureDetector(
              onTap: () => launchFacebookGroup(),
              child: SvgPicture.asset(
                SvgPath.bgFbBanner,
                width: QuranScreen.width,
                height: 22.percentWidth,
                // fit: BoxFit.fill,
              ),
            ),
          );
        }

        final surah = surahList[index];
        // Optimize string formatting by pre-calculating outside of the return statement.
        final surahNumberFormatted = surah.serial.toString().padLeft(2, '0');
        final surahName = surah.serial.toString().padLeft(3, '0');

        return OnTapWidget(
          theme: theme,
          onTap: () => isHomeSurahList!
              ? _homePresenter.navigateToSurahDetails(context, index)
              : _homePresenter.onTapOnSurahFromNuzul(
                  context: context,
                  index: index,
                ),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: twentyPx, vertical: fourteenPx),
            child: Row(
              children: [
                ShowSurahNumberWidget(
                    formatSurahNumber: surahNumberFormatted, theme: theme),
                gapW18,
                SurahDetailWidget(
                  theme: theme,
                  surahName:
                      getTranslatedSurahName(surah: surah, context: context),
                  surahType: getSurahType(type: surah.type, context: context),
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
