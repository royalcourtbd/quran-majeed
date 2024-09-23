import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ChooseFolderWidget extends StatelessWidget {
  const ChooseFolderWidget({
    super.key,
    required this.prevFolderName,
    required this.theme,
    this.ontap,
  });

  final String? prevFolderName;
  final ThemeData theme;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: tenPx),
        height: fortyFivePx,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(tenPx),
        ),
        child: Row(
          children: [
            SvgImage(
              SvgPath.icFolder,
              color: context.color.primaryColor,
            ),
            gapW10,
            Text(
              prevFolderName ?? 'Choose Plan',
              style: theme.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: context.color.primaryColor,
              ),
            ),
            const Spacer(),
            SvgImage(
              SvgPath.icArrowDownOutline,
              color: context.color.primaryColor,
              height: twentyPx,
              width: twentyPx,
            ),
          ],
        ),
      ),
    );
  }
}
