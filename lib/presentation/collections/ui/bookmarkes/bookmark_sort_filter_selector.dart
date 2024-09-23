import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/sort_option_entity.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/sort_option_item.dart';

import 'package:quran_majeed/presentation/common/top_bar_with_dismiss.dart';

class CollectionSortFilterSelector extends StatelessWidget {
  CollectionSortFilterSelector({
    super.key,
    required this.title,
  });

  final String title;
  late final CollectionPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        final CollectionUiState uiState = _presenter.currentUiState;
        final List<SortOptionEntity> sortOptions = uiState.sortOptions;
        final SortOptionEntity? selectedSortOption = uiState.selectedSort;

        return Container(
          padding: padding20,
          decoration: BoxDecoration(
            color: themeData.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(twentyPx),
              topRight: Radius.circular(twentyPx),
            ),
          ),
          child: Wrap(
            children: [
              TopBarWithDismiss(
                title: "${context.l10n.sort} $title ${context.l10n.foldersBy}",
                theme: themeData,
              ),
              gapH35,
              Column(
                children: List.generate(
                  sortOptions.length,
                  (index) {
                    final SortOptionEntity sortOption = sortOptions[index];
                    return SortOptionItem(
                      sortOption: sortOption,
                      isSelected: sortOption == selectedSortOption,
                      onOptionSelected: _presenter.sortCollections,
                      theme: themeData,
                    );
                  },
                ),
              ),
              gapH10,
            ],
          ),
        );
      },
    );
  }

  static Future<void> show(
    BuildContext context,
    String title,
  ) async {
    final CollectionSortFilterSelector filterBottomSheet =
        await Future.microtask(
      () => CollectionSortFilterSelector(
        key: const Key("CollectionSortFilterSelector"),
        title: title,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(filterBottomSheet, context);
    }
  }
}
