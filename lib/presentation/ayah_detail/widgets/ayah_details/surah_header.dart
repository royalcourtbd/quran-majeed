import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/surah_detail_tail.dart';

class SurahHeader extends StatelessWidget {
  const SurahHeader({super.key, required this.surah, required this.theme});

  final SurahEntity surah;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("SurahHeader"),
      padding: EdgeInsets.only(top: eighteenPx),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        color: context.color.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SurahDetailTile(
                text: getTranslatedSurahName(surah: surah, context: context),
                fontSize: seventeenPx,
                fontWeight: FontWeight.bold,
                theme: theme,
              ),
              gapH5,
              SurahDetailTile(
                text: getMeaningOfSurah(surah: surah, context: context),
                fontSize: twelvePx,
                fontWeight: FontWeight.w500,
                theme: theme,
              ),
              gapH5,
              SurahDetailTile(
                text:
                    '${surah.totalAyah} ${context.l10n.verses} • ${getSurahType(type: surah.type, context: context)}',
                fontSize: twelvePx,
                fontWeight: FontWeight.w500,
                theme: theme,
              ),
              SvgPicture.asset(
                SvgPath.roundShape,
                width: 35.percentWidth,
                colorFilter: buildColorFilter(context.color.primaryColor),
              ),
            ],
          ),
          SvgPicture.asset(
            surah.type == 'Meccan' ? SvgPath.kabaImage : SvgPath.icMadina,
            height: 23.percentWidth,
          )
        ],
      ),
    );
  }
}
