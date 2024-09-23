import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.text,
    required this.theme,
    this.onTap,
  });

  final String text;
  final ThemeData theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      onTap: onTap,
      theme: theme,
      child: Chip(
        label: Text(
          text,
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: theme.cardColor,
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(horizontal: fivePx),
      ),
    );
  }
}
