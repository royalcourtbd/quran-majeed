import 'package:flutter/material.dart';

class WordPartsOfSpeechWidget extends StatelessWidget {
  final ThemeData theme;
  const WordPartsOfSpeechWidget({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "Preposition",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
          TextSpan(
            text: " | Noun",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }
}
