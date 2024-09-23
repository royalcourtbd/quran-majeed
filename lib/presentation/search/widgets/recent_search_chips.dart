import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/search/ui/search_history_page.dart';
import 'package:quran_majeed/presentation/search/widgets/build_chip_widget.dart';
import 'package:quran_majeed/presentation/search/widgets/over_flow_chip_widget.dart';

class RecentSearchChips extends StatelessWidget {
  const RecentSearchChips({
    super.key,
    required this.recentSearches,
 
    required this.theme,
  });

  final List<String> recentSearches;
  final ThemeData theme;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          runSpacing: -fivePx,
          spacing: tenPx,
          children: _buildChips(constraints.maxWidth, context),
        );
      },
    );
  }

  List<Widget> _buildChips(double maxWidth, BuildContext context) {
    double chipPadding = twoPx;
    double currentWidth = 0;
    List<Widget> chipList = [];
    bool isOverflow = false;

    for (String search in recentSearches) {
      String truncatedText = _truncateText(search, 20);

      double chipWidth = _estimateChipWidth(truncatedText);

      if ((currentWidth + chipWidth + chipPadding) > maxWidth) {
        isOverflow = true;
        break;
      }

      chipList.add(ChipWidget(
        text: truncatedText,
        theme: theme,
        onTap: () {},
      ));
      currentWidth += (chipWidth + chipPadding);
    }

    if (isOverflow) {
      chipList.add(
        OverFlowChipWidget(
          theme: theme,
          onTap: () {
            //TODO: Implement on More Button Click;
            context.navigatorPush(SearchHistoryPage(
            
            ));
          },
        ),
      );
    }

    return chipList;
  }

  String _truncateText(String text, int maxLength) {
    return (text.length > maxLength)
        ? '${text.substring(0, maxLength - 3)}...'
        : text;
  }

  double _estimateChipWidth(String text) {
    return text.length * 5;
  }
}
