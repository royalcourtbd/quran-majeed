import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class WordByWordStickyHeader extends StatelessWidget {
  final String title;
  final ThemeData theme;

  const WordByWordStickyHeader({
    super.key,
    required this.title,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      decoration: const BoxDecoration(),
      child: Text(
        title,
        style: theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.color.primaryColor,
        ),
      ),
    );
  }
}
