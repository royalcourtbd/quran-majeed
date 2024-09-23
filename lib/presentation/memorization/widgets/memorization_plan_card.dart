import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';
import 'dart:math' as math;
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart'; // Import the math library

class MemorizationPlanCard extends StatelessWidget {
  const MemorizationPlanCard({
    super.key,
    required this.plan,
    required this.theme,
    required this.memorizationPresenter,
    required this.onTap,
  });

  final MemorizationEntity plan;
  final ThemeData theme;
  final MemorizationPresenter memorizationPresenter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx, vertical: tenPx),
      child: OnTapWidget(
        onTap: onTap,
        theme: theme,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius10,
            border: Border.all(color: theme.cardColor, width: 1),
          ),
          child: Padding(
            padding: padding15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgPath.icDocumentOutline,
                      width: twentyPx,
                      colorFilter: buildColorFilter(context.color.primaryColor),
                    ),
                    gapW10,
                    Text(
                      plan.planName ?? 'Name Of Plan',
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: math.pi / 2,
                      child: OnTapWidget(
                        theme: theme,
                        onTap: () async => await memorizationPresenter
                            .memorizationMoreOptionBottomSheet(
                          context,
                          MemorizationEntity(),
                        ),
                        child: SvgPicture.asset(
                          SvgPath.icThreeDotOption,
                          width: eighteenPx,
                          colorFilter:
                              buildColorFilter(context.color.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                gapH10,
                Text(
                  'Total Surah: ${plan.totalSurah()}',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: context.color.subtitleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                gapH3,
                Text(
                  'Remaining Days: ${plan.remainingDay()}/${plan.estimatedDay}',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: context.color.subtitleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                gapH3,
                Text(
                  'Completed: ${plan.totalAyah()}/7 Ayah',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: context.color.subtitleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                gapH10,
                LinearProgressIndicator(
                  borderRadius: radius10,
                  minHeight: fivePx,
                  value: 0.75,
                  backgroundColor: context.color.primaryColor.withOpacity(0.2),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.color.primaryColor),
                ),
                gapH5,
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: '75% ',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'Completed',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
