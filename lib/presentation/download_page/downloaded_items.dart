import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/download_page/download_item_widget.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';

class DownloadedItems extends StatelessWidget {
  const DownloadedItems({
    super.key,
    required this.downloadedItems,
    required this.title,
    required this.isItemSelected,
    required this.deleteItem,
    required this.theme,
    required this.downloadProgress,
    required this.onSelectItem,
    required this.isShowDeleteButton,
    this.surahID,
  });
  final List<TTDbFileModel> downloadedItems;
  final String title;
  final bool Function(TTDbFileModel) isItemSelected;
  final void Function(TTDbFileModel) deleteItem;
  final Future<void> Function({required TTDbFileModel file, int surahID})
      onSelectItem;
  final ThemeData theme;
  final int downloadProgress;
  final bool Function(TTDbFileModel) isShowDeleteButton;
  final int? surahID;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: SectionHeader(
            theme: theme,
            title:
                '${context.l10n.downloaded} $title (${downloadedItems.length})',
          ),
        ),
        gapH5,
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: downloadedItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final TTDbFileModel item = downloadedItems[index];

            return DownloadItemWidget(
              item: item,
              theme: theme,
              onSelectItem: () async =>
                  await onSelectItem(file: item, surahID: surahID ?? 1),
              isSelected: isItemSelected(item),
              onDelete: () => deleteItem(item),
              downloadProgress: downloadProgress,
              showCheckbox: true,
              showDelete: isShowDeleteButton(item),
            );
          },
        ),
      ],
    );
  }
}
