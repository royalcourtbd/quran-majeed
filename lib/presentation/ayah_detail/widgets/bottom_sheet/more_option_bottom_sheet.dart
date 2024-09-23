import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';

class MoreOptionBottomSheet extends StatelessWidget {
  final int surahID;
  final int ayahID;
  final List<WordByWordEntity> listOfWordByWordEntity;
  final BookmarkEntity? bookmark;
  final bool isDirectButtonVisible;
  final bool isAddMemorizationButtonVisible;
  final bool idAddCollectionButtonVisible;
  final bool isPlayButtonVisible;
  final bool isCopyAyahButtonVisible;
  final bool isFromBookmark;
  final bool isFromMemorization;
  final bool isFromTafseer;
  final void Function(BookmarkEntity)? onBookmarkRemoved;

  MoreOptionBottomSheet({
    super.key,
    required this.surahID,
    required this.ayahID,
    required this.listOfWordByWordEntity,
    this.bookmark,
    this.onBookmarkRemoved,
    this.isDirectButtonVisible = true,
    this.isAddMemorizationButtonVisible = true,
    this.idAddCollectionButtonVisible = true,
    this.isPlayButtonVisible = true,
    this.isCopyAyahButtonVisible = true,
    this.isFromBookmark = false,
    this.isFromMemorization = false,
    this.isFromTafseer = false,
  });

