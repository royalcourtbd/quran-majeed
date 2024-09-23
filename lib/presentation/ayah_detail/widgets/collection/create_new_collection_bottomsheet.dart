import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/collection_type_selector_item.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/common/selectable_color_list.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class CreateNewCollectionBottomSheet extends StatelessWidget {
  const CreateNewCollectionBottomSheet({
    super.key,
    required this.surahID,
    required this.ayahID,
    required this.presenter,
  });

  final int surahID;
  final int ayahID;
  final CollectionPresenter presenter;

  static Future<void> show({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required CollectionPresenter presenter,
  }) async {
    final CreateNewCollectionBottomSheet createNewCollection =
        await Future.microtask(
      () => CreateNewCollectionBottomSheet(
        key: const Key("CreateNewCollectionBottomSheet"),
        surahID: surahID,
        ayahID: ayahID,
        presenter: presenter,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(createNewCollection, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        final CollectionUiState uiState = presenter.uiState.value;

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(twentyPx),
                topRight: Radius.circular(twentyPx),
              ),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: fifteenPx, vertical: tenPx),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH10,
                  Text(
                    context.l10n.createNew,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.color.primaryColor,
                    ),
                  ),
                  gapH15,
                  HeaderTitle(
                    title: '${context.l10n.collection} ${context.l10n.name}',
                    theme: theme,
                  ),
                  gapH10,
                  Container(
                    height: fortyFivePx,
                    alignment: Alignment.center,
                    child: UserInputField(
                      textEditingController:
                          presenter.folderNameEditingController,
                      hintText: '${context.l10n.example} ${context.l10n.name}',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                        FilteringTextInputFormatter.deny(
                            RegExp(r'^\s')), // Prevent spaces at the start
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^[a-zA-Z0-9].*')), // Allow alphanumeric at start
                      ],
                      prefixIconPath: SvgPath.icFolder,
                      borderRadius: radius10,
                      prefixIconColor: uiState.selectedColor,
                      isError: uiState.isInputError,
                      errorBorderColor: Colors.red,
                      onChanged: (value) => presenter.validateInput(value),
                    ),
                  ),
                  gapH22,
                  HeaderTitle(
                      title:
                          '${context.l10n.folderColor} ${context.l10n.select}',
                      theme: theme),
                  gapH10,
                  SelectableColorList(
                    presenter: presenter,
                  ),
                  gapH20,
                  HeaderTitle(
                      title: context.l10n.chooseFolderType, theme: theme),
                  gapH15,
                  CollectionTypeSelectorItem(
                    key: const Key("CollectionTypeSelectorItem"),
                    theme: theme,
                    title: context.l10n.bookmark,
                    subtitle: context.l10n.collectionContainsMultipleBookmarks,
                    isSelected: true,
                    //TODO: Implement the following line after implementing the pin collection
                    // uiState.selectedCollectionType == CollectionType.bookmark,
                    value: const [1],
                    groupValue: const [1],
                    onTap: () => {},
                    //TODO: Implement the following line after implementing the pin collection
                    // _presenter.selectCollectionType,
                    selectedColor: uiState.selectedColor,
                  ),
                  // gapH15,
                  //TODO: Implement the following line after implementing the pin collection
                  // CollectionTypeSelectorItem(
                  //   // key: const ValueKey(CollectionType.pin),
                  //   theme: theme,
                  //   title: "Pin",
                  //   subtitle: "Pin contains only one saved ayah.",
                  //   isSelected: true,
                  //   // uiState.selectedCollectionType == CollectionType.bookmark,
                  //   value: const [],
                  //   groupValue: () {},
                  //   onTap: () => {},
                  //   selectedColor: uiState.selectedColor,
                  //   collectionType: const [],
                  // ),
                  gapH25,
                  TwoWayActionButton(
                    theme: theme,
                    submitButtonTitle: context.l10n.createAndAdd,
                    cancelButtonTitle: context.l10n.cancel,
                    onCancelButtonTap: context.navigatorPop,
                    submitButtonTextColor: context.color.whiteColor,
                    cancelButtonBgColor: theme.cardColor,
                    onSubmitButtonTap: () => presenter.addCollectionToAyah(
                      surahID: surahID,
                      ayahID: ayahID,
                      onSaved: () => context.navigatorPop<void>(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
