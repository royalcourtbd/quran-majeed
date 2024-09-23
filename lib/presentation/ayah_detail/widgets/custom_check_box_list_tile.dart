import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class CustomCheckBoxListTile extends StatelessWidget {
  const CustomCheckBoxListTile({
    super.key,
    this.value,
    this.onChanged,
    required this.title,
    required this.theme,
  });

  final bool? value;
  final Function(bool?)? onChanged;
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.9,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: onChanged,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          ),
        ),
        gapW15,
        Padding(
          padding: EdgeInsets.only(
            top: twelvePx,
            bottom: twelvePx,
          ),
          child: Text(
            title,
            style: theme
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: thirteenPx, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
