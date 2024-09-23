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
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class BookmarkFolderListItem extends StatelessWidget {
  const BookmarkFolderListItem({
    super.key,
    required this.onMoreOptionClicked,
    required this.bookmarkFolder,
    required this.presenter,
    required this.theme,
  });

  final BookmarkFolderEntity bookmarkFolder;
  final CollectionPresenter presenter;
  final void Function(BookmarkFolderEntity) onMoreOptionClicked;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => presenter.onBookmarkFolderClicked(
          context: context,
          folder: bookmarkFolder,
          editingController: TextEditingController(),
        ),
        child: Container(
          key: Key("bookmark_folder_${bookmarkFolder.name}"),
          padding:
              EdgeInsets.symmetric(vertical: twelvePx, horizontal: twentyPx),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: padding12,
                decoration: BoxDecoration(
                  color: bookmarkFolder.color.withOpacity(0.1),
                  borderRadius: radius10,
                ),
                child: SvgImage(
                  SvgPath.icFolder,
                  color: bookmarkFolder.color,
                  width: twentyFourPx,
                  height: twentyFourPx,
                ),
              ),
              gapW15,
              Flexible(
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
                        ),
                      ),
                    ),
                    gapH4,
                    Text(
                      bookmarkFolder.count.isEqual(0)
                          ? context.l10n.noBookmarkAdded
                          : "${bookmarkFolder.count} ${context.l10n.bookmarked}",
                      style: context.quranText.lableExtraSmall!.copyWith(
                        color: context.color.subtitleColor,
                        fontWeight: FontWeight.w400,
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
                    alignment: Alignment.centerRight,
                    padding: padding10,
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
        ),
      ),
    );
  }
}
