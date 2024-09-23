import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class AutoScrollButton extends StatelessWidget {
  const AutoScrollButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: fivePx,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.color.primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgImage(
              SvgPath.icMinus,
              color: context.color.primaryColor,
              width: twentyPx,
              height: twentyPx,
            ),
          ),
          gapW25,
          Text(
            '10X',
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.color.primaryColor,
            ),
          ),
          gapW25,
          InkWell(
            onTap: () {},
            child: SvgImage(
              SvgPath.icPlus,
              color: context.color.primaryColor,
              width: twentyPx,
              height: twentyPx,
            ),
          ),
        ],
      ),
    );
  }
}
