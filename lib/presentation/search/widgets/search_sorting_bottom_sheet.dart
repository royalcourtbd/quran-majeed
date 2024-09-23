import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/custom_radio_button.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/search/presenter/search_presenter.dart';

class SearchSortingBottomSheet extends StatelessWidget {
  SearchSortingBottomSheet({
    super.key,
  });

  static Future<void> show({
    required BuildContext context,
  }) async {
    final SearchSortingBottomSheet sortingBottomSheet = await Future.microtask(
      () => SearchSortingBottomSheet(
        key: const Key("SortingBottomSheet"),
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(sortingBottomSheet, context);
    }
  }

  final SearchPresenter searchPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //TODO : Use PresentableWidgetBuilder for UI testing, remove it when functionality is implemented
    return PresentableWidgetBuilder(
      presenter: searchPresenter,
      builder: () {
        return CustomBottomSheetContainer(
          showPadding: false,
          theme: theme,
          bottomSheetTitle: 'Sorting history',
          children: [
            CustomRadioButton(
              title: 'By Date',
              value: 'date',
              groupValue:
                  searchPresenter.currentUiState.searchHistoryGroupValue,
              onChanged: (String? value) {
                searchPresenter.updateSearchHistoryGroupValue(value!);
              },
              theme: theme,
            ),
            gapH10,
            CustomRadioButton(
              title: 'By Group (Everything)',
              value: 'group',
              groupValue:
                  searchPresenter.currentUiState.searchHistoryGroupValue,
              onChanged: (String? value) {
                searchPresenter.updateSearchHistoryGroupValue(value!);
              },
              theme: theme,
            ),
            gapH10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Single Group :',
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            gapH10,
            CustomRadioButton(
              title: 'Translation',
              value: 'translation',
              groupValue:
                  searchPresenter.currentUiState.searchHistoryGroupValue,
              onChanged: (String? value) {
                searchPresenter.updateSearchHistoryGroupValue(value!);
              },
              theme: theme,
            ),
            gapH10,
            CustomRadioButton(
              title: 'Tafseer',
              value: 'tafseer',
              groupValue:
                  searchPresenter.currentUiState.searchHistoryGroupValue,
              onChanged: (String? value) {
                searchPresenter.updateSearchHistoryGroupValue(value!);
              },
              theme: theme,
            ),
            gapH10,
            CustomRadioButton(
              title: 'Arabic',
              value: 'arabic',
              groupValue:
                  searchPresenter.currentUiState.searchHistoryGroupValue,
              onChanged: (String? value) {
                searchPresenter.updateSearchHistoryGroupValue(value!);
              },
              theme: theme,
            ),
            gapH15
          ],
        );
      },
    );
  }
}
