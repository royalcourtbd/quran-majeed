import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class TafseerAddMoreTab extends StatelessWidget {
  const TafseerAddMoreTab({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              maxRadius: eightPx,
              backgroundColor: context.color.primaryColor.withOpacity(0.1),
              child: SvgPicture.asset(
                SvgPath.icPlus,
                width: fourteenPx,
                colorFilter: buildColorFilter(context.color.primaryColor),
              ),
            ),
            gapW15,
            Text(
              context.l10n.addMore,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: thirteenPx,
                fontWeight: FontWeight.w600,
                color: context.color.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
