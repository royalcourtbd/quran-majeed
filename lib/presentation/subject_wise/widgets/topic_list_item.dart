import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/subject_wise/ui/subject_wise_page.dart';
import 'package:quran_majeed/presentation/subject_wise/widgets/leter_circle_avater.dart';
import 'package:quran_majeed/presentation/subject_wise/widgets/topic_divider.dart';

class TopicListItem extends StatelessWidget {
  final Topic topic;
  final bool showLetter;
  final String letter;
  final ThemeData theme;
  final VoidCallback onTap;

  const TopicListItem({
    super.key,
    required this.topic,
    required this.showLetter,
    required this.letter,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLetter)
          Padding(
            padding: padding15,
            child: LetterCircleAvatar(letter: letter, theme: theme),
          ),
        ListTile(
          onTap: onTap,
          title: Text(
            topic.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${topic.ayahs} Ayahs',
            style: context.quranText.lableExtraSmall!.copyWith(
              color: context.color.subtitleColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        TopicDivider(theme: theme),
      ],
    );
  }
}
