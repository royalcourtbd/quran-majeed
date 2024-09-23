import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomDonateButton extends StatelessWidget {
  final Function() onTap;
  const CustomDonateButton({
    super.key,
    required this.onTap,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: fiftyPx,
        width: QuranScreen.width,
        margin: EdgeInsets.only(left: twentyPx, right: twentyPx, bottom: tenPx),
        decoration: BoxDecoration(
            color: context.color.primaryColor,
            borderRadius: BorderRadius.circular(fivePx)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgPath.icSupportButton,
              height: twentyFivePx,
              width: twentyFivePx,
              colorFilter: buildColorFilter(context.color.whiteColor),
            ),
            gapW10,
            Text(
              context.l10n.iWantToDonate,
              style: theme.textTheme.labelSmall?.copyWith(
                color: context.color.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
