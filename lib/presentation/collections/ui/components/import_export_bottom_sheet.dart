import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';

class ImportExportBottomSheet extends StatelessWidget {
  const ImportExportBottomSheet({
    super.key,
    required this.onImportSelected,
    required this.onExportSelected,
  });

  final VoidCallback onImportSelected;
  final VoidCallback onExportSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('ImportExportBottomSheet'),
      theme: theme,
      children: [
        gapH10,
        TopBarWithDismiss(
          title: context.l10n.importExportCollection,
          theme: theme,
        ),
        gapH15,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icDocumentUpload,
          title: context.l10n.importPreviousCollection,
          onClicked: () async {
            onImportSelected();
          },
        ),
        gapH10,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icDocumentDownload,
          title: context.l10n.exportThisCollection,
          onClicked: () {
            onExportSelected();
          },
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onImportSelected,
    required VoidCallback onExportSelected,
  }) async {
    final ImportExportBottomSheet importExportBottomSheet =
        await Future.microtask(
      () => ImportExportBottomSheet(
        key: const Key('ImportExportBottomSheet'),
        onImportSelected: onImportSelected,
        onExportSelected: onExportSelected,
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(importExportBottomSheet, context);
    }
  }
}
