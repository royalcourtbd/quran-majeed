import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/build_row_with_arrow_widget.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_ui_state.dart';
import 'package:quran_majeed/presentation/memorization/ui/show_previous_folder_list_page.dart';
import 'package:quran_majeed/presentation/memorization/widgets/choose_folder_widget.dart';
import 'package:quran_majeed/presentation/memorization/widgets/custom_text_form_field.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';
import 'package:quran_majeed/presentation/memorization/widgets/show_estimated_day_row.dart';
import 'package:quran_majeed/presentation/memorization/widgets/show_notification_time_row.dart';
import 'package:quran_majeed/presentation/settings/widgets/simple_switch.dart';

// ignore: must_be_immutable
class CreatePlannerBottomSheet extends StatelessWidget {
  CreatePlannerBottomSheet({super.key});

  static Future<void> show({
    required BuildContext context,
  }) async {
    final CreatePlannerBottomSheet createPlannerBottomSheet =
        await Future.microtask(
      () => CreatePlannerBottomSheet(
        key: const Key('CreatePlannerBottomSheetSheet'),
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet(createPlannerBottomSheet, context);
    }
  }

  final TextEditingController _folderNameEditingController =
      TextEditingController();
  final TextEditingController _dayEditingController = TextEditingController();
  final MemorizationPresenter _presenter = locate();
  String? prevFolderName;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        final MemorizationUiState uiState = _presenter.uiState.value;
        return CustomBottomSheetContainer(
          key: const Key('CreatePlannerBottomSheetSheet'),
          theme: theme,
          bottomSheetTitle: 'Memorization Planner',
          children: [
            HeaderTitle(title: 'Choose Previous Plan', theme: theme),
            gapH10,
            ChooseFolderWidget(
              ontap: () => context.navigatorPush<void>(
                ShowPreviousFolderListPage(
                  onSuggestionSelected: (v) {
                    prevFolderName = v;

                    _presenter.uiState.value =
                        _presenter.uiState.value.copyWith(
                      memorizationCreatingItem:
                          _presenter.currentUiState.memorizations.firstWhere(
                        (element) => element.planName == prevFolderName,
                      ),
                    );
                  },
                ),
              ),
              prevFolderName: prevFolderName,
              theme: theme,
            ),
            gapH22,
            HeaderTitle(title: 'Or, Set Plan Name', theme: theme),
            gapH10,
            SizedBox(
              height: fortyFivePx,
              child: CustomTextFormField(
                folderNameEditingController: _folderNameEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^[1-9][0-9]*$'),
                  ),
                  FilteringTextInputFormatter.deny(RegExp(r'^(0|\s).*')),
                ],
                hintText: 'Write a Name of Folder',
              ),
            ),
            gapH20,
            BuildRowWithArrowWidget(
              theme: theme,
              iconPath: SvgPath.icDocumentOutline,
              title: 'Start Surah',
              subtitle: uiState.memorizationCreatingItem?.startSurah == null
                  ? ""
                  : '${CacheData.surahsCache[(uiState.memorizationCreatingItem?.startSurah ?? 0) - 1].nameEn} ${uiState.memorizationCreatingItem?.startSurah}:${uiState.memorizationCreatingItem?.startAyah}',
              onClicked: () async {
                _presenter.onSelectSurahButtonClicked(
                  context,
                  "Start",
                  isStart: true,
                );
              },
              autopop: false,
            ),
            gapH5,
            BuildRowWithArrowWidget(
              theme: theme,
              iconPath: SvgPath.icDocumentOutline,
              title: 'End Surah',
              autopop: false,
              subtitle: uiState.memorizationCreatingItem?.endSurah == null
                  ? ""
                  : '${CacheData.surahsCache[(uiState.memorizationCreatingItem?.endSurah ?? 0) - 1].nameEn} ${uiState.memorizationCreatingItem?.endSurah}:${uiState.memorizationCreatingItem?.endAyah}',
              onClicked: () {
                _presenter.onSelectSurahButtonClicked(
                  context,
                  "End",
                );
              },
            ),
            gapH5,
            ShowEstimatedDayRow(
              dayEditingController: _dayEditingController,
            ),
            gapH5,
            Row(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MenuListItem(
                    theme: theme,
                    iconPath: SvgPath.icNotificationOutline,
                    title: 'Notification',
                    onClicked: () async {
                      // await _onClickEdit(context);
                    },
                  ),
                ),

                //QuranAppSwitchButton er poriborte SimpleSwitch use korte hobe
                SimpleSwitch(
                  initialValue: uiState.showNotification,
                  onChanged: (value) {
                    _presenter.toggleShowNotification();
                  },
                )
              ],
            ),
            gapH5,
            ShowNotificationTimeRow(
              theme: theme,
              presenter: _presenter,
            ),
            gapH20,
            TwoWayActionButton(
              theme: theme,
              submitButtonTitle: 'Create',
              cancelButtonTitle: 'Cancel',
              onSubmitButtonTap: () {
                final currentState = _presenter.uiState.value;

                _presenter.uiState.value = currentState.copyWith(
                  memorizationCreatingItem: _presenter
                      .currentUiState.memorizationCreatingItem
                      ?.copyWith(
                    estimatedDay: int.tryParse(_dayEditingController.text),
                    planName:
                        prevFolderName ?? _folderNameEditingController.text,
                  ),
                );
                if (currentState.memorizationCreatingItem?.startAyah == null) {
                  showMessage(message: "Add start ayah");
                } else if (currentState.memorizationCreatingItem?.startSurah ==
                    null) {
                  showMessage(message: "Add start surah");
                } else if (currentState.memorizationCreatingItem?.endAyah ==
                    null) {
                  showMessage(message: "Add end ayah");
                } else if (currentState.memorizationCreatingItem?.endSurah ==
                    null) {
                  showMessage(message: "Add end surah");
                } else if (_presenter.uiState.value.memorizationCreatingItem ==
                    null) {
                  showMessage(message: "Add estimated day");
                } else if (currentState.memorizationCreatingItem?.planName ==
                        null &&
                    prevFolderName == null) {
                  showMessage(message: "Add plan name");
                } else {
                  context.navigatorPop<void>();

                  _presenter.addMemorization();
                }
              },
              onCancelButtonTap: () => context.navigatorPop<void>(),
            ),
          ],
        );
      },
    );
  }
}
