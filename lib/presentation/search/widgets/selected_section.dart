import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

import 'package:quran_majeed/presentation/search/widgets/section_title.dart';
import 'package:quran_majeed/presentation/search/widgets/selection_box.dart';

class SelectedSection extends StatelessWidget {
  const SelectedSection({
    super.key,
    required this.theme,
    required this.sectionTitle,
    required this.sectionNote,
    required this.boxTitle,
    this.onTap,
  });

  final ThemeData theme;
  final String sectionTitle, sectionNote, boxTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH15,
        SectionTitle(
          theme: theme,
          title: sectionTitle,
          note: sectionNote,
        ),
        gapH10,
        SelectionBox(
          onTap: onTap,
          themeData: theme,
          title: boxTitle,
        ),
      ],
    );
  }
}
