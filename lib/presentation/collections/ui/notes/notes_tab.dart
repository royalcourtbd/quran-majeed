import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_sort_filter_selector.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/note_display_widget.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/note_search_edit_box.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';

class NoteTab extends StatelessWidget {
  NoteTab({super.key, required this.editingController});

  late final CollectionPresenter _presenter = locate();
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        final CollectionUiState uiState = _presenter.uiState.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NoteSearchEditBox(
              searchFieldController: editingController,
              onFilterClicked: () => {
                CollectionSortFilterSelector.show(context, context.l10n.note)
              },
              theme: theme,
            ),
            Expanded(
              child: uiState.isSyncing
                  ? LoadingIndicator(
                      theme: theme,
                      color: context.color.primaryColor,
                    )
                  : NoteDisplayWidget(
                      theme: theme,
                    ),
            ),
          ],
        );
      },
    );
  }
}
