import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class AyahNoteDisplay extends StatelessWidget {
  const AyahNoteDisplay({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: QuranScreen.width,
      padding: EdgeInsets.only(
        left: twentyPx,
        right: twentyPx,
        bottom: fifteenPx,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(fivePx)),
      ),
      child: Text(
        'All praise is for Allah—Lord of all worlds,[[ i.e., Lord of everything in existence including angels, humans, and animals.]]',
        style: theme.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
