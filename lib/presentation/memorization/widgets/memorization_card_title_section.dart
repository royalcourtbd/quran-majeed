import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class MemorizationCardTitleSection extends StatelessWidget {
  const MemorizationCardTitleSection({
    super.key,
    required this.theme,
    required this.title,
    this.onMoreTap,
  });

  final ThemeData theme;
  final String title;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Row(
            children: [
              SvgPicture.asset(
                SvgPath.icDocumentOutline,
                height: twentyPx,
                width: twentyPx,
                colorFilter:
                    buildColorFilterToChangeColor(context.color.primaryColor),
              ),
              gapW8,
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: onMoreTap,
          child: Container(
            alignment: Alignment.center,
            // color: Colors.red,
            height: fortyTwoPx,
            width: fortyTwoPx,
            child: SvgPicture.asset(
              SvgPath.icMoreVert,
            ),
          ),
        ),
      ],
    );
  }
}
