import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';

import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.theme,
    this.onClicked,
    this.autoPop = true,
  });
  final bool autoPop;
  final String iconPath;
  final String title;
  final void Function()? onClicked;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: key,
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () async {
          if (autoPop) {
            context.navigatorPop<void>();
          }
          await Future<void>.delayed(200.inMilliseconds);
          onClicked?.call();
        },
        child: SizedBox(
          key: key,
          width: QuranScreen.width,
          child: Padding(
            padding: paddingV10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgImage(
                  iconPath,
                  width: twentyOnePx,
                  height: twentyOnePx,
                  color: theme.primaryColor,
                ),
                gapW15,
                Text(
                  title,
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