  static Future<void> show({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    BookmarkEntity? bookmark,
    void Function(BookmarkEntity)? onBookmarkRemoved,
    bool isDirectButtonVisible = false,
    bool isAddMemorizationButtonVisible = true,
    bool idAddCollectionButtonVisible = true,
    bool isPlayButtonVisible = true,
    bool isCopyAyahButtonVisible = true,
    bool isFromBookmark = false,
    bool isFromMemorization = false,
    bool isFromTafseer = false,
  }) async {
    final MoreOptionBottomSheet moreOptionBottomSheet = await Future.microtask(
      () => MoreOptionBottomSheet(
        surahID: surahID,
        ayahID: ayahID,
        listOfWordByWordEntity: listOfWordByWordEntity,
        bookmark: bookmark,
        onBookmarkRemoved: onBookmarkRemoved,
        isDirectButtonVisible: isDirectButtonVisible,
        isAddMemorizationButtonVisible: isAddMemorizationButtonVisible,
        idAddCollectionButtonVisible: idAddCollectionButtonVisible,
        isPlayButtonVisible: isPlayButtonVisible,
        isCopyAyahButtonVisible: isCopyAyahButtonVisible,
        isFromBookmark: isFromBookmark,
        isFromMemorization: isFromMemorization,
        isFromTafseer: isFromTafseer,
        key: const Key("MoreOptionBottomSheet"),
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(moreOptionBottomSheet, context);
    }
  }

  late final AyahPresenter _ayahPresenter = locate<AyahPresenter>();
  late final MemorizationPresenter _memoraizationPresenter =
      locate<MemorizationPresenter>();
  late final CollectionPresenter _collectionPresenter =
      locate<CollectionPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SurahEntity surah = CacheData.surahsCache[surahID - 1];
    return CustomBottomSheetContainer(
      key: const Key('MoreOptionBottomSheet'),
      bottomSheetTitle:
          '${getTranslatedSurahName(surah: surah, context: context)} $surahID : ${context.l10n.verses} $ayahID',
      theme: theme,
      children: [
        if (isDirectButtonVisible) ...[
          MenuListItem(
            key: const Key('DirectButton'),
            theme: theme,
            iconPath: SvgPath.icMaximize,
            title: context.l10n.direct,
            onClicked: () async {
              await _ayahPresenter.goToAyahPageWithSurahAndAyahID(
                context: context,
                surahID: surahID,
                ayahID: ayahID,
                isNeedToPop: false,
              );
            },
          ),
          gapH8,
        ],
        if (!isPlayButtonVisible) ...[
          MenuListItem(
            key: const Key('PlayButton'),
            theme: theme,
            iconPath: SvgPath.icPlayOutline,
            title: context.l10n.playThisAyah,
            onClicked: () async => await _ayahPresenter.onClickPlayAyah(
              context,
            ),
          ),
          gapH8,
        ],

        ///TODO: Ekhon Shudhu condition check kora ase j play button ki visible kina and eta ki bookmark page theke call hoise kina, oi onujay play button dekhano hosse, jokhn Hifz and dowa er kaj kora hobe tokhon condition update korte hobe
        if (isPlayButtonVisible && !isFromBookmark) ...[
          MenuListItem(
              key: const Key('isPlayButtonVisible'),
              theme: theme,
              iconPath: SvgPath.icPlayOutline,
              title: context.l10n.playThisAyah,
              onClicked: () async {
                if (isFromBookmark) {
                  //TODO : in version 2.0.0 inshaAllah
                  // _bookmarkDetailsPresenter.togglePlayer();
                } else if (isFromMemorization) {
                  _memoraizationPresenter.toggleAudioPlayer();
                } else {
                  await _ayahPresenter.onClickPlayAyah(context);
                }
              }),
          gapH8,
        ],
        MenuListItem(
          key: const Key('isFromTafseer'),
          theme: theme,
          iconPath: SvgPath.icOpenBookOutline,
          title: context.l10n.seeTafseer,
          onClicked: () async {
            await _ayahPresenter.onTapAyahCard(
              context: context,
              surahID: surahID,
              ayahNumber: ayahID,
            );
          },
        ),
        gapH8,
        if (isAddMemorizationButtonVisible) ...[
          MenuListItem(
            key: const Key('AddMemorizationButton'),
            theme: theme,
            iconPath: SvgPath.icCalendar,
            title: context.l10n.addToMemorization,
            onClicked: () {
              _ayahPresenter.addUserMessage('Coming Soon!');

              // await _memoraizationPresenter.onClickCreatePlanner(context);
            },
          ),
          gapH8,
        ],
        if (!isAddMemorizationButtonVisible) ...[
          MenuListItem(
            key: const Key('isAddMemorizationButtonVisible'),
            theme: theme,
            iconPath: SvgPath.icDeleteOutline,
            title: 'Remove From Memorization',
            onClicked: () async {
              // await _onClickEdit(context);
            },
          ),
          gapH8,
        ],
        if (idAddCollectionButtonVisible) ...[
          MenuListItem(
            key: const Key('isAddCollectionButtonVisible'),
            theme: theme,
            iconPath: SvgPath.icStackStar,
            title: context.l10n.addToCollection,
            onClicked: () async {
              await _collectionPresenter.onCollectionClicked(
                context: context,
                surahID: surahID,
                ayahID: ayahID,
                ayahPresenter: _ayahPresenter,
              );
            },
          ),
        ],
        if (!idAddCollectionButtonVisible)
          MenuListItem(
            key: const Key('isAddCollectionButtonVisible'),
            theme: theme,
            iconPath: SvgPath.icDeleteOutline,
            title: context.l10n.removeFromThisFolder,
            onClicked: () async => await _onBookmarkRemove(bookmark),
          ),
        gapH8,
        if (isCopyAyahButtonVisible) ...[
          MenuListItem(
            theme: theme,
            iconPath: SvgPath.icDoubleCopy,
            title: context.l10n.copyAyah,
            onClicked: () async {
              await _ayahPresenter.copySingleAyahText(
                  surahID: surahID,
                  ayahID: ayahID,
                  listOfWordByWordEntity: listOfWordByWordEntity);
            },
          ),
          gapH8,
        ],
        if (!isCopyAyahButtonVisible) ...[
          MenuListItem(
            theme: theme,
            iconPath: SvgPath.icDoubleCopy,
            title: 'Copy Dua',
            onClicked: () async {},
          ),
          gapH8,
        ],
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icShare2,
          title: context.l10n.shareAyah,
          onClicked: () async {
            await _ayahPresenter.onClickShareButton(
              context: context,
              surahID: surahID,
              ayahID: ayahID,
              listOfWordByWordEntity: listOfWordByWordEntity,
            );
          },
        ),
        gapH8,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icReport,
          title: context.l10n.report,
          onClicked: () async {
            // showComingSoonMessage(context: context);
            _ayahPresenter.addUserMessage('Coming Soon!');
          },
        ),
      ],
    );
  }

  Future<void> _onBookmarkRemove(bookmark) async {
    onBookmarkRemoved?.call(bookmark);
  }
}
