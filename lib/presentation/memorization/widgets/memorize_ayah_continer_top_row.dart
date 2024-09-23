import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/common/ayah_card/ayah_card_right_icon_row.dart';

class MemorizeAyahContainerTopRow extends StatelessWidget {
  const MemorizeAyahContainerTopRow({
    super.key,
    required this.onTapMoreButton,
    required this.rowTitle,
    this.icon,
    required this.theme,
  });

  final VoidCallback onTapMoreButton;
  final String rowTitle;
  final Widget? icon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return RightIconRow(
      icon: icon,
      rowTitle: rowTitle,
      theme: theme,
      onTapMoreButton: onTapMoreButton,
      isLeftAligned: false,
    );
  }
}
