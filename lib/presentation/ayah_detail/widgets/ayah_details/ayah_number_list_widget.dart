import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class AyahNumberListItem extends StatelessWidget {
  const AyahNumberListItem({
    super.key,
    required this.index,
    this.onSelect,
    required this.theme,
    required this.selectedAyahIndex,
  });

  final int index;
  final VoidCallback? onSelect;
  final ThemeData theme;
  final int selectedAyahIndex;

  @override
  Widget build(BuildContext context) {
    int ayahNumber = index + 1;
    return Padding(
      padding: EdgeInsets.only(bottom: tenPx),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          onSelect!();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: eightPx),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == selectedAyahIndex ? theme.cardColor : null,
            borderRadius: radius5,
          ),
          child: Text(
            ' $ayahNumber',
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
