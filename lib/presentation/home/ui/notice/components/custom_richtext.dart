import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.name,
    required this.title,
    required this.theme,
  });

  final String name;
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: title,
            style: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
