import 'package:flutter/material.dart';

import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/common/text_field/custom_search_field.dart';
import 'package:quran_majeed/presentation/dua/widget/dua_sub_category_list.dart';

class DuaSubCategoryPage extends StatelessWidget {
  DuaSubCategoryPage({
    super.key,
    required this.category,
  });
  final DuaCategoryModel category;
  final TextEditingController duaSearchTextEditingController =
      TextEditingController();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        key: const Key('DuaSubCategoryPageCustomAppBar'),
        title: category.categoryTitle,
        theme: theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              key: const Key('DuaSubCategoryPageRoundedScaffoldBody'),
              isColored: true,
              child: Column(
                key: const Key('DuaSubCategoryPageColumn'),
                children: [
                  CustomSearchField(
                    key: const Key('DuaDetailsPageSearchField'),
                    theme: theme,
                    textEditingController: duaSearchTextEditingController,
                    hintText: 'Search By Subcategory',
                  ),
                  gapH10,
                  DuaSubCategoryList(
                    key: const Key('DuaSubCategoryList'),
                    category: category,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
