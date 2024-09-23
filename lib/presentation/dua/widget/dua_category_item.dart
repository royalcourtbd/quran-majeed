import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/presentation/dua/ui/dua_sub_category_page.dart';
import 'package:quran_majeed/presentation/dua/widget/show_total_dua_length_widget.dart';

class DuaCategoryItem extends StatelessWidget {
  final DuaCategoryModel category;
  final ThemeData theme;
  const DuaCategoryItem(
      {super.key, required this.category, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: twentyPx,
      onTap: () => context.navigatorPush(DuaSubCategoryPage(
        category: category,
      )),
      leading: Container(
        padding: padding12,
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          category.iconPath,
          fit: BoxFit.cover,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: sixPx),
        child: Text(
          category.categoryTitle,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: Text(
        "${category.subCategories.length} Subcategories",
        style: theme.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: context.color.subtitleColor,
        ),
      ),
      trailing: ShowTotalDuaLengthWidget(category: category, theme: theme),
    );
  }
}
