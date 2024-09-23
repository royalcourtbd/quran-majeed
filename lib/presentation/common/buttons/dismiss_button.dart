import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class DismissButton extends StatelessWidget {
  const DismissButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: Theme.of(context),
      onTap: () => context.navigatorPop<void>(),
      child: SvgPicture.asset(
        SvgPath.icCancelDownload,
        width: fourteenPx,
        colorFilter: buildColorFilter(context.color.subtitleColor),
      ),
    );
  }
}
