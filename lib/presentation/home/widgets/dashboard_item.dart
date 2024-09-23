import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/home_category_model.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.category,
    required this.theme,
    required this.homePresenter,
  });

  final HomeCategoryModel category;
  final HomePresenter homePresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () async => await homePresenter.handleCategoryTap(
          context,
          category.category,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                category.iconPath,
                width: twentyFourPx,
                colorFilter: buildColorFilter(context.color.topIconHome),
              ),
              gapH15,
              Text(
                category.title,
                style: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
