import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/grammar/widget/close_circle_icon.dart';
import 'package:quran_majeed/presentation/grammar/widget/root_word_text.dart';

class LeadingContent extends StatelessWidget {
  const LeadingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CloseCircleIcon(context),
        gapW5,
        const RootWordText(),
      ],
    );
  }
}
