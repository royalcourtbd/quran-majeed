import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/grammar/widget/leading_container.dart';
import 'package:quran_majeed/presentation/grammar/widget/responsive_search_bar.dart';

class GrammarAppBarTitle extends StatelessWidget {
  const GrammarAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fortyPx,
      padding: padding5,
      decoration: BoxDecoration(
        borderRadius: radius8,
        border: Border.all(
          color: context.color.primaryColor.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          const LeadingContainer(),
          gapW8,
          const ResponsiveSearchBar(),
        ],
      ),
    );
  }
}
