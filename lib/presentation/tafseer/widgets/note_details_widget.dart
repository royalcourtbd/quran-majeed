import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/expansion_widget.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/ayah_note_display.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/note_expandable_header_widget.dart';

class NoteDetailsWidget extends StatelessWidget {
  const NoteDetailsWidget({
    super.key,
    required this.theme,
    required this.tafseerPresenter,
  });

  final ThemeData theme;
  final TafseerPresenter tafseerPresenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: eightPx),
      child: ExpansionWidget(
        initiallyExpanded: false,
        duration: const Duration(milliseconds: 300),
        titleBuilder:
            (double animationValue, _, bool isExpaned, toggleFunction) {
          return NoteExpandableHeaderWidget(
            theme: theme,
            animationValue: animationValue,
            isExpanded: isExpaned,
            toggleFunction: toggleFunction,
            tafseerPresenter: tafseerPresenter,
          );
        },
        content: AyahNoteDisplay(
          theme: theme,
        ),
      ),
    );
  }
}
