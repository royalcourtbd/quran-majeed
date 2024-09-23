import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/zooms.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class BookmarkAyahSimpleListItem extends StatelessWidget {
  const BookmarkAyahSimpleListItem({
    super.key,
    required this.collectionPresenter,
    required this.index,
    required this.bookmarks,
    required this.theme,
    this.onRemove,
  });

  final CollectionPresenter collectionPresenter;
  final BookmarkEntity bookmarks;
  final int index;
  final ThemeData theme;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: collectionPresenter,
      builder: () {
        return ZoomIn(
          child: Material(
            color: Colors.transparent,
            child: OnTapWidget(
              theme: theme,
              onTap: () {
                //TODO: Implement All Delete functionality in v2.0.0 release inshaAllah
                // if (collectionPresenter.uiState.value.checkBox) {
                //   collectionPresenter.selectBookmarkItem(index);
                // } else {
                //   // Add your navigation or other logic here
                // }
                collectionPresenter.goToAyahPageWithSurahAndAyahID(
                  context: context,
                  surahID: bookmarks.surahID,
                  ayahID: bookmarks.ayahID,
                );
              },
              //TODO: Implement All Delete functionality in v2.0.0 release inshaAllah
              // onLongPress: () => collectionPresenter.toggleSelectionVisibility(),
              child: Container(
                padding: EdgeInsets.only(
                    left: twentyPx, top: twelvePx, bottom: twelvePx),
                child: Row(
                  children: [
                    Visibility(
                      visible: collectionPresenter.uiState.value.checkBox,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onChanged: (value) =>
                              collectionPresenter.selectBookmarkItem(index),
                          value: collectionPresenter.uiState.value.isSelected
                              .contains(index),
                        ),
                      ),
                    ),
                    collectionPresenter.uiState.value.checkBox
                        ? gapW12
                        : const SizedBox.shrink(),
                    Container(
                      padding: padding10,
                      decoration: BoxDecoration(
                        color: QuranColor.darkOrange.withOpacity(.1),
                        borderRadius: radius10,
                      ),
                      child: SizedBox(
                        height: twentyPx,
                        width: twentyPx,
                        child: SvgPicture.asset(
                          SvgPath.icBookmarkFill,
                        ),
                      ),
                    ),
                    gapW15,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CacheData.surahsCache[bookmarks.surahID - 1].nameEn,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapH3,
                          Text(
                            'Ayah ${bookmarks.ayahID}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: context.color.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (onRemove != null)
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: theme.colorScheme.error.withOpacity(.7)),
                        onPressed: onRemove,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
