import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/search/presenter/search_ui_state.dart';
import 'package:quran_majeed/presentation/search/ui/search_top_bar_content.dart';
import 'package:quran_majeed/presentation/search/widgets/search_sorting_bottom_sheet.dart';

class SearchPresenter extends BasePresenter<SearchUiState> {
  final Obs<SearchUiState> uiState = Obs(SearchUiState.empty());

  SearchUiState get currentUiState => uiState.value;

  void updateSearchInGroupValue(int newValue) {
    uiState.value = currentUiState.copyWith(searchGroupValue: newValue);
  }

  void updateSearchHistoryGroupValue(String newValue) {
    uiState.value = currentUiState.copyWith(searchHistoryGroupValue: newValue);
  }

  Future<Object?> topSearchBar(
    BuildContext context,
    SearchPresenter presenter,
  ) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => context.navigatorPop(),
          child: SearchTopBarContent(
            searchPresenter: presenter,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Future<void> onClickSearchFilter(BuildContext context) async {
    await SearchSortingBottomSheet.show(
      context: context,
    );
  }

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
