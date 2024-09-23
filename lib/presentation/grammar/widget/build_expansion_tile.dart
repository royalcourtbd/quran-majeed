import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/presentation/grammar/widget/build_arabic_word_entry.dart';
import 'package:quran_majeed/presentation/grammar/widget/build_expansion_tile_title.dart';

class BuildExpansionTile extends StatelessWidget {
  const BuildExpansionTile(
      {super.key, required this.index, required this.theme});

  final int index;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final Color? backgroundColor =
        index.isEven ? theme.cardColor.withOpacity(0.5) : null;

    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      backgroundColor: backgroundColor,
      collapsedBackgroundColor: backgroundColor,
      tilePadding: EdgeInsets.symmetric(horizontal: twelvePx),
      trailing: SvgPicture.asset(
        SvgPath.icArrowDownOutline,
        colorFilter: buildColorFilter(Colors.red),
      ),
      title: BuildExpansionTileTitle(
        theme: theme,
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return BuildArabicWordEntry(index: index, theme: theme);
          },
        ),
        gapH20,
      ],
    );
  }
}
