import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.theme,
    required this.title,
    this.subTitle,
    this.isRoot = false,
    this.dropDownPath,
    this.actions,
    this.onTap,
  });

  final String title;
  final bool isRoot;
  final String? dropDownPath;
  final List<Widget>? actions;
  final void Function()? onTap;
  final String? subTitle;
  final ThemeData theme;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + fivePx);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + fivePx,
      leadingWidth: fortyFivePx,

      titleSpacing: isRoot ? eighteenPx : fivePx,
      leading: isRoot
          ? null
          : IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.navigatorPop<void>(),
              icon: SvgPicture.asset(
                SvgPath.icBack,
                width: isMobile ? twentySixPx : fourteenPx,
                colorFilter: buildColorFilterToChangeColor(theme.primaryColor),
              ),
            ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                // gapH10,
                LimitedBox(
                  maxWidth: QuranScreen.width * 0.7,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall!,
                  ),
                ),
                gapW8,
                dropDownPath != null
                    ? SvgPicture.asset(
                        dropDownPath!,
                        width: sixteenPx,
                        colorFilter:
                            buildColorFilter(context.color.primaryColor),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          // subTitle != null && subTitle!.isNotEmpty
          //     ? gapH4
          //     : const SizedBox.shrink(),
          subTitle != null && subTitle!.isNotEmpty
              ? Text(
                  subTitle!,
                  style: context.quranText.lableExtraSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      actions: actions,
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(1),
      //   child: Container(
      //     color: context.color.primaryColor.withOpacity(0.1),
      //     height: 1,
      //   ),
      // ),
    );
  }
}
