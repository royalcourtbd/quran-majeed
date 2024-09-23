import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class UploadThemeWidget extends StatelessWidget {
  const UploadThemeWidget({
    super.key,
    required this.index,
    required this.theme,
  });
  final int index;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 25.percentWidth,
          width: 25.percentWidth,
          decoration: index.isEqual(3)
              ? BoxDecoration(
                  borderRadius: radius10,
                  border: Border.all(
                    color: context.color.primaryColor.withOpacity(0.3),
                    width: twoPx,
                  ),
                )
              : BoxDecoration(
                  borderRadius: radius10,
                  image: const DecorationImage(
                    image: AssetImage(SvgPath.imgThemeImage),
                    fit: BoxFit.cover,
                  ),
                ),
          child: index.isEqual(3)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgPath.icViews,
                      width: twentyFourPx,
                    ),
                    gapH10,
                    Text(
                      'Upload Image',
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: context.color.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ),
        index.isEqual(0)
            ? Positioned(
                right: fifteenPx,
                top: fivePx,
                child: SvgPicture.asset(SvgPath.icCheckCircle),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
