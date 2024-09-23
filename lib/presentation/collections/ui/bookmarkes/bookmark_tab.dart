import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_folder_display_widget.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_search_edit_box.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_sort_filter_selector.dart';
import 'package:quran_majeed/presentation/common/customizable_feedback_widget.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';

class BookmarkTab extends StatelessWidget {
  const BookmarkTab({
    super.key,
    required this.editingController,
    required this.presenter,
  });

  final CollectionPresenter presenter;
  final TextEditingController editingController;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        final CollectionUiState uiState = presenter.uiState.value;
        final List<BookmarkFolderEntity> filteredBookmarkFolders =
            uiState.filteredBookmarkFolders;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BookmarkSearchEditBox(
              themeData: theme,
              searchFieldController: editingController,
              onFilterClicked: () => CollectionSortFilterSelector.show(
                context,
                context.l10n.bookmark,
              ),
              focusNode: presenter.focusNode,
              onChanged: (query) => presenter.searchBookmarks(query: query),
            ),
            Expanded(
              child: uiState.isSyncing
                  ? LoadingIndicator(
                      theme: theme,
                      color: context.color.primaryColor,
                    )
                  : filteredBookmarkFolders.isEmpty &&
                          editingController.text.isNotEmpty
                      ? CustomizableFeedbackWidget(
                          theme: theme,
                          svgPath: SvgPath.icSearchBox,
                          message: 'Search Not Found',
                        )
                      : BookmarkFolderDisplayWidget(
                          presenter: presenter,
                          theme: theme,
                          bookmarkFolders: editingController.text.isEmpty
                              ? uiState.bookmarkFolders
                              : filteredBookmarkFolders,
                        ),
            ),
          ],
        );
      },
    );
  }
}
