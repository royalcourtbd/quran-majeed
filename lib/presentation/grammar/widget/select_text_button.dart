import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SelectTextButton extends StatelessWidget {
  const SelectTextButton({
    super.key,
    required this.theme,
    required this.text,
    this.onTap,
  });

  final ThemeData theme;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sevenPx, vertical: threePx),
        decoration: BoxDecoration(
          borderRadius: radius8,
          border: Border.all(
            width: 1,
            color: context.color.primaryColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: context.color.primaryColor,
          ),
        ),
      ),
    );
  }
}
