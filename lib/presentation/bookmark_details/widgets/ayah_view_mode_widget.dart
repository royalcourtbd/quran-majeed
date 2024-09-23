import 'package:flutter/material.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_ayah_details_list_item.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_ayah_simple_list_item.dart';

class AyahViewModeWidget extends StatelessWidget {
  const AyahViewModeWidget({
    super.key,
    required this.collectionPresenter,
    required this.index,
    required this.ayahPresenter,
    required this.bookmarks,
    required this.isGrid,
    required this.theme,
    this.onRemove,
  });

  final CollectionPresenter collectionPresenter;
  final int index;
  final AyahPresenter ayahPresenter;
  final BookmarkEntity bookmarks;
  final bool isGrid;
  final ThemeData theme;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? BookmarkAyahSimpleListItem(
            collectionPresenter: collectionPresenter,
            index: index,
            bookmarks: bookmarks,
            theme: theme,
            onRemove: onRemove,
          )
        : BookmarkAyahDetailsListItem(
            index: index,
            collectionPresenter: collectionPresenter,
            ayahPresenter: ayahPresenter,
            bookmark: bookmarks,
            theme: theme,
            onRemove: onRemove,
          );
  }
}
