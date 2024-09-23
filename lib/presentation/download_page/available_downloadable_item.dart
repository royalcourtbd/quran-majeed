import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/download_page/build_language_section.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';

class AvailableDownloadableItem extends StatelessWidget {
  const AvailableDownloadableItem({
    super.key,
    required this.title,
    required this.totalItems,
    required this.initiateDownloadFunc,
    required this.theme,
    required this.totalAvailableToDownloadItemsCount,
    required this.totalSizes,
    required this.downloadProgress,
    required this.isAllFilesDownloading,
  });

  final List<MapEntry<String, List<TTDbFileModel>>> totalItems;
  final String title;
  final Function(String, TTDbFileModel?) initiateDownloadFunc;
  final ThemeData theme;
  final int totalAvailableToDownloadItemsCount;
  final List<double> totalSizes;
  final int downloadProgress;
  final bool isAllFilesDownloading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: twentyPx),
            child: SectionHeader(
              title: ' $title ($totalAvailableToDownloadItemsCount)',
              theme: theme,
            )),
        gapH15,
        ListView.builder(
          itemCount: totalItems.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (totalItems[index].value.isEmpty) {
              return const SizedBox.shrink();
            }
            return BuildLanguageSection(
              item: totalItems[index],
              initiateDownload: initiateDownloadFunc,
              theme: theme,
              totalSizes: totalSizes,
              position: index,
              downloadProgress: downloadProgress,
              isAllFilesDownloading: isAllFilesDownloading,
            );
          },
        ),
      ],
    );
  }
}
