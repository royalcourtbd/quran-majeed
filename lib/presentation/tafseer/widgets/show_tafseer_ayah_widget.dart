import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/expansion_widget.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/ayah_expandable_header_widget.dart';

class ShowTafseerAyahWidget extends StatelessWidget {
  const ShowTafseerAyahWidget({
    super.key,
    required this.ayahPresenter,
    required this.theme,
    required this.surahID,
    required this.ayahID,
    required this.surahName,
  });

  final ThemeData theme;
  final AyahPresenter ayahPresenter;
  final int surahID;
  final int ayahID;
  final String surahName;
  @override
  Widget build(BuildContext context) {
    final List<WordByWordEntity>? ayahWords =
        ayahPresenter.currentUiState.wordByWordListForSurah[surahID]?.where((word) => word.ayah == ayahID).toList();
    return Padding(
      key: const Key('show_tafseer_ayah_widget'),
      padding: EdgeInsets.symmetric(vertical: eightPx),
      child: ExpansionWidget(
        key: const Key('expansion_widget'),
        initiallyExpanded: true,
        duration: const Duration(milliseconds: 300),
        titleBuilder: (double animationValue, _, bool isExpanded, toggleFunction) {
          return AyahExpandableHeaderWidget(
            key: const Key('ayah_expandable_header_widget'),
            theme: theme,
            surahID: surahID,
            surahName: surahName,
            ayahID: ayahID,
            ayahPresenter: ayahPresenter,
            animationValue: animationValue,
            toggleFunction: toggleFunction,
          );
        },
        content: AyahContainer(
          key: const Key('ayah_container'),
          index: ayahID - 1,
          surahID: surahID,
          ayahNumber: ayahID,
          isFromTafseerPage: true,
          isFromSpecificPage: true,
          ayahTopRowTitle: '$surahID:$ayahID',
          wordData: ayahWords!,
          ayahPresenter: ayahPresenter,
          theme: theme,
          isExpanded: false,
          onClickMore: () => _onAyahMoreClicked(context, ayahWords),
        ),
      ),
    );
  }

  Future<void> _onAyahMoreClicked(BuildContext context, ayahWords) async {
    await ayahPresenter.onClickMoreButton(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: ayahWords,
      isDirectButtonVisible: false,
      isAddMemorizationButtonVisible: true,
      isAddCollectionButtonVisible: true,
      isPlayButtonVisible: true,
      isCopyAyahButtonVisible: true,
    );
  }
}
