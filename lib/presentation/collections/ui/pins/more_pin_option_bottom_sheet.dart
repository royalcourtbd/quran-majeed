import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/edit_pin_bottomsheet.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';

class MorePinOptionBottomSheet extends StatelessWidget {
  final dynamic pin;
  const MorePinOptionBottomSheet({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('MorePinOptionBottomSheet'),
      theme: theme,
      children: [
        gapH10,
        TopBarWithDismiss(
          title: context.l10n.otherOptions,
          theme: theme,
        ),
        gapH15,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icPinOutline,
          title: 'Edit Pin',
          onClicked: () => EditPinBottomSheet.show(
            context: context,
            pin: pin,
          ),
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icTrash,
          title: 'Delete Pin',
          onClicked: () => RemoveDialog.show(
            onRemove: () async => {}
            //  _presenter.deletePin(pin: pin)
            ,
            title: 'Pin',
            context: context,
          ),
        ),
      ],
    );
  }

  static Future<void> show({
    required dynamic pin,
    required BuildContext context,
  }) async {
    final MorePinOptionBottomSheet morePinOptionBottomSheet =
        await Future.microtask(
      () => MorePinOptionBottomSheet(
        pin: pin,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(morePinOptionBottomSheet, context);
    }
  }
}
