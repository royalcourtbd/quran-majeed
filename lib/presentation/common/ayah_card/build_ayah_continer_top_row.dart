import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/common/ayah_card/ayah_card_left_icon_row.dart';
import 'package:quran_majeed/presentation/common/ayah_card/ayah_card_right_icon_row.dart';

class BuildAyahContainerTopRow extends StatelessWidget {
  const BuildAyahContainerTopRow({
    super.key,
    required this.onTapMoreButton,
    required this.rowTitle,
    this.isIconLeft = false,
    this.icon,
    required this.theme,
  });

  final VoidCallback onTapMoreButton;
  final String rowTitle;
  final Widget? icon;
  final ThemeData theme;
  final bool isIconLeft;

  @override
  Widget build(BuildContext context) {
    return isIconLeft
        ? LeftIconRow(
            icon: icon,
            rowTitle: rowTitle,
            theme: theme,
            onTapMoreButton: onTapMoreButton,
            isLeftAligned: true,
          )
        : RightIconRow(
            icon: icon,
            rowTitle: rowTitle,
            theme: theme,
            onTapMoreButton: onTapMoreButton,
            isLeftAligned: false,
          );
  }
}
