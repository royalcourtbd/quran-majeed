import 'package:flutter/material.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';

class BookmarkAyahDetailsListItem extends StatelessWidget {
  const BookmarkAyahDetailsListItem({
    super.key,
    required this.index,
    required this.collectionPresenter,
    required this.ayahPresenter,
    required this.bookmark,
    required this.theme,
    this.onRemove,
  });

  final CollectionPresenter collectionPresenter;
  final AyahPresenter ayahPresenter;
  final int index;
  final BookmarkEntity bookmark;
  final ThemeData theme;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("ayah_${bookmark.ayahID}"),
      decoration: BoxDecoration(
        color: index.isEven ? theme.scaffoldBackgroundColor : theme.cardColor.withOpacity(0.5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AyahContainer(
            index: index,
            ayahPresenter: ayahPresenter,
            surahID: bookmark.surahID,
            ayahNumber: bookmark.ayahID,
            ayahTopRowTitle:
                '${CacheData.surahsCache[bookmark.surahID - 1].nameEn} ${bookmark.surahID}:${bookmark.ayahID}',
            wordData: collectionPresenter.currentUiState.ayahcache[bookmark.surahID]?[bookmark.ayahID] ?? [],
            onClickMore: () => collectionPresenter.onClickBookmarkPageMoreButton(
              context: context,
              surahID: bookmark.surahID,
              ayahID: bookmark.ayahID,
              bookmark: bookmark,
               folderName: bookmark.folderName,
              listOfWordByWordEntity:  collectionPresenter.currentUiState.ayahcache[bookmark.surahID]?[bookmark.ayahID] ?? [],
              isDirectButtonVisible: true,
              idAddCollectionButtonVisible: false,
              isAddMemorizationButtonVisible: true,
              onRemoveItem: (_) => onRemove?.call(),
            ),
            theme: theme,
          ),
        ],
      ),
    );
  }
}
