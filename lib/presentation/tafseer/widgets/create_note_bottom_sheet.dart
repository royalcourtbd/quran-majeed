import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/custom_text_form_field.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';

class CreateNoteBottomSheet extends StatelessWidget {
  CreateNoteBottomSheet({super.key, this.isEditNot = false});
  final bool isEditNot;

  static Future<void> show(
      {required BuildContext context, bool? isEditNot}) async {
    final CreateNoteBottomSheet createNoteBottomSheet = await Future.microtask(
      () => CreateNoteBottomSheet(
        key: const Key('CreateNoteBottomSheet'),
        isEditNot: isEditNot!,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet(createNoteBottomSheet, context);
    }
  }

  final TextEditingController _titleTextEditingController =
      TextEditingController();

  final TextEditingController _contentTextEditingController =
      TextEditingController();
  final TafseerPresenter _tafseerPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: CustomBottomSheetContainer(
        key: const Key('CreateNoteBottomSheet'),
        theme: theme,
        bottomSheetTitle: 'Create Note',
        children: [
          HeaderTitle(
            title: isEditNot ? 'Edit Note Title' : 'Set Note Title',
            theme: theme,
          ),
          gapH10,
          SizedBox(
            height: fortyFivePx,
            child: CustomTextFormField(
              folderNameEditingController: _titleTextEditingController,
              focusNode: _tafseerPresenter.titleFocusNode,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[1-9][0-9]*$'),
                ),
                FilteringTextInputFormatter.deny(RegExp(r'^(0|\s).*')),
              ],
              hintText: 'Enter a title',
            ),
          ),
          gapH20,
          HeaderTitle(
            title: isEditNot ? 'Edit Note' : 'Write Note',
            theme: theme,
          ),
          gapH10,
          TextFormField(
            maxLines: 5,
            controller: _contentTextEditingController,
            focusNode: _tafseerPresenter.contentFocusNode,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: inputDecorateBottomSheet(
              context: context,
              hintText: "Write Here",
              borderRadius: radius10,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: fifteenPx, vertical: twelvePx),
            ),
          ),
          gapH20,
          TwoWayActionButton(
            theme: theme,
            submitButtonTitle: 'Save',
            cancelButtonTitle: 'Cancel',
            onCancelButtonTap: () => context.navigatorPop<void>(),
          ),
        ],
      ),
    );
  }
}
