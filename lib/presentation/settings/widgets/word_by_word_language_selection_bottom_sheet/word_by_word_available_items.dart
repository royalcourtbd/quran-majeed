import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_available_single_item.dart';

class WordByWordAvailableItems extends StatelessWidget {
  final String title;
  final List<WbwDbFileModel> items;
  final String? selectedLanguage;
  final void Function({required String name})? onLanguageDownload;
  final void Function({required String name})? onLanguageDelete;
  final ThemeData theme;
  final bool? isDownloading;
  final String? activeDownloadId;
  final int? downloadProgress;

  const WordByWordAvailableItems({
    super.key,
    required this.title,
    required this.items,
    required this.theme,
    this.selectedLanguage,
    this.onLanguageDownload,
    this.onLanguageDelete,
    this.isDownloading,
    this.activeDownloadId,
    this.downloadProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sixteenPx),
          child: SectionHeader(
            theme: theme,
            title: '$title (${items.length})',
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final WbwDbFileModel file = items[index];
            final String name = file.name;
            final String size = file.size;

            return WordByWordAvailableSingleItem(
              name: name,
              onDownload: (String name) => onLanguageDownload?.call(name: name),
              theme: theme,
              isDownloading: isDownloading!,
              size: size,
              activeDownloadId: activeDownloadId,
              downloadProgress: downloadProgress!,
            );
          },
        ),
      ],
    );
  }
}
