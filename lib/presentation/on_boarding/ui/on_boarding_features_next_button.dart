import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.onPressed,
    required this.screenIndex,
    required this.theme,
  });

  final VoidCallback onPressed;
  final int screenIndex;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: twentyPx, vertical: tenPx),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(twentyPx)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radius8),
          backgroundColor: theme.primaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          _getButtonText(),
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.color.whiteColor,
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    switch (screenIndex) {
      case 0:
        return "Next";
      case 1:
        return "Allow";
      default:
        return "Confirm";
    }
  }
}
