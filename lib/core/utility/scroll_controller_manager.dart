import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollControllerManager {
  ScrollControllerManager._(); // Private constructor

  static final ScrollControllerManager _instance = ScrollControllerManager._();

  factory ScrollControllerManager() => _instance; // Singleton instance

  final List<ItemScrollController> _scrollControllers = List.generate(114, (index) => ItemScrollController());


  final List<ScrollController> _basicscrollControllers = List.generate(114, (index) => ScrollController());
  final List<ItemPositionsListener> _itemPositionsListeners =
      List.generate(114, (index) => ItemPositionsListener.create());

  ScrollController getBasicScrollController(int index) => _basicscrollControllers[index];
  ItemScrollController getScrollController(int index) => _scrollControllers[index];
  ItemPositionsListener getItemPositionsListener(int index) => _itemPositionsListeners[index];
}
