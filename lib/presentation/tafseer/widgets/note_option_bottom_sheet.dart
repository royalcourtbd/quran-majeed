import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';

class NoteOptionBottomSheet extends StatelessWidget {
  final Function onRemove;

  NoteOptionBottomSheet({
    super.key,
    required this.onRemove,
  });

  final TafseerPresenter _tafseerPresenter = locate<TafseerPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('NoteOptionBottomSheet'),
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
          iconPath: SvgPath.icCreateNote,
          title: 'Edit This Note',
          onClicked: () async =>
              _tafseerPresenter.onClickNoteCreate(context, true),
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icTrash,
          title: 'Delete This Note',
          onClicked: () => RemoveDialog.show(
            onRemove: () async => onRemove(),
            title: 'Note',
            context: context,
          ),
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required Function onRemove,
  }) async {
    final NoteOptionBottomSheet moreBookmarkOption = await Future.microtask(
      () => NoteOptionBottomSheet(
        onRemove: onRemove,
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(moreBookmarkOption, context);
    }
  }
}
