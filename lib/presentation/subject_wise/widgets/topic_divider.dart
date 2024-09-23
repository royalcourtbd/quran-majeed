import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class TopicDivider extends StatelessWidget {
  final ThemeData theme;

  const TopicDivider({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: fifteenPx,
        right: thirtyPx,
      ),
      child: Divider(color: theme.primaryColor.withOpacity(0.1)),
    );
  }
}
