import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';

class MoreNoteOptionBottomSheet extends StatelessWidget {
  const MoreNoteOptionBottomSheet({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      key: const Key('MoreNoteOptionBottomSheet'),
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
          title: 'Edit Note',
          onClicked: () {},
        ),
        gapH5,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icTrash,
          title: 'Delete Note',
          onClicked: () => RemoveDialog.show(
            onRemove: () async {},
            title: 'Note',
            // onRemove: () async => onRemoveBookmarkFolder(bookmarkFolder),
            context: context,
          ),
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required ThemeData theme,
  }) async {
    final MoreNoteOptionBottomSheet moreNoteOptionBottomSheet =
        await Future.microtask(() => MoreNoteOptionBottomSheet(
              key: const Key("MoreNoteOptionBottomSheet"),
              theme: theme,
            ));
    if (context.mounted) {
      await context.showBottomSheet(moreNoteOptionBottomSheet, context);
    }
  }
}
