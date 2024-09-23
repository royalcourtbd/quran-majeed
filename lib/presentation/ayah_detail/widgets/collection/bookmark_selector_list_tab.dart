import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/bookmark_folder_selectable_item.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';

class BookmarkSelectorListTab extends StatelessWidget {
  const BookmarkSelectorListTab({
    super.key,
    required this.bookmarkFolders,
    required this.selectedBookmarkFolderNames,
    required this.theme,
    required this.presenter,
  });

  final List<dynamic> bookmarkFolders;
  final Set<String> selectedBookmarkFolderNames;
  final ThemeData theme;
  final CollectionPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookmarkFolders.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        final dynamic folder = bookmarkFolders[index];
        final bool isSelected =
            selectedBookmarkFolderNames.contains(folder.name);
        return BookmarkFolderSelectableItem(
          collectionPresenter: presenter,
          isSelected: isSelected,
          folder: folder,
          theme: theme,
        );
      },
    );
  }
}
