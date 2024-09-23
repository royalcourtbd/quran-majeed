import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CopyShareContextMenu extends StatelessWidget {
  const CopyShareContextMenu({
    super.key = const Key("ContextMenuCopyShare32o#"),
    required this.anchor,
    required this.editableTextState,
  });

  final Offset anchor;
  final EditableTextState editableTextState;

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        context.theme.textTheme.labelSmall?.color ?? Colors.black;
    final TextStyle textStyle = TextStyle(color: textColor);

    return Stack(
      children: <Widget>[
        Positioned(
          top: anchor.dy - 70,
          left: anchor.dx * .5,
          child: Card(
            child: Row(
              children: [
                TextSelectionToolbarTextButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () async => _copyText(context),
                  child: Text("কপি", style: textStyle),
                ),
                TextSelectionToolbarTextButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () async => _shareText(),
                  child: Text("শেয়ার", style: textStyle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _shareText() async {
    await catchFutureOrVoid(() async {
      final String? sharingText = _textInside;
      if (sharingText == null) return;

      await shareText(text: sharingText);
      _deselectText();
      _hideContextMenu();
    });
  }

  Future<void> _copyText(BuildContext context) async {
    await catchFutureOrVoid(() async {
      final String? copyingText = _textInside;
      if (copyingText == null) return;

      await copyText(text: copyingText);
      _deselectText();
      if (context.mounted) {
        await showMessage(message: "কপি হয়েছে", context: context);
      }

      _hideContextMenu();
    });
  }

  String? get _textInside {
    final String? text = catchAndReturn(
      () {
        final String text = editableTextState.currentTextEditingValue.selection
            .textInside(editableTextState.currentTextEditingValue.text);
        if (text.isEmpty) throw Exception("no text selected");

        return text;
      },
    );
    return text;
  }

  void _deselectText() {
    editableTextState.userUpdateTextEditingValue(
      editableTextState.currentTextEditingValue.copyWith(
        selection: const TextSelection.collapsed(offset: -1),
      ),
      SelectionChangedCause.tap,
    );
  }

  void _hideContextMenu() => ContextMenuController.removeAny();
}
