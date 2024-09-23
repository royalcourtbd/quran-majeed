import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';

class CounterControl extends StatelessWidget {
  final String label;
  final int value;
  final Function onIncrement;
  final Function onDecrement;
  final String unit;
  final bool canIncrement;
  final bool canDecrement;
  final String iconPath;
  final ThemeData theme;

  const CounterControl({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.iconPath,
    required this.theme,
    this.unit = '',
    this.canIncrement = true,
    this.canDecrement = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MenuListItem(
            theme: theme,
            iconPath: iconPath,
            title: label,
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: canDecrement ? () => onDecrement() : null,
              child: SvgImage(
                SvgPath.icMinus,
                width: twentyPx,
                height: twentyPx,
                color: canDecrement
                    ? context.color.subtitleColor
                    : context.color.subtitleColor.withOpacity(0.4),
              ),
            ),
            gapW5,
            SizedBox(
              width: sixtyPx,
              child: Text(
                '$value$unit',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.color.subtitleColor,
                ),
              ),
            ),
            gapW5,
            InkWell(
              onTap: canIncrement ? () => onIncrement() : null,
              child: SvgImage(
                SvgPath.icPlus,
                width: twentyPx,
                height: twentyPx,
                color: canIncrement
                    ? context.color.subtitleColor
                    : context.color.subtitleColor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
