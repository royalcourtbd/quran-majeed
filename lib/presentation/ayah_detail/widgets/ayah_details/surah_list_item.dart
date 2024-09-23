import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';

class SurahListItem extends StatelessWidget {
  const SurahListItem({
    super.key,
    required this.surah,
    required this.index,
    this.onSelect,
    required this.theme,
    required this.selectedSurahIndex,
  });

  final SurahEntity surah;
  final int index;
  final VoidCallback? onSelect;
  final ThemeData theme;
  final int selectedSurahIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: tenPx),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          onSelect!();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: eightPx),
          decoration: BoxDecoration(
            borderRadius: radius5,
            color: index == selectedSurahIndex ? theme.cardColor : null,
          ),
          child: Text(
            '${surah.serial}.   ${getTranslatedSurahName(surah: surah, context: context)}',
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
