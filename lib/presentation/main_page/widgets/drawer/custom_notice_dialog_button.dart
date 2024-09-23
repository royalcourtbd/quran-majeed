import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomNoticeDialogButton extends StatelessWidget {
  const CustomNoticeDialogButton({
    super.key,
    required this.theme,
    required this.url,
    required this.colors,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final String url;
  final List<Color> colors;
  final String icon;
  final String title;
  final void Function()? onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return const SizedBox.shrink();
    return InkWell(
      onTap: onTap ?? () => openUrl(url: url),
      child: Container(
        margin: EdgeInsets.only(bottom: fourteenPx),
        width: double.infinity,
        padding: EdgeInsets.all(fourteenPx),
        decoration: BoxDecoration(
          color: colors.length == 1 ? colors[0] : null,
          gradient: colors.length > 1
              ? LinearGradient(
                  colors: colors,
                )
              : null,
          borderRadius: radius10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: twentyTwoPx,
            ),
            gapW12,
            Text(
              title,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
