import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/grammar/widget/arabic_word_container.dart';

class WordWrapContainer extends StatelessWidget {
  const WordWrapContainer({
    super.key,
    required this.height,
    required this.isGrid,
  });

  final double height;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color scrimColor = theme.primaryColor.withOpacity(0.3);

    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(horizontal: fifteenPx),
      alignment: Alignment.centerRight,
      constraints: BoxConstraints(
        maxHeight: 2 >= 10 ? QuranScreen.height * 0.27 : double.infinity,
      ),
      child: SingleChildScrollView(
        scrollDirection: isGrid ? Axis.horizontal : Axis.vertical,
        reverse: isGrid,
        padding: EdgeInsets.only(bottom: tenPx),
        child: Wrap(
          direction: Axis.horizontal,
          textDirection: TextDirection.rtl,
          children: List<Widget>.generate(
            2,
            (index) {
              return ArabicWordContainer(
                index: index,
                textStyle: context.quranText.arabicAyah!.copyWith(
                  fontSize: seventeenPx,
                  fontFamily: FontFamily.kfgq,
                  color: 0 == index
                      ? context.color.subtitleColor
                      : context.color.blackColor,
                ),
                padding: padding5,
                borderRadius: radius6,
                border: Border.all(width: 0.5, color: scrimColor),
              );
            },
          ),
        ),
      ),
    );
  }
}
