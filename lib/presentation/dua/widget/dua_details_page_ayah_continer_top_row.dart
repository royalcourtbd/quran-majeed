import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/common/ayah_card/ayah_card_left_icon_row.dart';

class DuaDetailsPageAyahContainerTopRow extends StatelessWidget {
  const DuaDetailsPageAyahContainerTopRow({
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
    return LeftIconRow(
      icon: icon,
      rowTitle: rowTitle,
      theme: theme,
      onTapMoreButton: onTapMoreButton,
      isLeftAligned: true,
    );
  }
}
