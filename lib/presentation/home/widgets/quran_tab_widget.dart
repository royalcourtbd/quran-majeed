import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class QuranTabWidget extends StatelessWidget {
  const QuranTabWidget({
    super.key,
    required this.theme,
    required HomePresenter homePresenter,
  }) : _homePresenter = homePresenter;

  final ThemeData theme;
  final HomePresenter _homePresenter;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        margin: paddingH20,
        padding: padding4,
        height: QuranScreen.width * 0.11,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: radius10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _homePresenter.quranTabButtonTextList
                .length, // Double the number of containers to account for dividers
            (index) {
              return Expanded(
                child: OnTapWidget(
                  theme: theme,
                  onTap: () {
                    if (index != 0) {
                      showComingSoonMessage(context: context);
                    } else {
                      _homePresenter.changeTabIndex(index);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          _homePresenter.currentUiState.tabButtonCurrentIndex ==
                                  index
                              ? theme.primaryColor
                              : theme.cardColor,
                      borderRadius: radius8,
                    ),
                    child: Text(
                      _homePresenter.quranTabButtonTextList[index],
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: _homePresenter.getColor(
                            context,
                            _homePresenter.currentUiState.tabButtonCurrentIndex,
                            index),
                        fontWeight: index ==
                                _homePresenter
                                    .currentUiState.tabButtonCurrentIndex
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: tenPx),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'AL Quran',
              textAlign: TextAlign.start,
              style: context.quranText.lableExtraSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              width: QuranScreen.width * 0.45,
              height: QuranScreen.width * 0.05,
              padding: padding2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: radius5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _homePresenter.quranTabButtonTextList.length,
                  (index) {
                    bool isSelected =
                        _homePresenter.currentUiState.tabButtonCurrentIndex ==
                            index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (index != 0) {
                            showComingSoonMessage(context: context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.textTheme.displayLarge!.color
                                : theme.cardColor,
                            borderRadius: radius4,
                          ),
                          // theme.textTheme.bodyMedium!.copyWith(
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: isMobile ? fourteenPx : sevenPx,
                          // ),

                          child: Text(
                            _homePresenter.quranTabButtonTextList[index],
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: _homePresenter.getColor(
                                  context,
                                  _homePresenter
                                      .currentUiState.tabButtonCurrentIndex,
                                  index),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: sevenPx,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
