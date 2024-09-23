import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/musaf_data_model.dart';

class MusafOptionListItem extends StatelessWidget {
  const MusafOptionListItem({
    super.key,
    required this.musafDataModel,
    required this.index,
  });
  final MusafDataModel musafDataModel;
  final int index;
  final int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: twentyPx),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio(
              value: index,
              groupValue: groupValue,
              fillColor: index == groupValue
                  ? WidgetStateProperty.all(context.color.primaryColor)
                  : WidgetStateProperty.all(
                      context.color.primaryColor.withOpacity(0.38)),
              onChanged: (value) {},
            ),
          ),
          gapW8,
          Container(
            width: 15.percentWidth,
            height: 18.percentWidth,
            decoration: BoxDecoration(
              color: context.color.primaryColor.withOpacity(0.05),
              border: Border.all(
                color: context.color.primaryColor.withOpacity(0.05),
                width: twoPx,
              ),
              borderRadius: radius10,
            ),
            child: ClipRRect(
              borderRadius: radius10,
              child: Image.asset(
                SvgPath.imgMushaf,
                fit: BoxFit.fill,
              ),
            ),
          ),
          gapW10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  musafDataModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: fourteenPx,
                  ),
                ),
                if (musafDataModel.isDownloaded) ...[
                  gapH5,
                  Text(
                    'File Size: 4.5MB',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: thirteenPx,
                      color: context.color.primaryColor.withOpacity(0.6),
                    ),
                  ),
                ]
              ],
            ),
          ),
          // if (musafDataModel.isDownloaded)
          // DownloadCircularButton(
          //   index: index,
          //   isDownloading: false,
          //   downloadProgress: 50,
          //   currentDownloadingSurahIndex: 0,
          //   onTap: () {},
          //   theme: theme,
          // ),
        ],
      ),
    );
  }
}
