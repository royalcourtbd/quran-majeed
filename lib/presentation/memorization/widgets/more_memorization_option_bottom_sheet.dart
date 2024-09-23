import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';

import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';

class MoreMemorizationOptionBottomSheet extends StatelessWidget {
  final MemorizationEntity memorizationEntity;
  MoreMemorizationOptionBottomSheet({
    super.key,
    required this.memorizationEntity,
  });

  final MemorizationPresenter _memorizationPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('MoreMemorizationOptionBottomSheet'),
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
          iconPath: SvgPath.icCalendar,
          title: 'Edit Planer',
          onClicked: () async =>
              _memorizationPresenter.onClickCreatePlanner(context),
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icTrash,
          title: 'Delete Planer',
          onClicked: () {
            RemoveDialog.show(
              onRemove: () async {
                _memorizationPresenter.deleteMemorization(
                  memorizationEntity.id ?? '0',
                );
              },
              title: 'Planer',
              context: context,
            );
          },
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required MemorizationEntity memorizationEntity,
  }) async {
    final MoreMemorizationOptionBottomSheet moreMemorizationOption =
        await Future.microtask(
      () => MoreMemorizationOptionBottomSheet(
        memorizationEntity: memorizationEntity,
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(moreMemorizationOption, context);
    }
  }
}
