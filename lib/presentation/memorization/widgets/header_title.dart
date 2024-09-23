import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.title,
    required this.theme,
  });

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
