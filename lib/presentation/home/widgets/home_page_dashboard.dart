import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/home_category_model.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/widgets/dashboard_item.dart';

class HomePageDashboard extends StatelessWidget {
  const HomePageDashboard({
    super.key,
    required this.theme,
    required this.homePresenter,
    required List<HomeCategoryModel> categoryList,
  });

  final ThemeData theme;

  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: twentyPx,
      ),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: fifteenPx, horizontal: fifteenPx),
        decoration: BoxDecoration(
          boxShadow: [
            !isDarkMode(context)
                ? BoxShadow(
                    color: const Color.fromRGBO(
                        155, 131, 109, 0.15), // Shadow color and opacity
                    offset: const Offset(0, 1), // X, Y offset values from CSS
                    blurRadius: fifteenPx, // Blur radius
                    spreadRadius: 0, // Spread radius
                  )
                : const BoxShadow(),

            //Next e proyojon hobe
            // BoxShadow(
            //   color: isDarkMode(context)
            //       ? const Color.fromRGBO(11, 15, 21, 1)
            //       : const Color.fromRGBO(97, 71, 48, 0.2),
            //   blurRadius: tenPx, // Unified blur radius
            //   offset: const Offset(0, 4), // Unified offset

            //   spreadRadius: -2,
            // ),
          ],
          color: context.color.homeDashboardBgColor,
          borderRadius: BorderRadius.circular(fifteenPx),
        ),
        width: QuranScreen.width,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
            mainAxisSpacing: twelvePx,
            crossAxisSpacing: twelvePx,
          ),
          itemBuilder: (context, index) {
            final category =
                homePresenter.getDashboardItem(index: index, context: context);

            return DashboardItem(
              homePresenter: homePresenter,
              category: category,
              theme: theme,
            );
          },
        ),
      ),
    );
  }
}
