import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'dart:math' as math;

class AyahExpandableHeaderWidget extends StatelessWidget {
  const AyahExpandableHeaderWidget({
    super.key,
    required this.theme,
    required this.ayahPresenter,
    required this.animationValue,
    required this.toggleFunction,
    required this.surahID,
    required this.ayahID,
    required this.surahName,
  });

  final ThemeData theme;
  final double animationValue;
  final Function toggleFunction;
  final AyahPresenter ayahPresenter;
  final int surahID;
  final int ayahID;
  final String surahName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => toggleFunction(animated: true),
      child: Container(
        key: const Key('ayah_expandable_header_widget'),
        padding: EdgeInsets.symmetric(
          horizontal: twentyPx,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
            // color: Colors.red,
            ),
        child: Row(
          children: [
            SvgPicture.asset(
              SvgPath.icSurahIcon,
              width: twentyThreePx,
              height: twentyThreePx,
              colorFilter: buildColorFilter(context.color.primaryColor),
            ),
            gapW10,
            Text(
              '$surahName $surahID:$ayahID',
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            gapW15,
            Transform.rotate(
              key: const Key('transform_rotate'),
              angle: math.pi * animationValue,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                SvgPath.icArrowDownOutline,
                width: twentyTwoPx,
                colorFilter: buildColorFilter(context.color.subtitleColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
