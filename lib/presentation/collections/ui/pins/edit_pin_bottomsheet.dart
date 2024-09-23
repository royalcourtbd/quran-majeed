import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/common/selectable_color_list.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class EditPinBottomSheet extends StatelessWidget {
  final dynamic pin;
  EditPinBottomSheet({
    super.key,
    required this.pin,
  });

  static Future<void> show({
    required BuildContext context,
    required dynamic pin,
  }) async {
    final EditPinBottomSheet editBookmarkCollection = await Future.microtask(
      () => EditPinBottomSheet(
        key: const Key("EditPinBottomSheet"),
        pin: pin,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(editBookmarkCollection, context);
    }
  }

  final TextEditingController _pinNameEditingController =
      TextEditingController();
  late final CollectionPresenter _collectionPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: _collectionPresenter,
        onInit: () {
          _pinNameEditingController.text = pin.name;
          _collectionPresenter.toggleColor(color: pin.color);
        },
        builder: () {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CustomBottomSheetContainer(
              key: const Key('EditPinBottomSheet'),
              theme: theme,
              bottomSheetTitle: "Edit Pin",
              children: [
                HeaderTitle(title: 'Change Name', theme: theme),
                gapH10,
                SizedBox(
                  height: fortyFivePx,
                  child: UserInputField(
                    textEditingController: _pinNameEditingController,
                    contentPadding: EdgeInsets.only(right: tenPx),
                    hintText: 'Example Name',
                    prefixIconPath: SvgPath.icFolder,
                    prefixIconColor:
                        _collectionPresenter.currentUiState.selectedColor,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.deny(
                        RegExp(r'^[1-9][0-9]*$'),
                      ),
                      FilteringTextInputFormatter.deny(RegExp(r'^(0|\s).*')),
                    ],
                    borderRadius: radius10,
                  ),
                ),
                gapH22,
                HeaderTitle(title: 'Change Folder Color', theme: theme),
                gapH10,
                SelectableColorList(
                  presenter: _collectionPresenter,
                ),
                gapH20,
                //const SizedBox(height: 10),
                TwoWayActionButton(
                  theme: theme,
                  submitButtonTitle: "Done",
                  cancelButtonTitle: "Cancel",
                  onCancelButtonTap: () => context.navigatorPop<void>(),
                  onSubmitButtonTap: () {}
                  // {
                  //   _collectionPresenter.updatePin(
                  //     name: pin.name,
                  //     newName: _pinNameEditingController.text,
                  //     color: _moreMenuPresenter.currentUiState.selectedColor,
                  //     onUpdated: () async {
                  //       context.navigatorPop<void>();
                  //       await _moreMenuPresenter.getAllPins();
                  //       Fluttertoast.showToast(msg: "Pin Updated");
                  //     },
                  //   );
                  // }
                  ,
                ),
              ],
            ),
          );
        });
  }
}
