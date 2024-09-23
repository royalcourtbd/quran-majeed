import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class FontOptionListItem extends StatelessWidget {
  final String font;
  final bool isSelected;
  final ValueChanged<String> onSelected;
  final ThemeData theme;

  const FontOptionListItem({
    super.key,
    required this.font,
    required this.isSelected,
    required this.onSelected,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      minLeadingWidth: twentyFivePx,
      leading: Radio<String>(
        value: font,
        groupValue: isSelected ? font : null,
        onChanged: (value) => onSelected(value!),
      ),
      title: Text(
        font,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () => onSelected(font),
    );
  }
}
