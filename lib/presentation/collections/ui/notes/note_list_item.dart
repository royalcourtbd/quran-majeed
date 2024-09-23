import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/bookmark_details/ui/note_details_page.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/more_note_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const Key('NoteListItem'),
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => context.navigatorPush(NoteDetailsPage()),
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: twelvePx, horizontal: twentyPx),
          // margin: EdgeInsets.only(bottom: twelvePx),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                key: const Key('NoteListItemContainer'),
                padding: padding12,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: radius10,
                ),
                child: SvgImage(
                  SvgPath.icDocument,
                  width: twentyFourPx,
                  height: twentyFourPx,
                  color: context.color.primaryColor,
                ),
              ),
              gapW15,
              Flexible(
                key: const Key('NoteListItemFlexible'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sixtySixPercentWidth,
                      child: Text(
                        "Surah Name",
                        overflow: TextOverflow.clip,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    gapH4,
                    Text(
                      '3 Notes',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => MoreNoteOptionBottomSheet.show(
                  theme: theme,
                  context: context,
                ),
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: padding5,
                  child: SvgPicture.asset(
                    SvgPath.icMoreVert,
                    colorFilter: buildColorFilterToChangeColor(
                      context.color.blackColor,
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
