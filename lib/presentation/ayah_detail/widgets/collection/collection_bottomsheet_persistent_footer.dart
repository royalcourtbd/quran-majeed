import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';

class CollectionBottomSheetPersistentFooter extends StatelessWidget {
  const CollectionBottomSheetPersistentFooter({
    super.key,
    required this.surahID,
    required this.ayahID,
    required this.onBookmarkToggled,
    required this.onNewCreateBottomSheetClosed,
    required this.theme,
    required this.presenter,
  });

  final CollectionPresenter presenter;
  final int surahID;
  final int ayahID;
  final void Function(int, {required bool isBookmarked}) onBookmarkToggled;
  final VoidCallback onNewCreateBottomSheetClosed;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 14.percentWidth,
      padding: padding15,
      color: theme.scaffoldBackgroundColor,
      child: TwoWayActionButton(
        key: const Key("TwoWayActionButton"),
        theme: theme,
        cancelButtonBgColor: theme.cardColor,
        submitButtonTextColor: context.color.whiteColor,
        onCancelButtonTap: () {
          presenter.onClickNewCreate(
            context: context,
            surahID: surahID,
            ayahID: ayahID,
            presenter: presenter,
          );
          onNewCreateBottomSheetClosed();
        },
        onSubmitButtonTap: () => presenter.doneButtonHandler(
          context: context,
          surahID: surahID,
          ayahID: ayahID,
          onBookmarkToggled: onBookmarkToggled,
        ),
        cancelButtonTitle: context.l10n.createNew,
        submitButtonTitle: context.l10n.done,
      ),
    );
  }
}
