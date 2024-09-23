import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/positioned_scroll_bar.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/centered_page_indicator.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/surah_header.dart';

class AyahContentWidget extends StatefulWidget {
  const AyahContentWidget({
    super.key,
    required this.pageIndex,
    required this.ayahPresenter,
    required this.uiState,
  });

  final int pageIndex;
  final AyahPresenter ayahPresenter;
  final AyahViewUiState uiState;

  @override
  AyahContentWidgetState createState() => AyahContentWidgetState();
}

class AyahContentWidgetState extends State<AyahContentWidget> {
  late Future<List<WordByWordEntity>> _wordsFuture;
  bool _mounted = true;
  bool _isScrollControllerAttached = false;

  @override
  void initState() {
    super.initState();
    _wordsFuture = widget.ayahPresenter.getWordsForSurah(widget.pageIndex + 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isScrollControllerAttached = true;
        });
      }
    });
  }

  @override
  void didUpdateWidget(AyahContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageIndex != widget.pageIndex) {
      _wordsFuture = widget.ayahPresenter.getWordsForSurah(widget.pageIndex + 1);
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SurahEntity surah = CacheData.surahsCache[widget.pageIndex];

    return FutureBuilder<List<WordByWordEntity>>(
      future: _wordsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget(surah, theme);
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        final List<WordByWordEntity> wordData = snapshot.data ?? [];
        return _buildContent(surah, theme, wordData);
      },
    );
  }

  Widget _buildContent(SurahEntity surah, ThemeData theme, List<WordByWordEntity> wordData) {
    return PositionedScrollBar(
      key: Key('ayah_content_widget_${widget.pageIndex}'),
      controller: widget.ayahPresenter.getScrollController(widget.pageIndex),
      showScrollBar: _isScrollControllerAttached,
      listView: ScrollablePositionedList.builder(
        itemCount: surah.totalAyah,
        itemScrollController: widget.ayahPresenter.getScrollController(widget.pageIndex),
        itemPositionsListener: widget.ayahPresenter.getItemPositionsListener(widget.pageIndex),
        itemBuilder: (context, ayahIndex) {
          final int ayahNumber = ayahIndex + 1;
          final List<WordByWordEntity> ayahWords = wordData.where((word) => word.ayah == ayahNumber).toList();

          final bool isFirstAyah = ayahIndex == 0;
          final bool isNewPage =
              CacheData.uniquePageIDwithSurahAndAyahID.containsValue('${widget.pageIndex + 1}:$ayahNumber');
          final WordByWordEntity? firstWordOfPageAyah = ayahWords.isNotEmpty ? ayahWords.first : null;

          return Column(
            children: [
              if (isFirstAyah)
                SurahHeader(
                  surah: surah,
                  theme: theme,
                ),
              if (isFirstAyah || isNewPage)
                CenteredPageIndicator(
                  theme: theme,
                  pageNumber: firstWordOfPageAyah?.page ?? 0,
                  juzNumber: firstWordOfPageAyah?.juz ?? 0,
                  hijbNumber: firstWordOfPageAyah?.hijb != null
                      ? widget.ayahPresenter.formatHijbNumber(firstWordOfPageAyah!.hijb!)
                      : '',
                ),
              AyahContainer(
                theme: theme,
                isFromSpecificPage: true,
                onTapAyahCard: () {
                  if (_mounted) {
                    widget.ayahPresenter.onTapAyahCard(
                      context: context,
                      surahID: surah.serial,
                      ayahNumber: ayahNumber,
                    );
                  }
                },
                ayahPresenter: widget.ayahPresenter,
                index: ayahIndex,
                surahID: widget.pageIndex + 1,
                ayahNumber: ayahNumber,
                ayahTopRowTitle: '$ayahNumber',
                wordData: ayahWords,
                onClickMore: () {
                  if (_mounted) {
                    widget.ayahPresenter.onAyahMoreClicked(
                      context: context,
                      surah: surah,
                      ayahNumber: ayahNumber,
                      wordByWordList: ayahWords,
                    );
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget(SurahEntity surah, ThemeData theme) {
    return Column(
      children: [
        SurahHeader(
          surah: surah,
          theme: theme,
        ),
        const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
