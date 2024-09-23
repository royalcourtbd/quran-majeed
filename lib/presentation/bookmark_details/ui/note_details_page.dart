import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/note_ayah_search_edit_box.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/notes_ayah_list_item.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/common/show_no_more_text_widget.dart';

class NoteDetailsPage extends StatelessWidget {
  NoteDetailsPage({super.key});

  final CollectionPresenter _presenter = locate();
  final TextEditingController editingController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(
        title: 'Notes',
        theme: theme,
        actions: [
          AppbarActionIcon(
            svgPath: SvgPath.icEdit,
            theme: theme,
            width: twentyTwoPx,
            height: twentyTwoPx,
          ),
          gapW8,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              isColored: true,
              child: Column(
                children: [
                  NoteAyahSearchEditBox(
                    searchFieldController: editingController,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            NoteAyahListItem(
                              presenter: _presenter,
                              theme: theme,
                              index: index,
                            ),
                            if (index == 4)
                              ShowNoMoreTextWidget(
                                  title: 'Notes', theme: theme),
                          ],
                        );
                      },
                    ),
                  ),
                  gapH15,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
