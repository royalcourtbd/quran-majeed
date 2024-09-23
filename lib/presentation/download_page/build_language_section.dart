import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/tt_json_mapper.dart';
import 'package:quran_majeed/presentation/download_page/download_item_widget.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';

class BuildLanguageSection extends StatelessWidget {
  const BuildLanguageSection({
    super.key,
    required this.item,
    required this.initiateDownload,
    required this.theme,
    required this.totalSizes,
    required this.position,
    required this.downloadProgress,
    required this.isAllFilesDownloading,
  });
  final MapEntry<String, List<TTDbFileModel>> item;
  final Function(String, TTDbFileModel?) initiateDownload;
  final ThemeData theme;
  final List<double> totalSizes;
  final int position;
  final int downloadProgress;
  final bool isAllFilesDownloading;

  @override
  Widget build(BuildContext context) {
    final presenter =
        context.findAncestorWidgetOfExactType<DownloadPage>()?.presenter;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: fifteenPx,
              vertical: tenPx,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.05),
              borderRadius: radius5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.key,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.color.primaryColor,
                      ),
                    ),
                    gapH5,
                    Text(
                      '${context.l10n.totalDownloadSize}: ${totalSizes[position]} ${context.l10n.mb}',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: context.color.subtitleColor,
                      ),
                    ),
                  ],
                ),

                ///TODO: When the functionality for the 'All Download' button is implemented, this widget will need to be uncommented.
                // DownloadButton(
                //   theme: theme,
                //   downloadProgress: downloadProgress,
                //   isDownloading: isAllFilesDownloading,
                //   isAllFilesDownloading: isAllFilesDownloading,
                //   onTapDownloadButton: () async => await presenter.showComingSoonMessage(context: context);,
                //   // initiateDownload.call(item.key, null),
                // ),
              ],
            ),
          ),
        ),
        gapH10,
        ListView.builder(
          itemBuilder: (context, index) {
            return DownloadItemWidget(
              item: item.value[index],
              theme: theme,
              onSelectItem: () => initiateDownload(item.key, item.value[index]),
              downloadProgress: downloadProgress,
            );
          },
          itemCount: item.value.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
        ),
        gapH10,
      ],
    );
  }
}
