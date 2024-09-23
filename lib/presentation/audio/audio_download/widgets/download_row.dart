import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/audio/audio_download/widgets/share_button.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';

class DownloadRow extends StatelessWidget {
  final ThemeData theme;
  final VoidCallback? tapOnDownloadButton;
  final VoidCallback? tapOnShareButton;
  const DownloadRow({
    super.key,
    required this.theme,
    this.tapOnDownloadButton,
    this.tapOnShareButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: tapOnDownloadButton,
            child: SubmitButton(
              title: context.l10n.download,
              theme: theme,
              textColor: context.color.subtitleColor,
              buttonColor: theme.cardColor,
              svgPicture: SvgImage(
                SvgPath.icDownloadFill,
                height: twentyPx,
                width: twentyPx,
                color: context.color.subtitleColor,
              ),
            ),
          ),
        ),
        gapW10,
        ShareButton(
          theme: theme,
          tapOnShareButton: tapOnShareButton,
        ),
      ],
    );
  }
}
