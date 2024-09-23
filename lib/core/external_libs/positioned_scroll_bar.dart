import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/draggable_scrollbar_positioned_list/draggable_scrollbar_positioned_list.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';

class PositionedScrollBar extends StatelessWidget {
  const PositionedScrollBar({
    super.key,
    required this.listView,
    required this.controller,
    required this.showScrollBar,
    this.onDragging,
  });

  final ScrollablePositionedList listView;
  final ItemScrollController controller;
  final bool showScrollBar;
  final void Function({required bool dragging})? onDragging;

  @override
  Widget build(BuildContext context) {
    if (!showScrollBar) return listView;

    return DraggableScrollbarPositionedList.arrows(
      key: const Key('PositionedScrollBar'),
      backgroundColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(right: 2),
      onDragging: onDragging,
      controller: controller,
      child: listView,
    );
  }
}
