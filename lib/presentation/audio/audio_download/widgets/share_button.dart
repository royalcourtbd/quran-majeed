import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.theme,
    this.tapOnShareButton,
  });

  final ThemeData theme;
  final VoidCallback? tapOnShareButton;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: theme,
      onTap: tapOnShareButton,
      child: Container(
        height: fortyFourPx,
        width: fortyFourPx,
        padding: padding12,
        decoration: BoxDecoration(
          borderRadius: radius8,
          color: theme.cardColor,
        ),
        child: SvgImage(
          SvgPath.icShare2,
          width: twentyPx,
          height: twentyPx,
          color: context.color.subtitleColor,
        ),
      ),
    );
  }
}
