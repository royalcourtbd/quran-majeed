import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    this.width,
    required this.onTap,
    required this.text,
    this.isDownload = false,
  });

  final VoidCallback onTap;
  final String text;
  final double? width;
  final bool isDownload;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: fortyPx,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.color.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(fivePx),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isDownload ? SvgPath.icDownloadRounded : SvgPath.icLink,
                colorFilter: buildColorFilter(context.color.primaryColor),
              ),
              gapW10,
              Text(
                text,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: context.color.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
