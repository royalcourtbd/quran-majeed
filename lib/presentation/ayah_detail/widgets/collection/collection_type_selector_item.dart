import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CollectionTypeSelectorItem extends StatelessWidget {
  const CollectionTypeSelectorItem({
    super.key,
    required this.selectedColor,
    required this.onTap,
    // required this.collectionType,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.groupValue,
    required this.value,
    required this.theme,
  });

  final Color selectedColor;
  final void Function() onTap;
  // final dynamic collectionType;
  final String title;
  final String subtitle;
  final bool isSelected;
  final dynamic groupValue;
  final dynamic value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio(
              value: value,
              groupValue: groupValue,
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              fillColor: WidgetStateProperty.all(
                isSelected
                    ? context.color.primaryColor
                    : context.color.primaryColor.withOpacity(0.38),
              ),
              onChanged: (value) {},
            ),
          ),
          gapW10,
          SvgPicture.asset(
            //TODO: Implement condition for collectionType
            // CollectionType.bookmark == collectionType
            // ?
            SvgPath.icFolder
            // : SvgPath.icPin
            ,

            height: twentyFourPx,
            colorFilter: buildColorFilter(selectedColor),
          ),
          gapW15,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
              gapH5,
              Text(
                subtitle,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
