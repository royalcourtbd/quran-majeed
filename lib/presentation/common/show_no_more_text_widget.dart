import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ShowNoMoreTextWidget extends StatelessWidget {
  const ShowNoMoreTextWidget(
      {super.key, required this.title, required this.theme});

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding15,
        child: Text(
          "No more $title",
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: context.color.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
