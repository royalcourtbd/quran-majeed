import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/error_notice_dialog_header_image.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/loading_notice_dialog_header_image.dart';

class NoticeDialogHeaderImage extends StatelessWidget {
  const NoticeDialogHeaderImage(
      {super.key, required this.imageUrl, required this.theme});

  final String imageUrl;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: QuranScreen.width,
        height: 40.percentWidth,
        color: theme.primaryColor.withAlpha(50),
        child: Image.asset(
          SvgPath.bgMosque,
          height: 30.percentWidth,
          width: QuranScreen.width,
          fit: BoxFit.cover,
        ),
      );
    }

    if (!imageUrl.contains("http")) {
      return Container(
        width: QuranScreen.width,
        height: 40.percentWidth,
        color: theme.primaryColor.withAlpha(50),
        child: Image.asset(
          SvgPath.bgMosque,
          height: 30.percentWidth,
          width: QuranScreen.width,
          fit: BoxFit.cover,
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          width: QuranScreen.width,
          height: 40.percentWidth,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: QuranScreen.width,
            height: 30.percentWidth,
            progressIndicatorBuilder: (_, __, progress) =>
                LoadingNoticeDialogHeaderImage(progress: progress.progress),
            errorWidget: (_, __, ___) => const ErrorNoticeDialogHeaderImage(),
          ),
        ),
        Positioned(
          top: tenPx,
          right: tenPx,
          child: OnTapWidget(
            theme: theme,
            onTap: () => context.navigatorPop<bool>(result: true),
            child: Container(
              height: twentyThreePx,
              width: twentyThreePx,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4),
              ),
              child: Icon(
                Icons.close,
                size: fifteenPx,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
