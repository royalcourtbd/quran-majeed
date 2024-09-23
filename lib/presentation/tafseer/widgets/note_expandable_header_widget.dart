import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'dart:math' as math;
import 'package:quran_majeed/presentation/tafseer/widgets/three_dot_option.dart';

class NoteExpandableHeaderWidget extends StatelessWidget {
  const NoteExpandableHeaderWidget({
    super.key,
    required this.theme,
    required this.animationValue,
    required this.isExpanded,
    required this.toggleFunction,
    required this.tafseerPresenter,
  });

  final ThemeData theme;
  final double animationValue;
  final bool isExpanded;
  final Function toggleFunction;
  final TafseerPresenter tafseerPresenter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => toggleFunction(animated: true),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: twentyPx,
          vertical: fifteenPx,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(fivePx),
            bottom: isExpanded ? Radius.zero : Radius.circular(fivePx),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              SvgPath.icCreateNote,
              width: twentyPx,
              colorFilter: buildColorFilter(context.color.primaryColor),
            ),
            gapW10,
            Text(
              'See Your Note',
              style: theme.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (isExpanded)
              ThreeDotOption(
                theme: theme,
                onOptionTap: () => tafseerPresenter.onClickNoteOption(context),
              ),
            gapW15,
            Transform.rotate(
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
