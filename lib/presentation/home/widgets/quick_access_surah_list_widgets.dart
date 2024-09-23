import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/home/widgets/surah_naavigation_row.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class QuickAccessSurahListWidgets extends StatelessWidget {
  const QuickAccessSurahListWidgets({
    super.key,
    required this.homePresenter,
  });
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: isMobile
              ? EdgeInsets.symmetric(horizontal: twentyPx, vertical: twelvePx)
              : EdgeInsets.only(left: tenPx),
          width: QuranScreen.width,
          child: Text(
            context.l10n.quickAccess,
            textAlign: TextAlign.start,
            style: theme.textTheme.titleMedium!,
          ),
        ),
        //isMobile ? gapH6 : gapH8,
        SurahNavigationRow(
          theme: theme,
          homePresenter: homePresenter,
        ),
      ],
    );
  }
}
