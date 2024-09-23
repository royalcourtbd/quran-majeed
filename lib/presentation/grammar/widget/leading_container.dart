import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/grammar/widget/leading_content.dart';

class LeadingContainer extends StatelessWidget {
  const LeadingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: tenPx, vertical: fivePx),
      decoration: _buildDecoration(context),
      child: const LeadingContent(),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: radius6,
      color: context.color.primaryColor.withOpacity(0.15),
    );
  }
}
