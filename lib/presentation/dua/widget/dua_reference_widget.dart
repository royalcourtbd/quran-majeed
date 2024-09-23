import 'package:flutter/material.dart';

import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class DuaReferenceWidget extends StatelessWidget {
  const DuaReferenceWidget({
    super.key,
    required this.reference,
    required this.theme,
  });

  final String reference;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reference:",
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.color.primaryColor,
          ),
        ),
        gapH3,
        Text(
          reference,
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
