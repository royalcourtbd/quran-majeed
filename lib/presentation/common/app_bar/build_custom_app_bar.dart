import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class BuildCustomAppBar extends StatelessWidget {
  const BuildCustomAppBar({
    super.key,
    required this.title,
    this.isRoot = false,
    this.dropDownPath,
    this.actions,
    this.onTap,
    required this.theme,
  });
  final String title;
  final bool isRoot;

  final String? dropDownPath;
  final List<Widget>? actions;
  final void Function()? onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: isRoot ? EdgeInsets.only(bottom: tenPx) : EdgeInsets.zero,
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add gap if isRoot is true, otherwise show IconButton
          isRoot
              ? gapW18 // Here we add the gap when isRoot is true
              : IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () => context.navigatorPop(),
                  icon: SvgPicture.asset(
                    SvgPath.icBack,
                    width: isMobile ? twentySixPx : fourteenPx,
                    colorFilter: buildColorFilterToChangeColor(
                      isDarkMode(context)
                          ? theme.textTheme.titleMedium!.color!
                          : theme.primaryColor,
                    ),
                  ),
                ),
          InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: theme.textTheme.headlineSmall!,
            ),
          ),
          gapW8,
          dropDownPath != null
              ? InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    dropDownPath!,
                    width: sixteenPx,
                    colorFilter: buildColorFilter(context.color.primaryColor),
                  ),
                )
              : const SizedBox.shrink(),
          const Spacer(),
          if (actions != null) Row(children: actions!),
          //gapW10
        ],
      ),
    );
  }
}
