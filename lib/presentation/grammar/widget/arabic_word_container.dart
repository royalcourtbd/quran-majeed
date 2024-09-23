import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ArabicWordContainer extends StatelessWidget {
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Border border;
  final int index;

  const ArabicWordContainer({
    super.key,
    required this.textStyle,
    required this.padding,
    required this.borderRadius,
    required this.border,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: fifteenPx,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          color: 0 == index ? context.color.primaryColor : null,
        ),
        child: Text('', style: textStyle),
      ),
    );
  }
}
