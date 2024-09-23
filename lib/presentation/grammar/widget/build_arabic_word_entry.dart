import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class BuildArabicWordEntry extends StatelessWidget {
  const BuildArabicWordEntry(
      {super.key, required this.index, required this.theme});
  final int index;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Al-'Ankabut 29:17",
                style: theme.textTheme.titleSmall!.copyWith(
                  color: context.color.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              gapH12,
              Text(
                "إِنَّمَاتَعۡبُدُونَمِندُونِٱللَّهِأَوۡثَٰنٗاوَتَخۡلُقُونَإِفۡكًاۚإِنَّٱلَّذِينَتَعۡبُدُونَمِندُونِٱللَّهِلَايَمۡلِكُونَلَكُمۡرِزۡقٗافَٱبۡتَغُواْعِندَٱللَّهِٱلرِّزۡقَوَٱعۡبُدُوهُوَٱشۡكُرُواْلَهُۥٓۖإِلَيۡهِتُرۡجَعُونَ",
                textDirection: TextDirection.rtl,
                softWrap: true,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: twentyFivePx,
                  fontFamily: FontFamily.kfgq,
                  fontWeight: FontWeight.w400,
                  height: twoPx,
                ),
              ),
            ],
          ),
        ),
        if (index != 1)
          Divider(
            color: context.color.primaryColor.withOpacity(0.2),
            height: twentyPx,
            thickness: 0.5,
          ),
      ],
    );
  }
}
