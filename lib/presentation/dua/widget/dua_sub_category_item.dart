import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/presentation/dua/ui/dua_details_page.dart';
import 'package:quran_majeed/presentation/dua/widget/rounded_index.dart';

class DuaSubCategoryItem extends StatelessWidget {
  const DuaSubCategoryItem({
    super.key,
    required this.theme,
    required this.category,
    required this.subCategoryIndex,
  });

  final ThemeData theme;
  final DuaCategoryModel category;
  final int subCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: const SizedBox.shrink(),
      tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      childrenPadding: EdgeInsets.only(left: thirtyPx, bottom: 7),
      controlAffinity: ListTileControlAffinity.platform,
      shape: RoundedRectangleBorder(
        borderRadius: radius10,
        side: BorderSide.none,
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedIndex(
            theme: theme,
            subCategoryIndex: subCategoryIndex,
            bgColor: theme.primaryColor.withOpacity(0.8),
            textColor: Colors.white,
          ),
          gapW15,
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.subCategories[subCategoryIndex].subCategoryTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH4,
                Text(
                  '${category.subCategories[subCategoryIndex].duaList.length} Duas',
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.color.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  category.subCategories[subCategoryIndex].duaList.length,
              itemBuilder: (context, idx) {
                return ListTile(
                  onTap: () => context.navigatorPush(
                    DuaDetailsPage(category: category),
                  ),
                  leading: RoundedIndex(
                    theme: theme,
                    bgColor: theme.primaryColor.withOpacity(0.2),
                    subCategoryIndex: idx,
                    height: thirtyTwoPx,
                    width: thirtyTwoPx,
                    textColor: context.color.blackColor,
                  ),
                  title: Text(
                    category.subCategories[subCategoryIndex].subCategoryTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
