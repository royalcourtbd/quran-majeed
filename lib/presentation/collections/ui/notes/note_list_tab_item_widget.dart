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

class NoteListTabItem extends StatelessWidget {
  const NoteListTabItem({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => context.navigatorPush(NoteDetailsPage()),
        child: Container(
          padding: EdgeInsets.only(
            left: fourPx,
            right: fourPx,
            top: fourPx,
            bottom: fourPx,
          ),
          decoration: BoxDecoration(
              borderRadius: radius8,
              border: Border.all(
                color: theme.cardColor.withOpacity(0.9),
              )),
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
                      color: theme.cardColor,
                      borderRadius: radius5,
                    ),
                    child: SvgImage(
                      height: twentyPx,
                      SvgPath.icPin,
                      color: context.color.primaryColor,
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
                            "Surah Name",
                            overflow: TextOverflow.clip,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: eightPx,
                            ),
                          ),
                        ),
                        // gapH3,
                        Text(
                          "3 Notes",
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: context.color.subtitleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: sixPx),
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
                      alignment: Alignment.topRight,
                      // padding: padding10,
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
            ],
          ),
        ),
      ),
    );
  }
}
