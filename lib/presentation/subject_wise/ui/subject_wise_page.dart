import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/customizable_feedback_widget.dart';

class SubjectWisePage extends StatelessWidget {
  SubjectWisePage({super.key});

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(
        theme: theme,
        title: context.l10n.subjectwise,
        isRoot: true,
      ),
      body: CustomizableFeedbackWidget(
        theme: theme,
        svgPath: SvgPath.icMosque,
        message: context.l10n.comingSoon,
      ),
    );
  }
}

///TODO: SubjectWisePage er kaj shuru korle nicher code gulo uncomment korte hobe and uporer code ta delete korte hobe

// class SubjectWisePage extends StatelessWidget {
//   SubjectWisePage({super.key});
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       appBar: CustomAppBar(
//         theme: theme,
//         title: 'Subjectwise Quran',
//         isRoot: true,
//       ),
//       body: Column(
//         children: [
//           CustomSearchField(
//             theme: theme,
//             textEditingController: _textEditingController,
//             hintText: "Search By Surah Name",
//           ),
//           gapH10,
//           const Expanded(
//             child: TopicList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Topic {
  final String name;
  final int ayahs;

  Topic(this.name, this.ayahs);
}

final List<Topic> topics = [
  Topic('Aaron', 28),
  Topic('Ablution', 2),
  Topic('Abraham', 117),
  Topic('Abrogation', 2),
  Topic('Abu Lahab (Abd al-Uzza)', 5),
  Topic('Baal', 1),
  Topic('Babylon', 1),
  Topic('Back', 12),
  Topic('Backbite', 3),
  Topic('Behaviour', 54),
  Topic('Cain and Abel', 5),
  Topic('Calendar', 37),
  Topic('Canaan', 1),
  Topic('Cattle', 5),
  Topic('Chastity', 3),
];
