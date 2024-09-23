import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class NoticeDialogButton extends StatelessWidget {
  const NoticeDialogButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.opacity,
    this.trailing = true,
    required this.onPressed,
    required this.actionType,
    required this.theme,
  });

  final String title;
  final String icon;
  final Color color;
  final double? opacity;
  final VoidCallback onPressed;
  final ButtonActionType actionType;
  final bool trailing;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: twelvePx),
      child: OnTapWidget(
        theme: theme,
        onTap: onPressed,
        child: Container(
          width: QuranScreen.width,
          padding: EdgeInsets.only(
              left: eightPx, right: twelvePx, top: twelvePx, bottom: twelvePx),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.07),
            borderRadius: radius6,
          ),
          child: Row(
            mainAxisAlignment: trailing
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  gapW5,
                  SizedBox(
                    width: thirtyPx,
                    height: thirtyPx,
                    child: SvgPicture.asset(icon),
                  ),
                  gapW15,
                  SizedBox(
                    width: trailing ? 55.percentWidth : null,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (trailing)
                if (actionType == ButtonActionType.copy)
                  SvgPicture.asset(
                    SvgPath.icCopy,
                    width: eighteenPx,
                    height: eighteenPx,
                    colorFilter: buildColorFilter(context.color.subtitleColor),
                  )
                else
                  SvgPicture.asset(
                    SvgPath.icSend,
                    width: sixteenPx,
                    height: sixteenPx,
                    colorFilter: buildColorFilter(context.color.subtitleColor),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonActionType { copy, send }
