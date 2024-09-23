import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';

import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/audio_download/ui/audio_download_page.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/ui/default_reciter_card.dart';

class ReciterDownloadedSection extends StatelessWidget {
  final List<Reciter> reciters;
  final ReciterPresenter reciterPresenter;
  const ReciterDownloadedSection({
    super.key,
    required this.reciters,
    required this.reciterPresenter,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (!reciterPresenter.currentUiState.isDefaultReciterDownloaded &&
          reciters.isEmpty)
        DefaultReciterCard(
          reciter: reciterPresenter.currentUiState.defaultReciter,
          theme: theme,
          reciterPresenter: reciterPresenter,
        ),
      ...List.generate(
        reciters.length,
        (index) => InkWell(
          onTap: () => reciterPresenter.selectReciter(
            reciter: reciters[index],
            index: index,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: fourteenPx),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: reciterPresenter.currentUiState.selectedReciterIndex,
                    groupValue: index,
                    onChanged: (value) => reciterPresenter.selectReciter(
                      reciter: reciters[index],
                      index: index,
                    ),
                    activeColor: context.color.primaryColor,
                    fillColor: WidgetStateProperty.all(index ==
                            reciterPresenter.currentUiState.selectedReciterIndex
                        ? context.color.primaryColor
                        : context.color.primaryColor.withOpacity(0.38)),
                    visualDensity: VisualDensity(horizontal: -threePx),
                  ),
                ),
                gapW8,
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
                      image: AssetImage(
                          reciterPresenter.getImagePath(reciters[index].name)),
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
                        reciters[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH3,
                      Text(
                        '${reciterPresenter.currentUiState.downloadedSurahCounts?[reciters[index].id] ?? 0} | 114 Sura Downloaded',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: context.color.subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                gapW10,
                InkWell(
                  onTap: () => context.navigatorPush(AudioDownloadPage(
                    reciter: reciters[index],
                  )),
                  child: SvgPicture.asset(
                    SvgPath.icDownloadShade,
                    width: twentyTwoPx,
                    colorFilter: buildColorFilter(
                      context.color.primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                ...(index != 0
                    ? [
                        gapW15,
                        SvgPicture.asset(
                          SvgPath.icDeleteOutline,
                          width: twentyTwoPx,
                          colorFilter: buildColorFilter(
                            context.color.primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ]
                    : []),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
