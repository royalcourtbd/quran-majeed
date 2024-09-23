import 'package:flutter/material.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_ui_state.dart';

import '../../../domain/entities/last_read_entity.dart';
import '../../../domain/use_cases/user_data/delete_last_reads.dart';
import '../../../domain/use_cases/user_data/get_last_read.dart';

class LastReadPresenter extends BasePresenter<LastReadUiState> {
  LastReadPresenter(
    this._getLastReads,
    this._deleteLastReadUseCase,
  );
  final Obs<LastReadUiState> uiState = Obs(LastReadUiState.empty());

  final GetLastReadsUseCase _getLastReads;
  final DeleteLastReadUseCase _deleteLastReadUseCase;

  LastReadUiState get currentUiState => uiState.value;

  @override
  void onClose() {
    unloadPresenterManually<LastReadPresenter>();
    super.onClose();
  }

  void toggleSelectAllLastReadItems() {
    final Set<int> allIndexes = {};
    for (int i = 0; i < currentUiState.lastReadList.length; i++) {
      allIndexes.add(i);
    }

    // Check if all items are already selected
    if (currentUiState.isSelected.length ==
        currentUiState.lastReadList.length) {
      // Deselect all items
      uiState.value = currentUiState.copyWith(isSelected: {});
    } else {
      // Select all items
      uiState.value = currentUiState.copyWith(isSelected: allIndexes);
    }
  }

  void toggleSelectionVisibility() {
    if (uiState.value.lastReadList.isNotEmpty) {
      final bool newState = !currentUiState.checkBox;
      uiState.value = currentUiState.copyWith(
        checkBox: newState,
        isSelected: newState ? currentUiState.isSelected : {},
      );
    }
  }

  void selectLastReadItem(int index) {
    final isSelectedSet = Set<int>.from(currentUiState.isSelected);
    if (isSelectedSet.contains(index)) {
      isSelectedSet.remove(index);
    } else {
      isSelectedSet.add(index);
    }
    uiState.value = currentUiState.copyWith(isSelected: isSelectedSet);
  }

  Future<void> getLastReadList() async {
    final List<LastReadEntity> result = await _getLastReads.execute();
    uiState.value = uiState.value.copyWith(
      lastReadList: result,
    );
  }

  Future<void> navigateToSurah(
      {required BuildContext context,
      required int surahIndex,
      required int ayahIndex}) async {
    late final AyahPresenter ayahPresenter = locate();
    await ayahPresenter.goToAyahPageWithSurahAndAyahID(
        context: context, surahID: surahIndex + 1, ayahID: ayahIndex);
    await Future<void>.delayed(1.inSeconds);
    await getLastReadList();
  }

  Future<void> deleteSelectedLastReads(BuildContext context) async {
    await RemoveDialog.show(
      onRemove: () async {
        final List<int> selectedItem =
            Set<int>.from(currentUiState.isSelected).toList();
        final List<LastReadEntity> result =
            await _deleteLastReadUseCase.execute(deletedItem: selectedItem);

        uiState.value = uiState.value.copyWith(
          isSelected: {},
          lastReadList: result,
          checkBox: result.isNotEmpty,
        );
        if (context.mounted && result.isEmpty) {
          context.navigatorPop();
        }
      },
      context: context,
      title: context.l10n.lastRead,
    );
  }

  String formatSurahNumber(int surahNumber) {
    return surahNumber < 10 ? '0$surahNumber' : surahNumber.toString();
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
