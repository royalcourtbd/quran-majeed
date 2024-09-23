import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class ThreeDotOption extends StatelessWidget {
  const ThreeDotOption({
    super.key,
    required this.theme,
    this.onOptionTap,
  });

  final ThemeData theme;
  final VoidCallback? onOptionTap;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: theme,
      onTap: onOptionTap,
      // onTap: () {
      //   // if (!isNote) {
      //   //   _tafseerPresenter.onClickTafseerPageMoreButton(
      //   //     context: context,
      //   //     surahID: 1,
      //   //     ayahID: 1,
      //   //     color: Colors.red,
      //   //     folderName: "folderName",
      //   //     isDirectButtonVisible: false,
      //   //     isAddMemorizationButtonVisible: true,
      //   //     idAddCollectionButtonVisible: true,
      //   //   );
      //   // }

      // },
      child: FadeIn(
        child: SvgPicture.asset(
          SvgPath.icThreeDotOption,
          width: eighteenPx,
          colorFilter: buildColorFilterToChangeColor(
            context.color.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
