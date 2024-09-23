import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_downloaded_single_item.dart';

class WordByWordDownloadedItems extends StatelessWidget {
  final String title;
  final String? selectedLanguage;
  final List<String>? downloadedLanguages;
  final void Function({required String name})? onLanguageSelected;
  final void Function({required String name})? onLanguageDelete;
  final ThemeData theme;
  const WordByWordDownloadedItems({
    super.key,
    required this.title,
    required this.theme,
    this.selectedLanguage,
    this.downloadedLanguages,
    this.onLanguageSelected,
    this.onLanguageDelete,
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
            title: '$title (${downloadedLanguages!.length})',
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: downloadedLanguages!.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final String name = downloadedLanguages![index];

            return WordByWordDownloadedSingleItem(
              name: name,
              isSelected: name == selectedLanguage,
              onSelect: (String name) => onLanguageSelected?.call(name: name),
              onDelete: (String name) => onLanguageDelete?.call(name: name),
              theme: theme,
            );
          },
        ),
      ],
    );
  }
}
