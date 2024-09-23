import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CollectionBottomSheetHeader extends StatelessWidget {
  const CollectionBottomSheetHeader({
    super.key,
    this.tabController,
    required this.themeData,
  });

  final ThemeData themeData;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      width: QuranScreen.width,
      padding: EdgeInsets.only(
        top: tenPx,

        ///TODO: jokhon bookmark and pin er er kaj kora hobe tokhon niche bottom er padding ta twentyPx korte hobe
        bottom: tenPx,
      ),
      child: Column(
        children: [
          // const BottomSheetTopSection(),
          gapH10,
          Text(
            context.l10n.addToCollection,
            style: themeData.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: themeData.primaryColor,
            ),
          ),

          ///TODO: jokhon bookmark and pin er er kaj kora hobe tokhon niche er code ta uncomment korte hobe
          /* gapH15,
          Container(
            width: QuranScreen.width,
            height: 12.percentWidth,
            margin: EdgeInsets.symmetric(horizontal: fifteenPx),
            decoration: BoxDecoration(
              color: themeData.primaryColor.withOpacity(0.1),
              borderRadius: radius10,
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              onTap: (index) {
                if (index != 0) {
                  showComingSoonMessage(context: context);
                  tabController?.animateTo(0);
                }
              },
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: sixPx, vertical: fivePx),
              indicator: BoxDecoration(
                color: themeData.primaryColor,
                borderRadius: radius8,
              ),
              unselectedLabelColor: themeData.textTheme.bodyMedium?.color,
              labelColor: themeData.textTheme.labelSmall?.color,
              indicatorColor: themeData.appBarTheme.backgroundColor,
              unselectedLabelStyle: themeData.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: thirteenPx),
              labelStyle: themeData.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: thirteenPx),
              labelPadding: EdgeInsets.only(top: threePx),
              tabs: const [Tab(text: 'Bookmarks'), Tab(text: 'Pins')],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          */
          //TODO:Bookmark and Pin search er function korte hobe
          // gapH12,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: fifteenPx),
          //   child: SizedBox(
          //     height: fortyFivePx,
          //     child: SearchTextField(
          //       hintText: 'Search Bookmark',
          //       textEditingController: TextEditingController(),
          //       borderRadius: radius10,
          //       onChanged: (value) {
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
