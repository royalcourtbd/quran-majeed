import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/common/buttons/download_button.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';

class DownloadItemWidget extends StatelessWidget {
  const DownloadItemWidget({
    super.key,
    required this.item,
    this.isSelected = false,
    this.onSelectItem,
    this.onDelete,
    this.showCheckbox = false,
    this.showDelete = false,
    required this.theme,
    required this.downloadProgress,
  });

  final TTDbFileModel item;
  final bool isSelected;
  final VoidCallback? onSelectItem;
  final VoidCallback? onDelete;
  final bool showCheckbox;
  final bool showDelete;
  final ThemeData theme;
  final int downloadProgress;

  @override
  Widget build(BuildContext context) {
    final presenter =
        context.findAncestorWidgetOfExactType<DownloadPage>()?.presenter;
    final bool isDownloading =
        presenter?.isFileDownloading(item.fileName) ?? false;
    return Material(
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => onSelectItem
            ?.call(), // Call onSelectItem when checkbox value changes,
        child: Padding(
          padding: EdgeInsets.only(
            top: tenPx,
            bottom: tenPx,
            left: twentyPx,
            right: !showCheckbox ? thirtyFivePx : twentyPx,
          ),
          child: Row(
            children: [
              if (showCheckbox)
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) => onSelectItem
                        ?.call(), // Call onSelectItem when checkbox value changes,
                    visualDensity:
                        const VisualDensity(horizontal: -4.0, vertical: -4.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.5)),
                  ),
                ),
              gapW10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showCheckbox ? item.language : item.name,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    gapH5,
                    Text(
                      showCheckbox
                          ? item.name
                          : '${context.l10n.fileSize}: ${item.size} ${context.l10n.mb}',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: context.color.subtitleColor,
                      ),
                    )
                  ],
                ),
              ),
              if (!showCheckbox)
                DownloadButton(
                  theme: theme,
                  downloadProgress: downloadProgress,
                  isDownloading: isDownloading,
                  onTapDownloadButton: () => onSelectItem?.call(),
                ),
              if (showDelete && onDelete != null)
                InkWell(
                  onTap: onDelete,
                  child: SvgImage(
                    SvgPath.icDeleteOutline,
                    width: twentyPx,
                    height: twentyPx,
                    color: context.color.blackColor.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
