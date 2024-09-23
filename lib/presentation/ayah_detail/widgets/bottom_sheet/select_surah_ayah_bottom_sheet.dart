import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/sealed_classes/surah_ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/build_ayah_list_column.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/surah_list_widget.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';

class SelectSurahAyahBottomSheet extends StatelessWidget {
  const SelectSurahAyahBottomSheet({
    super.key,
    required this.presenter,
    required this.isDoneButtonEnabled,
    required this.isJumpToAyahBottomSheet,
    required this.bottomSheetTitle,
    this.onSurahSelected,
    this.onAyahSelected,
    this.onSubmit,
    this.onJumpToTafseer,
  });
  final bool isDoneButtonEnabled;
  final bool isJumpToAyahBottomSheet;
  final String bottomSheetTitle;
  final Function(int surahId)? onSurahSelected;
  final Function(int ayahId)? onAyahSelected;
  final Function()? onSubmit;
  final Function()? onJumpToTafseer;
  final SurahAyahPresenter presenter;

  static Future<void> show({
    required BuildContext context,
    required bool isDoneButtonEnabled,
    required bool isJumpToAyahBottomSheet,
    required String bottomSheetTitle,
    required SurahAyahPresenter presenter,
    Function(int surahId)? onSurahSelected,
    Function(int ayahId)? onAyahSelected,
    Function()? onSubmit,
    Function()? onJumpToTafseer,
  }) async {
    final SelectSurahAyahBottomSheet jumpToAyahBottomSheet =
        await Future.microtask(
      () => SelectSurahAyahBottomSheet(
        isDoneButtonEnabled: isDoneButtonEnabled,
        isJumpToAyahBottomSheet: isJumpToAyahBottomSheet,
        presenter: presenter,
        bottomSheetTitle: bottomSheetTitle,
        key: const Key("JumpToAyahBottomSheet"),
        onSurahSelected: onSurahSelected,
        onAyahSelected: onAyahSelected,
        onSubmit: onSubmit,
        onJumpToTafseer: onJumpToTafseer,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(jumpToAyahBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: _getPresenter(),
        builder: () {
          final uiState = _getUiState();
          final int selectedSurahIndex = uiState.selectedSurahIndex;
          final int ayahNumbers = uiState.ayahNumbers;
          final int selectedAyahIndex = uiState.selectedAyahIndex;
          return ExpandableBottomSheet(
            key: const Key("ExpandableBottomSheet"),
            background: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100.percentHeight,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            enableToggle: true,
            persistentContentHeight: 98.percentHeight,
            expandableContent: Container(
              key: const Key("ExpandableContent"),
              height: 98.percentHeight,
              width: QuranScreen.width,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(twentyPx),
                  topRight: Radius.circular(twentyPx),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: twentyPx,
                vertical: tenPx,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  gapH2,
                  Text(
                    bottomSheetTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.color.primaryColor,
                    ),
                  ),
                  gapH22,
                  Expanded(
                    child: Row(
                      children: [
                        SurahListColumn(
                          key: const Key("SurahListColumn"),
                          onSurahSelected: onSurahSelected,
                          theme: theme,
                          selectedSurahIndex: selectedSurahIndex,
                        ),
                        gapW10,
                        BuildAyahListColumn(
                          key: const Key("AyahListColumn"),
                          theme: theme,
                          ayahNumbers: ayahNumbers,
                          selectedAyahIndex: selectedAyahIndex,
                          onAyahSelected: onAyahSelected,
                        ),
                      ],
                    ),
                  ),
                  gapH20,
                  if (isJumpToAyahBottomSheet) ...[
                    TwoWayActionButton(
                      key: const Key("TwoWayActionButton"),
                      submitButtonTitle: context.l10n.jumpToAyah,
                      cancelButtonTitle: context.l10n.jumpToTafseer,
                      onSubmitButtonTap: onSubmit,
                      onCancelButtonTap: onJumpToTafseer,
                      theme: theme,
                      submitButtonTextColor: context.color.whiteColor,
                    ),
                    gapH50,
                  ],
                  if (isDoneButtonEnabled) ...[
                    SubmitButton(
                      key: const Key("SubmitButton"),
                      theme: theme,
                      title: context.l10n.done,
                      onTap: onSubmit,
                      textColor: context.color.whiteColor,
                      buttonColor: context.color.primaryColor,
                    ),
                    gapH50,
                  ]
                ],
              ),
            ),
          );
        });
  }

  GetxController _getPresenter() {
    return switch (presenter) {
      AyahSurahAyahPresenter(:final presenter) => presenter,
      AudioSurahAyahPresenter(:final presenter) => presenter,
      MemorizationSurahAyahPresenter(:final presenter) => presenter,
    };
  }

  dynamic _getUiState() {
    return switch (presenter) {
      AyahSurahAyahPresenter(:final presenter) => presenter.currentUiState,
      AudioSurahAyahPresenter(:final presenter) => presenter.currentUiState,
      MemorizationSurahAyahPresenter(:final presenter) =>
        presenter.currentUiState,
    };
  }
}
