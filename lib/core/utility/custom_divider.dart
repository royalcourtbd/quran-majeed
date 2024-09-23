import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        color: context.color.primaryColor.withOpacity(.1),
      ),
    );
  }
}
