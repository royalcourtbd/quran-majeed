import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/drawer_top_widget.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/main_menu_drawer.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/others_drawer_widget.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer_bottom_bar.dart';

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Drawer(
      elevation: 0,
      width: QuranScreen.width,
      backgroundColor: themeData.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(twentyPx),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(twentyPx),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgPath.icDrawerSide,
                height: QuranScreen.width * 1.12,
                fit: BoxFit.cover,
                colorFilter: buildColorFilter(themeData.cardColor),
              ),
            ),
            Positioned(
              top: thirtyPx,
              right: fifteenPx,
              child: IconButton(
                onPressed: () => context.navigatorPop<void>(),
                icon: Icon(
                  Icons.close,
                  color: context.color.subtitleColor,
                ),
              ),
            ),
            Positioned(
              top: 17.percentWidth,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DrawerTopWidget(theme: themeData),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Next e proyojon hole Drawer e Musaf and Hifz section add korte hobe
                              // const MusafDrawerWidget(),
                              // gapH10,
                              MainMenuDrawerWidget(
                                theme: themeData,
                              ),
                              gapH10,
                              OthersDrawerWidget(
                                theme: themeData,
                              ),
                              SizedBox(height: QuranScreen.height * 0.1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: DrawerBottomBar(theme: themeData),
            ),
          ],
        ),
      ),
    );
  }
}
