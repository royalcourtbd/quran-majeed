import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class SurahNavigationRow extends StatelessWidget {
  const SurahNavigationRow({
    super.key,
    required this.theme,
    this.leftPadding,
    required this.homePresenter,
  });

  final ThemeData theme;
  final double? leftPadding;
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    final List<int> quickSurahNumbers = [67, 18, 36, 112, 32, 56];

    return SizedBox(
      height: isMobile ? thirtyTwoPx : twentyPx,
      child: ListView.builder(
        padding: EdgeInsets.only(left: leftPadding ?? twentyPx),
        shrinkWrap: true,
        itemCount: quickSurahNumbers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final surahNumber = quickSurahNumbers[index];
          final surahName = homePresenter.getQuickAccessSurahName(
              surahNumber: surahNumber, context: context);
          return InkWell(
            onTap: () =>
                homePresenter.navigateToSurahDetails(context, surahNumber - 1),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? twelvePx : eightPx,
              ),
              margin: EdgeInsets.only(right: isMobile ? tenPx : fivePx),
              decoration: BoxDecoration(
                borderRadius: isMobile ? radius8 : radius4,
                color: theme.cardColor,
              ),
              child: Text(
                surahName,
                style: theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.color.subtitleColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
