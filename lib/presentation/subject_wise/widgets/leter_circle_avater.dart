import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class LetterCircleAvatar extends StatelessWidget {
  final String letter;
  final ThemeData theme;

  const LetterCircleAvatar({
    super.key,
    required this.letter,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: theme.primaryColor.withOpacity(0.13),
      child: Text(
        letter,
        style: theme.textTheme.titleMedium!.copyWith(
          color: context.color.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
