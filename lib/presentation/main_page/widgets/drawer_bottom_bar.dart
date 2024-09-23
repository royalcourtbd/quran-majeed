import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/presentation/main_page/widgets/navigation_button.dart';

class DrawerBottomBar extends StatelessWidget {
  const DrawerBottomBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: fiftySevenPx,
      width: QuranScreen.width,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigationButton(
            iconPath: SvgPath.fbIcon,
            theme: theme,
            onPressed: () {},
          ),
          NavigationButton(
            iconPath: SvgPath.icGroup,
            theme: theme,
            onPressed: () {},
          ),
          NavigationButton(
            iconPath: SvgPath.icTwitter2,
            theme: theme,
            onPressed: () {},
          ),
          NavigationButton(
            iconPath: SvgPath.icYoutube2,
            theme: theme,
            onPressed: () {},
          ),
          NavigationButton(
            iconPath: SvgPath.icLinkedin,
            theme: theme,
          ),
          NavigationButton(
            iconPath: SvgPath.icWeb,
            theme: theme,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
