import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/presentation/dua/presenter/dua_presenter.dart';

class ShowTotalDuaLengthWidget extends StatelessWidget {
  ShowTotalDuaLengthWidget(
      {super.key, required this.category, required this.theme});
  final DuaCategoryModel category;
  late final DuaPresenter _duaPresenter = locate();
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    int totalDuaInThiscategory =
        _duaPresenter.getTotalDuasForCategory(category.categoryTitle);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        VerticalDivider(
          color: theme.dividerColor,
          endIndent: tenPx,
          indent: tenPx,
          thickness: 1,
        ),
        gapW20,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$totalDuaInThiscategory",
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Duas',
              style: theme.textTheme.bodySmall!.copyWith(
                color: context.color.subtitleColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
