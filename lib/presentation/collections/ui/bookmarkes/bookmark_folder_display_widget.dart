import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_folder_list_item.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_folder_tab_list_item.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/more_bookmark_option_bottom_sheet.dart';

class BookmarkFolderDisplayWidget extends StatelessWidget {
  const BookmarkFolderDisplayWidget({
    super.key,
    required this.presenter,
    required this.theme,
    required this.bookmarkFolders,
  });

  final CollectionPresenter presenter;
  final ThemeData theme;

  final List<BookmarkFolderEntity> bookmarkFolders;

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: bookmarkFolders.length,
            itemBuilder: (_, index) => BookmarkFolderListItem(
              theme: theme,
              presenter: presenter,
              bookmarkFolder: bookmarkFolders[index],
              onMoreOptionClicked: (folder) =>
                  MoreBookmarkOptionBottomSheet.show(
                folder: folder,
                context: context,
                onRemoveBookmarkFolder: (folder) =>
                    presenter.deleteBookmarkFolder(folder: folder),
                onEditBookmarkFolder: (folder, newName, color) =>
                    presenter.updateBookmarkFolder(
                  folder: folder,
                  newName: newName,
                  newColor: color,
                ),
                theme: theme,
              ),
            ),
          )
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: thirtyFivePx,
              crossAxisSpacing: fivePx,
              mainAxisSpacing: fivePx,
            ),
            padding: EdgeInsets.only(
              left: fourteenPx,
              right: fourteenPx,
              bottom: thirtyFivePx,
            ),
            itemCount: bookmarkFolders.length,
            itemBuilder: (_, index) => BookmarkFolderTabListItem(
              theme: theme,
              bookmarkFolder: bookmarkFolders[index],
              onMoreOptionClicked: (folder) =>
                  MoreBookmarkOptionBottomSheet.show(
                folder: folder,
                context: context,
                onRemoveBookmarkFolder: (folder) =>
                    presenter.deleteBookmarkFolder(folder: folder),
                onEditBookmarkFolder: (folder, newName, color) =>
                    presenter.updateBookmarkFolder(
                  folder: folder,
                  newName: newName,
                  newColor: color,
                ),
                theme: theme,
              ),
            ),
          );
  }
}
