import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: isMobile
          ? EdgeInsets.symmetric(
              horizontal: tenPx,
              vertical: fivePx,
            )
          : EdgeInsets.symmetric(
              vertical: fivePx,
            ),
      padding: isMobile ? padding15 : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: radius8,
      ),
      child: child,
    );
  }
}
