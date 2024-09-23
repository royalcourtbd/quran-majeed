import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/tajweed/ui/tajweed_page.dart';
import 'package:quran_majeed/presentation/tajweed/widgets/detailed_rule_card.dart';

class DetailedRulesList extends StatelessWidget {
  const DetailedRulesList({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: detailedRules.length,
      itemBuilder: (context, index) {
        final rule = detailedRules[index];
        return DetailedRuleCard(
          theme: theme,
          title: rule['title'],
          cardColor: rule['cardColor'],
          description: rule['description'],
          arabicText: rule['arabicText'],
        );
      },
    );
  }
}
