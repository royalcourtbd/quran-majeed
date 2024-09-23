import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomScrollbar extends StatelessWidget {
  final String currentLetter;
  final Function(String) onLetterSelected;
  final ThemeData theme;

  const CustomScrollbar({
    super.key,
    required this.theme,
    required this.currentLetter,
    required this.onLetterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

    return Container(
      alignment: Alignment.center,
      width: twentyFivePx,
      padding: EdgeInsets.symmetric(vertical: tenPx),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: radius12,
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];
          final isSelected = letter == currentLetter;

          return GestureDetector(
            onTap: () => onLetterSelected(letter),
            child: Container(
              height: twentyPx,
              width: twentyFivePx,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: context.quranText.lableExtraSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? context.color.primaryColor
                      : context.color.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
