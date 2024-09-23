import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';

class BuildRowWithArrowWidget extends StatelessWidget {
  const BuildRowWithArrowWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onClicked,
    required this.theme,
    this.autopop = true,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onClicked;
  final bool autopop;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MenuListItem(
            theme: theme,
            iconPath: iconPath,
            title: title,
            onClicked: () {
              onClicked.call();
            },
            autoPop: autopop,
          ),
        ),
        InkWell(
          onTap: () => onClicked.call(),
          child: Row(
            children: [
              SizedBox(
                width: 40.percentWidth,
                child: Text(
                  subtitle.length > 15
                      ? '${subtitle.substring(0, 15)}...'
                      : subtitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: context.color.subtitleColor,
                  ),
                ),
              ),
              gapW8,
              SvgPicture.asset(
                SvgPath.icArrowDownOutline,
                width: twentyTwoPx,
                colorFilter: buildColorFilter(context.color.subtitleColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
