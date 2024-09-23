import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/auto_scroll_button.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_button_widget.dart';

class AutoScrollControlWidget extends StatelessWidget {
  const AutoScrollControlWidget({
    super.key,
    required this.theme,
    required this.ayahPresenter,
    required this.bottomNavigationBarHeight,
  });

  final ThemeData theme;
  final AyahPresenter ayahPresenter;
   final double bottomNavigationBarHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomNavigationBarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: twentyPx,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(twentyPx),
        ),
        color: theme.cardColor,
      ),
      child: FadeIn(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavButtonWidget(
              onTap: () {},
              iconSvgPath: SvgPath.icPause,
            ),
            NavButtonWidget(
              onTap: () {},
              iconSvgPath: SvgPath.icPrevious,
            ),
            AutoScrollButton(theme: theme),
            NavButtonWidget(
              onTap: () {
                ayahPresenter.toggleAutoScroll();
              },
              iconSvgPath: SvgPath.icX,
            ),
          ],
        ),
      ),
    );
  }
}
