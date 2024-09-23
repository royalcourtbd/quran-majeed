import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/more_menu_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_sort_filter_selector.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/pin_display_widget.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/pin_search_edit_box.dart';
import 'package:quran_majeed/presentation/common/loading_indicator.dart';

class PinTab extends StatelessWidget {
  PinTab({
    super.key,
    required this.editingController,
  });

  final TextEditingController editingController;
  late final MoreMenuPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      // onInit: _presenter.getAllPins,
      builder: () {
        final MoreMenuUiState uiState = _presenter.uiState.value;
        if (uiState.isLoading) {
          return LoadingIndicator(
            theme: theme,
            color: context.color.primaryColor,
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PinSearchEditBox(
              editingController: editingController,
              onFilterClicked: () => {
                CollectionSortFilterSelector.show(context, context.l10n.pin),
              },
              theme: theme,
            ),
            Expanded(
                child: uiState.isLoading
                    ? LoadingIndicator(
                        theme: theme,
                        color: context.color.primaryColor,
                      )
                    : PinDisplayWidget(
                        moreMenuPresenter: _presenter,
                        theme: theme,
                      )),
            const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
