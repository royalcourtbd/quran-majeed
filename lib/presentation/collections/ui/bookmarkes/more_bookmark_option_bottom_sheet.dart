import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';

import 'package:quran_majeed/presentation/collections/ui/bookmarkes/edit_bookmark_bottomsheet.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';

class MoreBookmarkOptionBottomSheet extends StatelessWidget {
  final void Function(BookmarkFolderEntity) onRemoveBookmarkFolder;
  final Future<bool> Function(String, Color) onEditBookmarkFolder;
  final BookmarkFolderEntity folder;
  final ThemeData theme;
  const MoreBookmarkOptionBottomSheet({
    super.key,
    required this.onRemoveBookmarkFolder,
    required this.onEditBookmarkFolder,
    required this.folder,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      key: const Key('MoreBookmarkOptionBottomSheet'),
      theme: theme,
      children: [
        gapH10,
        TopBarWithDismiss(
          title: context.l10n.otherOptions,
          theme: theme,
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icBookmarkOutline,
          title: context.l10n.editFolder,
          onClicked: () async {
            await EditBookmarkBottomSheet.show(
              context: context,
              bookmarkFolder: folder,
              onEditBookmarkFolder: onEditBookmarkFolder,
            );
          },
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icTrash,
          title: context.l10n.deleteFolder,
          onClicked: () => RemoveDialog.show(
            onRemove: () async => onRemoveBookmarkFolder(folder),
            title: context.l10n.bookmark,
            context: context,
          ),
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required void Function(BookmarkFolderEntity) onRemoveBookmarkFolder,
    required Future<bool> Function(BookmarkFolderEntity, String, Color)
        onEditBookmarkFolder,
    required BookmarkFolderEntity folder,
    required ThemeData theme,
  }) async {
    final MoreBookmarkOptionBottomSheet moreBookmarkOption =
        await Future.microtask(
      () => MoreBookmarkOptionBottomSheet(
        onRemoveBookmarkFolder: (folder) => onRemoveBookmarkFolder(folder),
        onEditBookmarkFolder: (newName, color) async =>
            onEditBookmarkFolder(folder, newName, color),
        theme: theme,
        folder: folder,
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(moreBookmarkOption, context);
    }
  }
}
