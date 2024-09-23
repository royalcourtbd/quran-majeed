import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';

import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/common/selectable_color_list.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class EditBookmarkBottomSheet extends StatelessWidget {
  final BookmarkFolderEntity folder;
  final Future<bool> Function(String, Color) onEditBookmarkFolder;

  EditBookmarkBottomSheet({
    super.key,
    required this.folder,
    required this.onEditBookmarkFolder,
  });

  static Future<void> show({
    required BuildContext context,
    required BookmarkFolderEntity bookmarkFolder,
    required Future<bool> Function(String, Color) onEditBookmarkFolder,
  }) async {
    final EditBookmarkBottomSheet editBookmarkCollection =
        await Future.microtask(
      () => EditBookmarkBottomSheet(
        key: const Key("EditBookmarkBottomSheet"),
        folder: bookmarkFolder,
        onEditBookmarkFolder: onEditBookmarkFolder,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(editBookmarkCollection, context);
    }
  }

  final TextEditingController _folderNameEditingController =
      TextEditingController();
  final CollectionPresenter _collectionPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _collectionPresenter,
      onInit: () {
        _folderNameEditingController.text = folder.name;
        _collectionPresenter.toggleColor(color: folder.color);
      },
      builder: () {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CustomBottomSheetContainer(
            key: const Key('EditBookmarkBottomSheet'),
            theme: theme,
            bottomSheetTitle: 'Edit Bookmark',
            children: [
              HeaderTitle(title: 'Change Name', theme: theme),
              gapH10,
              SizedBox(
                height: fortyFivePx,
                child: UserInputField(
                  contentPadding: EdgeInsets.only(right: tenPx),
                  key: const Key("bookmark_search_edit_box"),
                  textEditingController: _folderNameEditingController,
                  hintText: 'Example Name',
                  prefixIconPath: SvgPath.icFolder,
                  prefixIconColor:
                      _collectionPresenter.currentUiState.selectedColor,
                  borderRadius: radius10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^[1-9][0-9]*$'),
                    ),
                    FilteringTextInputFormatter.deny(RegExp(r'^(0|\s).*')),
                  ],
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
                submitButtonTitle: "Done",
                cancelButtonTitle: "Cancel",
                theme: theme,
                onCancelButtonTap: () => context.navigatorPop<void>(),
                onSubmitButtonTap: () async {
                  final bool isEdited = await onEditBookmarkFolder(
                    _folderNameEditingController.text,
                    _collectionPresenter.currentUiState.selectedColor,
                  );
                  if (isEdited && context.mounted) context.navigatorPop<void>();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
