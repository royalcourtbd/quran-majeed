import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

import 'package:quran_majeed/presentation/common/buttons/download_button.dart';

class WordByWordAvailableSingleItem extends StatelessWidget {
  final String name;
  final ValueChanged<String>? onDownload;
  final ThemeData theme;
  final bool isDownloading;
  final String? activeDownloadId;
  final int downloadProgress;
  final String size;

  const WordByWordAvailableSingleItem({
    super.key,
    required this.name,
    required this.theme,
    this.onDownload,
    required this.isDownloading,
    required this.size,
    this.activeDownloadId,
    required this.downloadProgress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentlyDownloading =
        isDownloading && activeDownloadId == name;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        splashColor: theme.cardColor.withOpacity(0.7),
        onTap: () => onDownload?.call(name),
        contentPadding: EdgeInsets.symmetric(horizontal: twentyPx),
        title: Text(
          name,
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: threePx),
          child: Text(
            '${context.l10n.fileSize}: $size ${context.l10n.mb}',
            style: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.color.subtitleColor,
            ),
          ),
        ),
        trailing: DownloadButton(
          theme: theme,
          downloadProgress: downloadProgress,
          isDownloading: isCurrentlyDownloading,
          onTapDownloadButton: () => onDownload?.call(name),
        ),
      ),
    );
  }
}
