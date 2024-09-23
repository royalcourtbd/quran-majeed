import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/common/show_surah_number_widget.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_presenter.dart';

class LastReadItem extends StatelessWidget {
  LastReadItem({super.key, required this.index, required this.lastReadList});
  final int index;
  final List<LastReadEntity> lastReadList;
  final LastReadPresenter _lastReadPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final String surahNumberFormatted = _lastReadPresenter
        .formatSurahNumber(lastReadList[index].surahIndex + 1);
    final ThemeData theme = Theme.of(context);
    return isMobile
        ? Material(
            color: Colors.transparent,
            child: OnTapWidget(
              theme: theme,
              onTap: () async {
                if (_lastReadPresenter.uiState.value.checkBox) {
                  _lastReadPresenter.selectLastReadItem(index);
                } else {
                  await _lastReadPresenter.navigateToSurah(
                    context: context,
                    surahIndex: lastReadList[index].surahIndex,
                    ayahIndex: lastReadList[index].ayahIndex,
                  );
                }
              },
              onLongPress: () {
                _lastReadPresenter.selectLastReadItem(index);
                _lastReadPresenter.toggleSelectionVisibility();
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: twentyPx, vertical: tenPx),
                child: Row(
                  children: [
                    Visibility(
                      visible: _lastReadPresenter.uiState.value.checkBox,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) =>
                              _lastReadPresenter.selectLastReadItem(index),
                          value: _lastReadPresenter.uiState.value.isSelected
                              .contains(index),
                        ),
                      ),
                    ),
                    _lastReadPresenter.uiState.value.checkBox
                        ? gapW15
                        : const SizedBox.shrink(),
                    ShowSurahNumberWidget(
                      formatSurahNumber: surahNumberFormatted,
                      theme: theme,
                    ),
                    gapW15,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lastReadList[index].surahName,
                          style: theme.textTheme.titleMedium,
                        ),
                        gapH3,
                        Text(
                            '${context.l10n.ayah} ${lastReadList[index].ayahIndex}',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: context.color.subtitleColor,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : OnTapWidget(
            theme: theme,
            onTap: () {
              if (_lastReadPresenter.uiState.value.checkBox) {
                _lastReadPresenter.selectLastReadItem(index);
              }
            },
            onLongPress: () {
              _lastReadPresenter.selectLastReadItem(index);
              _lastReadPresenter.toggleSelectionVisibility();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: radius8,
                border: Border.all(
                  color: theme.cardColor.withOpacity(0.5),
                ),
              ),
              padding: padding5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowSurahNumberWidget(
                    formatSurahNumber: surahNumberFormatted,
                    theme: theme,
                  ),
                  gapW15,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lastReadList[index].surahName,
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH3,
                      Text(
                        'Ayah ${lastReadList[index].ayahIndex}',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: context.color.subtitleColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
