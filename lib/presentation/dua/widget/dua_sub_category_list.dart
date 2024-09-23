import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/presentation/common/show_no_more_text_widget.dart';
import 'package:quran_majeed/presentation/dua/widget/dua_sub_category_item.dart';

class DuaSubCategoryList extends StatelessWidget {
  const DuaSubCategoryList({
    super.key,
    required this.category,
    required this.theme,
  });

  final DuaCategoryModel category;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: category.subCategories.length + 1,
        itemBuilder: (context, subCategoryIndex) {
          if (subCategoryIndex == category.subCategories.length) {
            return ShowNoMoreTextWidget(
              title: 'Dua Subcategories',
              theme: theme,
            );
          }

          return Column(
            children: [
              DuaSubCategoryItem(
                theme: theme,
                category: category,
                subCategoryIndex: subCategoryIndex,
              ),
              if (subCategoryIndex != category.subCategories.length - 1)
                 BuildDivider(
                  theme: theme,
                 )
            ],
          );
        },
      ),
    );
  }
}
