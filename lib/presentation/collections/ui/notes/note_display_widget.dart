import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/note_list_item.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/note_list_tab_item_widget.dart';

class NoteDisplayWidget extends StatelessWidget {
  const NoteDisplayWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? ListView.builder(
            key: const Key('NoteDisplayWidget'),
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 15,
            itemBuilder: (_, index) {
              return NoteListItem(
                theme: theme,
              );
            },
          )
        : GridView.builder(
            key: const Key('NoteDisplayWidget'),
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 35.5.px,
              crossAxisSpacing: fivePx,
              mainAxisSpacing: fivePx,
            ),
            padding: EdgeInsets.only(
              left: fourteenPx,
              right: fourteenPx,
              bottom: thirtyFivePx,
            ),
            itemCount: 15,
            itemBuilder: (_, index) => NoteListTabItem(
              key: ValueKey(index),
              theme: theme,
            ),
          );
  }
}
