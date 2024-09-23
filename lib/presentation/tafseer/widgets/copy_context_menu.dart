import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CopyContextMenu extends StatelessWidget {
  const CopyContextMenu({
    super.key = const Key("ContextMenuCopy"),
    required this.theme,
    required this.anchor,
    required this.selectableRegionState,
  });

  final Offset anchor;
  final SelectableRegionState selectableRegionState;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: theme.textTheme.bodyMedium?.color!);
    return Stack(
      key: const Key("CopyContextMenu"),
      children: <Widget>[
        Positioned(
          top: anchor.dy - 70,
          left: anchor.dx * .5,
          child: Card(
            child: Row(
              children: [
                TextSelectionToolbarTextButton(
                  key: const Key("Copy"),
                  padding: padding15,
                  onPressed: () async {
                    // ignore: deprecated_member_use
                    selectableRegionState
                        .copySelection(SelectionChangedCause.toolbar);
                  },
                  child: Text("Copy", style: textStyle),
                ),
                TextSelectionToolbarTextButton(
                  key: const Key("SelectAll"),
                  padding: padding15,
                  onPressed: () async {
                    selectableRegionState.selectAll();
                  },
                  child: Text(context.l10n.selectAll, style: textStyle),
                ),
                TextSelectionToolbarTextButton(
                  key: const Key("share"),
                  padding: padding15,
                  onPressed: () async {},
                  child: Text("Share", style: textStyle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
