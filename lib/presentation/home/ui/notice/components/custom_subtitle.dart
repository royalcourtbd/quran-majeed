import 'package:flutter/material.dart';

class CustomSubtitle extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const CustomSubtitle({super.key, required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
