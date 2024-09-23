import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/audio_download/ui/audio_download_page.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/ui/reciter_page.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class ReciterListItem extends StatelessWidget {
  final Reciter reciter;
  final ThemeData theme;

  const ReciterListItem({
    required this.reciter,
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final ReciterPresenter reciterPresenter =
        context.findAncestorWidgetOfExactType<ReciterPage>()!.reciterPresenter;
    return OnTapWidget(
      theme: theme,
      onTap: () => context.navigatorPush(AudioDownloadPage(
        reciter: reciter,
      )),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: fourteenPx),
        child: Row(
          children: [
            Container(
              width: 12.percentWidth,
              height: 12.percentWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.color.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
                borderRadius: radius10,
                image: DecorationImage(
                  image:
                      AssetImage(reciterPresenter.getImagePath(reciter.name)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            gapW15,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${reciter.name} ',
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapH3,
                  Text(
                    '114 ${context.l10n.surahAvailableForDownload}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: context.color.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // SvgImage(
            //   SvgPath.icDownloadShade,
            //   width: twentyTwoPx,
            //   height: twentyTwoPx,
            //   color: context.color.primaryColor.withOpacity(0.5),
            // )
          ],
        ),
      ),
    );
  }
}
