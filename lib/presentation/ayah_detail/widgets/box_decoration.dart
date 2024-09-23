import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

BoxDecoration decorateBottomSheet(BuildContext context) {
  return BoxDecoration(
    color: context.color.backgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(twentyPx),
      topRight: Radius.circular(twentyPx),
    ),
  );
}
