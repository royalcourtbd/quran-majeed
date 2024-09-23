import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class WordByWordDownloadedSingleItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final ValueChanged<String>? onSelect;
  final ValueChanged<String>? onDelete;
  final ThemeData theme;

  const WordByWordDownloadedSingleItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.theme,
    this.onSelect,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: twentyPx),
      minVerticalPadding: 0,
      horizontalTitleGap: tenPx,
      leading: Transform.scale(
        scale: 0.9,
        child: Radio<String>(
          value: name,
          groupValue: isSelected ? name : null,
          onChanged: (_) => onSelect?.call(name),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: name != 'Bangla' && name != 'English'
          ? InkWell(
              onTap: () => onDelete?.call(name),
              child: SvgImage(
                SvgPath.icDeleteOutline,
                width: twentyPx,
                height: twentyPx,
                color: context.color.primaryColor.withOpacity(0.5),
              ),
            )
          : null,
      onTap: () => onSelect?.call(name),
    );
  }
}
