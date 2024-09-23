import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/tajweed/widgets/detailed_rule_list.dart';
import 'package:quran_majeed/presentation/tajweed/widgets/rules_list.dart';

class TajweedRulesPage extends StatelessWidget {
  const TajweedRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        title: 'Tajweed Rules',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fifteenPx),
        child: ListView(
          children: [
            const RulesList(),
            gapH15,
            Container(
              padding: padding10,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: radius20,
              ),
              child: Text(
                'Detailed Tajweed Rules',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: context.color.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            gapH15,
            DetailedRulesList(theme: theme),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> detailedRules = [
  {
    'title': 'Ghunnah (Nasalization)',
    'cardColor': const Color(0xffE0861D),
    'description':
        'Any (ن) or (م) will have a sound that emanates from the nose.',
    'arabicText': 'إِنَّهَا عَلَيْهِم مُّؤْصَدَةٌ',
  },
  {
    'title': 'Ikhfaa (Concealment)',
    'cardColor': const Color(0xffB60000),
    'description':
        'Any (ن) or (تنوين) followed by the letters (ت، ث، ج) will be pronounced with a slight nasal sound.',
    'arabicText': 'مِن سَجِيلٍ',
  },
  {
    'title': 'Idghaam (Assimilation)',
    'cardColor': const Color(0xffB856C7),
    'description':
        'Any (ن) or (تنوين) followed by (و، ر، ل، ن، م) merges into the following letter.\n\nWhen (ن) or (تنوين) is followed by (ب), it changes to a light nasal sound represented by (م).',
    'arabicText': 'مِن رَّبِّهِمْ',
  },
  {
    'title': 'Iqlab (Substitution)',
    'cardColor': const Color(0xffAAAAAA),
    'description':
        'Any (ن) or (م) will have a sound that emanates from the nose.',
    'arabicText': 'مِن بَعْدِ',
  },
  {
    'title': 'Qalqalah (Echoing)',
    'cardColor': const Color(0xff3065C5),
    'description':
        'Any (ن) or (م) will have a sound that emanates from the nose.',
    'arabicText': 'قُلْ أَعُوذُ',
  },
  {
    'title': 'Madd (Prolongation)',
    'cardColor': const Color(0xff309900),
    'description':
        'Any (ا) or (و) will have a sound that emanates from the nose.',
    'arabicText': 'قَالُوا',
  },
];

final List<Map<String, String>> rules = [
  {"symbol": "ظ", "text": "Must Stop", "count": "18", "color": "#FF0000"},
  {"symbol": "ض", "text": "Better To Stop", "count": "31", "color": "#FF7F50"},
  {"symbol": "ص", "text": "Pause at One", "count": "25", "color": "#FFA07A"},
  {"symbol": "س", "text": "A slight pause", "count": "29", "color": "#FFA500"},
  {
    "symbol": "ح",
    "text": "Stop or Continue",
    "count": "20",
    "color": "#32CD32"
  },
  {
    "symbol": "ق",
    "text": "Better to Continue",
    "count": "27",
    "color": "#008000"
  },
  {"symbol": "ل", "text": "Don't Stop", "count": "23", "color": "#006400"}
];
