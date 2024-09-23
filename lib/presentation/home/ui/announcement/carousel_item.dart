import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.index,
    required this.ayah,
    required this.surahName,
    required this.theme,
    required this.homePresenter,
  });

  final int index;
  final AyahDatabaseTableData ayah;
  final String surahName;
  final ThemeData theme;
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    String currentLanguage = getCurrentLanguage(context);

    ///TODO: This is a temporary fix. The issue is that the trBn field is not nullable in the AyahDatabaseTableData class.
    String ayahText = currentLanguage == 'bn' ? ayah.trBn! : ayah.trEn!;
    return FadeIn(
      child: InkWell(
        onTap: () async =>
            await homePresenter.goToSurahDetailsPageWithSpecificAyah(
          context: context,
          surahIndex: ayah.surahId! - 1,
          ayahIndex: ayah.ayahID! - 1,
        ),
        key: Key("quran_slider_$index"),
        child: SizedBox(
          width: QuranScreen.width - 70,
          child: Text(
            "$ayahText \n\n [$surahName ${ayah.surahId}:${ayah.ayahID}]",
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.whiteColor.withOpacity(0.7),
              height: 1.7,
            ),
          ),
        ),
      ),
    );
  }
}
