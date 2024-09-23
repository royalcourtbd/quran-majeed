import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';

class TafseerCopyBottomSheet extends StatelessWidget {
  TafseerCopyBottomSheet({super.key});

  static Future<void> show({
    required BuildContext context,
  }) async {
    final TafseerCopyBottomSheet copyTafseerBottomSheet =
        await Future.microtask(
      () => TafseerCopyBottomSheet(
        key: const Key("CopyTafseerBottomSheet"),
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(copyTafseerBottomSheet, context);
    }
  }

  final AyahPresenter ayahPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomBottomSheetContainer(
      key: const Key('CopyTafseerBottomSheet'),
      theme: theme,
      bottomSheetTitle: 'Al Fatihah 1:1',
      showPadding: true,
      children: [
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icCopy,
          title: 'Copy Ayah',
          onClicked: () {},
        ),
        gapH5,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icAdvanceCoopy,
          title: 'Copy Tafseer',
          onClicked: () {},
        ),
        gapH5,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icShare,
          title: 'Share Tafseer',
          onClicked: () {},
        ),
      ],
    );
  }
}
