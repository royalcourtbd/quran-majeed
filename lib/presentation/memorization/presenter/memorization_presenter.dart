import 'package:flutter/material.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/domain/use_cases/memorization/memorization_user_case.dart';
import 'package:quran_majeed/data/sealed_classes/surah_ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_ui_state.dart';
import 'package:quran_majeed/presentation/memorization/widgets/create_planner_bottom_sheet.dart';
import 'package:quran_majeed/presentation/memorization/widgets/more_memorization_option_bottom_sheet.dart';

import '../../ayah_detail/widgets/bottom_sheet/select_surah_ayah_bottom_sheet.dart';

class MemorizationPresenter extends BasePresenter<MemorizationUiState> {
  final Obs<MemorizationUiState> uiState = Obs(MemorizationUiState.empty());
  MemorizationUiState get currentUiState => uiState.value;
  Future<void> onClickCreatePlanner(BuildContext context) async {
    await CreatePlannerBottomSheet.show(
      context: context,
    );
  }

  @override
  void onInit() {
    super.onInit();
    getMemorization();
  }

  void toggleShowNotification() {
    final currentState = uiState.value;
    uiState.value = currentState.copyWith(
      showNotification: !currentState.showNotification,
    );
  }

  void toggleAudioPlayer() {
    final bool isPlaying = uiState.value.isPlaying;
    uiState.value = uiState.value.copyWith(isPlaying: !isPlaying);
  }

  getMemorization() async {
    final MemorizationUseCase saveMemorizationUserCase = MemorizationUseCase();
    final memo = await saveMemorizationUserCase.getList();

    final currentState = uiState.value;
    uiState.value = currentState.copyWith(memorizations: memo);
  }

  int getMemorizeCompletedPercentValue(double value) {
    var test = (value * 100).round();
    return test;
  }

  Future<void> onClickMemoraizationPageMoreButton({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
    required bool isDirectButtonVisible,
    required bool isAddMemorizationButtonVisible,
    required bool idAddCollectionButtonVisible,
  }) async {
    await MoreOptionBottomSheet.show(
      context: context,
      surahID: surahID,
      ayahID: ayahID,
      listOfWordByWordEntity: listOfWordByWordEntity,
      isDirectButtonVisible: true,
      isAddMemorizationButtonVisible: false,
      idAddCollectionButtonVisible: true,
      isPlayButtonVisible: true,
      isFromMemorization: true,
    );
  }

  Future<void> memorizationMoreOptionBottomSheet(
      BuildContext context, MemorizationEntity memorizationEntity) async {
    await MoreMemorizationOptionBottomSheet.show(
        context: context, memorizationEntity: memorizationEntity);
  }

  deleteMemorization(String id) async {
    final MemorizationUseCase memorization = MemorizationUseCase();
    final deletedMemorization = await memorization.delete(id);

    uiState.value = uiState.value.copyWith(
      memorizations: deletedMemorization,
    );
  }

  Future<void> onSelectSurahButtonClicked(
      BuildContext context, String bottomSheetTitle,
      {bool isStart = false}) async {
    final currentState = uiState.value;
    int? getSurahId;
    int? getAyahId;

    await SelectSurahAyahBottomSheet.show(
      context: context,
      bottomSheetTitle:
          '${context.l10n.select} $bottomSheetTitle ${context.l10n.surahAndAyah}',
      isDoneButtonEnabled: true,
      isJumpToAyahBottomSheet: false,
      presenter:
          SurahAyahPresenter.memorization(locate<MemorizationPresenter>()),
      onSurahSelected: (surahId) {
        getSurahId = surahId;
      },
      onAyahSelected: (ayahId) {
        getAyahId = ayahId;
      },
      onSubmit: () {
        if (isStart &&
            currentState.memorizationCreatingItem?.endSurah != null &&
            (getSurahId ?? 0) >
                (currentState.memorizationCreatingItem?.endSurah ?? 0)) {
          showMessage(message: "Start surah cannot be getter than end surah");
        } else if (!isStart &&
            currentState.memorizationCreatingItem?.startSurah != null &&
            (getSurahId ?? 0) <
                (currentState.memorizationCreatingItem?.startSurah ?? 0)) {
          showMessage(message: "End surah cannot be getter than start surah");
        } else {
          context.navigatorPop();

          if (isStart) {
            if ((currentState.memorizationCreatingItem?.startSurah == null ||
                    currentState.memorizationCreatingItem?.startSurah !=
                        null) &&
                currentState.memorizationCreatingItem?.endSurah != null &&
                (getSurahId ?? 0) >
                    (currentState.memorizationCreatingItem?.endSurah ?? 0)) {
              showMessage(
                  message: "Start surah cannot be getter than end surah");
            } else {
              uiState.value = currentState.copyWith(
                memorizationCreatingItem:
                    currentState.memorizationCreatingItem?.copyWith(
                  startAyah: getAyahId,
                  startSurah: getSurahId,
                ),
              );
            }
          } else {
            uiState.value = currentState.copyWith(
              memorizationCreatingItem:
                  currentState.memorizationCreatingItem?.copyWith(
                endAyah: getAyahId,
                endSurah: getSurahId,
              ),
            );
          }
        }
      },
    );
  }

  addMemorization() async {
    final MemorizationUseCase saveMemorizationUserCase = MemorizationUseCase();
    final getMermorization = await saveMemorizationUserCase.save(
      memorization: currentUiState.memorizationCreatingItem!,
    );
    uiState.value = currentUiState.copyWith(memorizations: getMermorization);
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
