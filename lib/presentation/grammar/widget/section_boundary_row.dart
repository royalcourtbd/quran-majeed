import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SectionBoundaryRow extends StatelessWidget {
  const SectionBoundaryRow({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.color.primaryColor.withOpacity(0.2),
      alignment: Alignment.center,
      child: Icon(
        isExpanded
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded,
        size: twentyPx,
        weight: fifteenPx,
        color: context.color.primaryColor,
      ),
    );
  }
}
