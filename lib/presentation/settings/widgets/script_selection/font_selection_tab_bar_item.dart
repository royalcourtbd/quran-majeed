import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class FontSelectionTabBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLeftTab;
  final bool isRightTab;
  final ThemeData theme;

  const FontSelectionTabBarItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.isLeftTab,
    required this.theme,
    required this.isRightTab,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? context.color.primaryColor
                : context.color.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isSelected && isLeftTab ? twentyPx : 0),
              topRight:
                  Radius.circular(isSelected && isRightTab ? twentyPx : 0),
            ),
          ),
          child: Text(
            title,
            style: theme.textTheme.labelMedium!.copyWith(
              color:
                  isSelected ? Colors.white : theme.textTheme.bodyMedium!.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
