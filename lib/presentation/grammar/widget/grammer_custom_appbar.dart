import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/grammar/widget/app_bar_title.dart';

class GrammarCustomAppbar extends StatelessWidget {
  const GrammarCustomAppbar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top + tenPx,
      width: double.infinity,
      // alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: eighteenPx,
        right: eighteenPx,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.navigatorPop(),
            child: SvgPicture.asset(
              SvgPath.icBack,
              colorFilter: buildColorFilter(
                context.color.primaryColor,
              ),
              width: twentyFourPx,
            ),
          ),
          gapW10,
          const Flexible(
            child: GrammarAppBarTitle(),
          ),
        ],
      ),
    );
  }
}
