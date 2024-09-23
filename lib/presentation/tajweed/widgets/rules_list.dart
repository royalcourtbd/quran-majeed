import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/tajweed/ui/tajweed_page.dart';
import 'package:quran_majeed/presentation/tajweed/widgets/rule_item.dart';

class RulesList extends StatelessWidget {
  const RulesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: rules.length * 56.0,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rules.length,
        itemBuilder: (context, index) {
          final rule = rules[index];
          return RuleItem(
            theme: Theme.of(context),
            symbol: rule['symbol'] as String,
            text: rule['text'] as String,
            count: rule['count'] as String,
            color: (rule['color'] as String).toColor(),
          );
        },
      ),
    );
  }
}


