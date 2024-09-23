import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class BookmarkFolderTabListItem extends StatelessWidget {
  const BookmarkFolderTabListItem({
    super.key,
    required this.onMoreOptionClicked,
    required this.bookmarkFolder,
    required this.theme,
  });

  final BookmarkFolderEntity bookmarkFolder;
  final void Function(BookmarkFolderEntity) onMoreOptionClicked;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      //use material to get splash effect
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => {},
        // context.navigatorPush(
        //   BookmarkDetailsPage(
        //     ayahList: bookmarkFolderList.ayahList,
        //   ),
        // ),
        child: Container(
          padding: EdgeInsets.all(fourPx),
          decoration: BoxDecoration(
            borderRadius: radius8,
            border: Border.all(
              color: theme.cardColor.withOpacity(0.9),
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: padding3,
                    decoration: BoxDecoration(
                      color: bookmarkFolder.color.withOpacity(0.1),
                      borderRadius: radius5,
                    ),
                    child: SvgImage(
                      height: twentyPx,
                      SvgPath.icFolder,
                      color: bookmarkFolder.color,
                    ),
                  ),
                  gapW5,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: sixtySixPercentWidth,
                          child: Text(
                            bookmarkFolder.name,
                            overflow: TextOverflow.clip,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: eightPx,
                            ),
                          ),
                        ),
                        // gapH3,
                        Text(
                          bookmarkFolder.count.isEqual(0)
                              ? "No Bookmark added"
                              : "${bookmarkFolder.count} Bookmarked",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: context.color.subtitleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: sixPx,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !bookmarkFolder.name.contains("Favourites"),
                    child: InkWell(
                      onTap: () => onMoreOptionClicked(bookmarkFolder),
                      child: Container(
                        alignment: Alignment.topRight,
                        // padding: padding10,
                        child: SvgPicture.asset(
                          SvgPath.icMoreVert,
                          colorFilter: buildColorFilterToChangeColor(
                            theme.textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
