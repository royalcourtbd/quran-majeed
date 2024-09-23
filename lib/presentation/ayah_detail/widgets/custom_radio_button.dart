import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomRadioButton extends StatelessWidget {
  final String title, value, groupValue;
  final void Function(String?)? onChanged;
  final ThemeData theme;
  const CustomRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged!(value),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio(
              activeColor: context.color.primaryColor,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: 2, vertical: -1),
              fillColor: groupValue == value
                  ? WidgetStateProperty.all(context.color.primaryColor)
                  : WidgetStatePropertyAll(
                      context.color.primaryColor.withOpacity(0.3)),
            ),
          ),
          gapW5,
          Text(
            title,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
