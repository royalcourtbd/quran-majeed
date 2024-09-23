import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_presenter.dart';

class HomePageAppBar extends StatelessWidget {
  HomePageAppBar({
    super.key,
    required this.theme,
  });
  final ThemeData theme;

  final TextEditingController searchController = TextEditingController();
  // late final SearchPresenter _searchPresenter = locate<SearchPresenter>();
  late final MainPagePresenter _drawerPresenter = locate<MainPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: QuranScreen.height * 0.11,
      leading: SizedBox(
        height: twentyPx,
        width: twentyPx,
        child: IconButton(
          onPressed: _drawerPresenter.onCLickOnDrawerButton,
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            SvgPath.icMenu,
            colorFilter: buildColorFilter(context.color.whiteColor),
            width: twentyTwoPx,
          ),
        ),
      ),
      title: Center(
        child: Text(
          context.l10n.appTitle,
          style: theme.textTheme.headlineMedium!.copyWith(
            fontFamily: FontFamily.cinzelDecorative,
            color: context.color.whiteColor,
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: fortyTwoPx,
          width: fortyTwoPx,
          child: IconButton(
            onPressed: () async {
              showComingSoonMessage(context: context);
              // _searchPresenter.topSearchBar(context, _searchPresenter);
            },
            icon: SvgPicture.asset(
              SvgPath.icSearch,
              height: twentyTwoPx,
              width: twentyTwoPx,
              colorFilter: buildColorFilter(
                context.color.whiteColor,
              ),
            ),
          ),
        ),
        gapW15,
      ],
    );
  }
}
