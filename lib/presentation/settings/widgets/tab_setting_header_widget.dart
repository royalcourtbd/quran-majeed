import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class TabSettingHeaderWidget extends StatelessWidget {
  const TabSettingHeaderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Container(
        alignment: Alignment.topCenter,
        width: QuranScreen.width,
        child: Text(
          title,
          style: textTheme.bodyMedium!.copyWith(
            fontSize: eightPx,
            fontWeight: FontWeight.bold,
            color: context.color.primaryColor,
          ),
        ));
  }
}
