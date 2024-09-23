import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/bounces.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/sort_option_entity.dart';

class SortOptionItem extends StatelessWidget {
  const SortOptionItem({
    super.key,
    required this.sortOption,
    required this.isSelected,
    required this.onOptionSelected,
    required this.theme,
  });

  final SortOptionEntity sortOption;
  final bool isSelected;
  final void Function(SortOptionEntity) onOptionSelected;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOptionSelected(sortOption),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: twelvePx),
        child: Row(
          children: [
            if (isSelected)
              CircleAvatar(
                backgroundColor: theme.primaryColor,
                radius: eightPx,
                child: BounceInUp(
                  duration: 122.inMilliseconds,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    weight: tenPx,
                    size: tenPx,
                  ),
                ),
              )
            else
              Container(
                width: sixteenPx,
                height: sixteenPx,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.color.primaryColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
            gapW20,
            Text(
              sortOption.getName(context),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
