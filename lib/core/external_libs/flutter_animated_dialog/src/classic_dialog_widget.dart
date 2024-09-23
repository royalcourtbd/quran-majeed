import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/extentions/theme_colors_ext.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';


typedef OnSingleSelectionCallback = void Function(int selectedIndex);

typedef OnMultiSelectionCallback = void Function(List<int> selectedIndexes);

class ClassicGeneralDialogWidget extends StatelessWidget {
  const ClassicGeneralDialogWidget({
    super.key,
    this.titleText,
    this.contentText,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.negativeTextStyle,
    this.positiveTextStyle,
    this.onNegativeClick,
    this.onPositiveClick,
  });

  final String? titleText;

  final String? contentText;

  final String? negativeText;

  final String? positiveText;

  final TextStyle? negativeTextStyle;

  final TextStyle? positiveTextStyle;

  final VoidCallback? onNegativeClick;

  final VoidCallback? onPositiveClick;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      title: titleText != null
          ? Text(
              titleText!,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      content: contentText != null
          ? Text(
              contentText!,
              style: Theme.of(context).dialogTheme.contentTextStyle,
            )
          : null,
      actions: actions ??
          [
            if (onNegativeClick != null)
              TextButton(
                onPressed: onNegativeClick,
                child: Text(
                  negativeText ?? 'cancel',
                  style: negativeTextStyle ??
                      TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
                        fontSize:
                            Theme.of(context).textTheme.labelLarge!.fontSize,
                      ),
                ),
              )
            else
              Container(),
            if (onPositiveClick != null)
              TextButton(
                onPressed: onPositiveClick,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      }
                      return Theme.of(context).splashColor;
                    },
                  ),
                ),
                child: Text(
                  positiveText ?? 'confirm',
                  style: positiveTextStyle ??
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize:
                            Theme.of(context).textTheme.labelLarge!.fontSize,
                      ),
                ),
              )
            else
              Container(),
          ],
      elevation: 0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}

enum ListType {
  single,
  singleSelect,
  multiSelect,
}

class ClassicListDialogWidget<T> extends StatefulWidget {
  const ClassicListDialogWidget({
    super.key,
    this.titleText,
    required this.dataList,
    this.listItem,
    this.onListItemClick,
    this.listType = ListType.single,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.activeColor,
    this.selectedIndexes,
    this.selectedIndex,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.onNegativeClick,
    this.onPositiveClick,
  });

  final String? titleText;

  final List<T> dataList;

  final Widget? listItem;

  final VoidCallback? onListItemClick;

  final ListType? listType;

  final ListTileControlAffinity? controlAffinity;

  final Color? activeColor;

  final List<int>? selectedIndexes;

  final int? selectedIndex;

  final String? negativeText;

  final String? positiveText;

  final VoidCallback? onNegativeClick;

  final VoidCallback? onPositiveClick;

  final List<Widget>? actions;

  @override
  State<StatefulWidget> createState() {
    return ClassicListDialogWidgetState<T>();
  }
}

class ClassicListDialogWidgetState<T>
    extends State<ClassicListDialogWidget<T>> {
  int? selectedIndex;
  late List<bool> valueList;
  List<int>? selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    valueList = List.generate(widget.dataList.length, (index) {
      if (widget.selectedIndexes != null &&
          widget.selectedIndexes!.contains(index)) {
        return true;
      }
      return false;
    }).toList(growable: true);
    selectedIndex = widget.selectedIndex;
    selectedIndexes = widget.selectedIndexes;
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (widget.listItem == null) {
          switch (widget.listType) {
            case ListType.single:
              return ListTile(
                title: Text(
                  widget.dataList[index].toString(),
                  style: Theme.of(context).dialogTheme.contentTextStyle,
                ),
                onTap: widget.onListItemClick ??
                    () {
                      Navigator.of(context).pop(index);
                    },
              );
            case ListType.singleSelect:
              return RadioListTile<int>(
                controlAffinity: widget.controlAffinity!,
                title: Text(
                  widget.dataList[index].toString(),
                  style: Theme.of(context).dialogTheme.contentTextStyle,
                ),
                activeColor:
                    widget.activeColor ?? Theme.of(context).primaryColor,
                value: index,
                groupValue: selectedIndex,
                onChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              );
            case ListType.multiSelect:
              return CheckboxListTile(
                controlAffinity: widget.controlAffinity!,
                selected: valueList[index],
                value: valueList[index],
                title: Text(
                  widget.dataList[index].toString(),
                  style: Theme.of(context).dialogTheme.contentTextStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    valueList[index] = value!;
                  });
                },
                activeColor:
                    widget.activeColor ?? Theme.of(context).primaryColor,
              );
            default:
              return ListTile(
                title: Text(
                  widget.dataList[index].toString(),
                  style: Theme.of(context).dialogTheme.contentTextStyle,
                ),
                onTap: widget.onListItemClick ??
                    () {
                      Navigator.of(context).pop(index);
                    },
              );
          }
        } else {
          return widget.listItem!;
        }
      },
      itemCount: widget.dataList.length,
    );
    contentWidget = SizedBox(
      width: double.maxFinite,
      child: contentWidget,
    );

    return CustomDialogWidget(
      title: widget.titleText != null
          ? Text(
              widget.titleText!,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      contentPadding: EdgeInsets.zero,
      content: contentWidget,
      actions: widget.actions ??
          [
            if (widget.onNegativeClick != null)
              TextButton(
                onPressed: widget.onNegativeClick,
                child: Text(
                  widget.negativeText ?? 'cancel',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
                    fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                  ),
                ),
              ),
            TextButton(
              onPressed: widget.onPositiveClick ??
                  () {
                    switch (widget.listType) {
                      case ListType.single:
                        Navigator.of(context).pop();
                      case ListType.singleSelect:
                        Navigator.of(context).pop(selectedIndex);
                      case ListType.multiSelect:
                        selectedIndexes = [];
                        final int length = valueList.length;
                        for (int i = 0; i < length; i++) {
                          if (valueList[i]) {
                            selectedIndexes!.add(i);
                          }
                        }
                        Navigator.of(context).pop(selectedIndexes);
                      default:
                        Navigator.of(context).pop();
                        break;
                    }
                  },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    }
                    return Theme.of(context).splashColor;
                  },
                ),
              ),
              child: Text(
                widget.positiveText ?? 'confirm',
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                ),
              ),
            ),
          ],
      elevation: 0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}
