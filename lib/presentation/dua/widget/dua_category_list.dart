import 'package:flutter/material.dart';
import 'package:quran_majeed/data/data_sources/local_data/dua_category_data.dart';
import 'package:quran_majeed/presentation/dua/widget/dua_category_item.dart';
import 'package:quran_majeed/presentation/common/show_no_more_text_widget.dart';

class DuaCategoryList extends StatelessWidget {
  const DuaCategoryList({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: duaCategorydata.length + 1, // Adjust based on actual data
        itemBuilder: (context, categoryIndex) {
          if (categoryIndex == duaCategorydata.length) {
            return ShowNoMoreTextWidget(
              title: 'Dua Categories',
              theme: theme,
            );
          }
          return DuaCategoryItem(
            category: duaCategorydata[categoryIndex],
            theme: theme,
          );
        },
      ),
    );
  }
}
