import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    super.key,
    required this.theme,
  });
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? QuranScreen.width * .50 : QuranScreen.width * .35,
      child: Stack(
        key: const Key('DrawerTopWidget'),
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              SvgPath.mainDrawerTopBg,
              width: isMobile ? 65.percentWidth : 38.percentWidth,
              height: isMobile ? 65.percentWidth : 38.percentWidth,
              fit: BoxFit.cover,
              colorFilter: buildColorFilter(context.color.cardShade),
            ),
          ),
          Column(
            key: const Key('DrawerTopWidgetColumn'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgPath.icMain,
              ),
              gapH8,
              Text(
                'Quran Mazid',
                style: theme.textTheme.headlineSmall,
              ),
              gapH3,
              Text(
                '${context.l10n.version} 3.0',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
