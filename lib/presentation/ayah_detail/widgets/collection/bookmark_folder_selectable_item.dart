import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';

class BookmarkFolderSelectableItem extends StatelessWidget {
  const BookmarkFolderSelectableItem({
    super.key,
    required this.isSelected,
    required this.folder,
    required this.theme,
    required this.collectionPresenter,
  });

  final bool isSelected;
  final dynamic folder;
  final CollectionPresenter collectionPresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: CheckboxListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isSelected,
        onChanged: (value) => collectionPresenter
            .toggleBookmarkFolderToSelectedByName(folder.name),
        title: Row(
          children: [
            SvgPicture.asset(
              SvgPath.icFolder,
              height: thirtyFivePx,
              colorFilter: buildColorFilter(folder.color),
            ),
            gapW20,
            SizedBox(
              width: sixtySixPercentWidth,
              child: Text(
                folder.name,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
