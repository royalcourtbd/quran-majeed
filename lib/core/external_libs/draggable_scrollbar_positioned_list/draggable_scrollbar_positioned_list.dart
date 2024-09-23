import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/draggable_scrollbar_positioned_list/slide_fade_transition.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran_majeed/core/utility/ui_helper.dart';

typedef ScrollThumbBuilder = Widget Function(
  Color backgroundColor,
  Animation<double> thumbAnimation,
  double height,
);

class DraggableScrollbarPositionedList extends StatefulWidget {
  DraggableScrollbarPositionedList({
    super.key,
    this.alwaysVisibleScrollThumb = false,
    required this.heightScrollThumb,
    required this.backgroundColor,
    required this.scrollThumbBuilder,
    required this.child,
    required this.controller,
    this.padding,
    this.scrollbarAnimationDuration = const Duration(milliseconds: 300),
    this.scrollbarTimeToFade = const Duration(microseconds: 1),
    required this.onDragging,
  }) : assert(child.scrollDirection == Axis.vertical);

  DraggableScrollbarPositionedList.arrows({
    super.key,
    Key? scrollThumbKey,
    this.alwaysVisibleScrollThumb = false,
    required this.child,
    required this.controller,
    this.heightScrollThumb = 60.0,
    this.backgroundColor = Colors.white,
    this.padding,
    this.scrollbarAnimationDuration = const Duration(milliseconds: 300),
    this.scrollbarTimeToFade = const Duration(milliseconds: 600),
    this.onDragging,
  }) : scrollThumbBuilder = _thumbArrowBuilder(scrollThumbKey, alwaysVisibleScrollThumb);

  final ScrollablePositionedList child;

  final ScrollThumbBuilder scrollThumbBuilder;

  final double heightScrollThumb;

  final Color backgroundColor;

  final EdgeInsetsGeometry? padding;

  final Duration scrollbarAnimationDuration;

  final Duration scrollbarTimeToFade;

  final ItemScrollController controller;

  final bool alwaysVisibleScrollThumb;

  final void Function({required bool dragging})? onDragging;

  @override
  DraggableScrollbarPositionedListState createState() => DraggableScrollbarPositionedListState();

  static Widget buildScrollThumb({
    required Widget scrollThumb,
    required Color backgroundColor,
    required Animation<double> thumbAnimation,
    required bool alwaysVisibleScrollThumb,
  }) {
    if (alwaysVisibleScrollThumb) return scrollThumb;

    return SlideFadeTransition(
      key: const ValueKey('SlideFadeTransition2938492'),
      animation: thumbAnimation,
      child: scrollThumb,
    );
  }

  static ScrollThumbBuilder _thumbArrowBuilder(
    Key? scrollThumbKey,
    bool alwaysVisibleScrollThumb,
  ) {
    return (
      Color backgroundColor,
      Animation<double> thumbAnimation,
      double height,
    ) {
      // creates a ClipPath widget named scrollThumb that represents a scroll
      // thumb used in a scrollbar. The scroll thumb is a rectangular container
      // with rounded corners, and it uses an ArrowClipper as its clipper to
      // give it an arrow-shaped appearance.
      final ClipPath scrollThumb = ClipPath(
        key: const Key("ScrollThumbBuilderClipPath"),
        // clipper: ArrowClipper(),
        child: Container(
          key: scrollThumbKey,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Icon(
            Icons.unfold_more,
            color: Colors.grey.shade100,
          ),
        ),
      );

      return buildScrollThumb(
        scrollThumb: scrollThumb,
        backgroundColor: backgroundColor,
        thumbAnimation: thumbAnimation,
        alwaysVisibleScrollThumb: alwaysVisibleScrollThumb,
      );
    };
  }
}

class DraggableScrollbarPositionedListState extends State<DraggableScrollbarPositionedList>
    with TickerProviderStateMixin {
  late double _barOffset;
  late double _viewOffset;
  late bool _isDragInProcess;

  late AnimationController _thumbAnimationController;
  late Animation<double> _thumbAnimation;
  Timer? _fadeoutTimer;

  @override
  void initState() {
    super.initState();

    _barOffset = 0.0;
    _viewOffset = 0.0;

    _isDragInProcess = false;

    _thumbAnimationController = AnimationController(
      vsync: this,
      duration: widget.scrollbarAnimationDuration,
    );

    _thumbAnimation = CurvedAnimation(
      parent: _thumbAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _thumbAnimationController.dispose();
    _fadeoutTimer?.cancel();
    super.dispose();
  }

  double get barMaxScrollExtent => (context.size?.height ?? 0) - widget.heightScrollThumb - 100;

  double get barMinScrollExtent => 0;

  double get viewMaxScrollExtent =>
      (widget.controller.scrollController?.position.maxScrollExtent ?? 0) -
      (widget.controller.scrollController?.position.minScrollExtent ?? 0);

  double get viewMinScrollExtent => widget.controller.scrollController?.position.minScrollExtent ?? 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (__, _) {
        return NotificationListener<ScrollNotification>(
          key: const Key("DraggableListViewNotificationListener"),
          onNotification: (ScrollNotification notification) {
            changePosition(notification);
            return false;
          },
          // this is the stack containing whole list view
          // on top there is this scrollbar
          // and below that is the listview (widget.child)
          child: Stack(
            key: const Key("DraggableListViewWholeView"),
            children: <Widget>[
              // list view
              RepaintBoundary(child: widget.child),
              // scrollbar
              RepaintBoundary(
                key: const Key("RepaintBoundaryScrollbarDraggableListView"),
                child: GestureDetector(
                  key: const Key("RepaintBoundaryScrollbarDraggableListViewGD"),
                  onVerticalDragStart: _onVerticalDragStart,
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  onVerticalDragEnd: _onVerticalDragEnd,
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: _barOffset + 50),
                    padding: widget.padding,
                    child: widget.scrollThumbBuilder(
                      widget.backgroundColor,
                      _thumbAnimation,
                      widget.heightScrollThumb,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void changePosition(ScrollNotification notification) {
    // Check if a drag process is in progress, and if so, return without performing any further actions
    if (_isDragInProcess) return;

    // If the bar offset is 0, calculate a default value based on the scroll extents
    if (_barOffset == 0.0) {
      _barOffset = barMaxScrollExtent * viewMinScrollExtent.abs() / viewMaxScrollExtent;
    }
    UiHelper.doOnPageLoaded(() {
      // Check if the widget is still mounted before calling setState
      if (!mounted) return;

      setState(() {
        // Check if the notification is a ScrollUpdateNotification
        if (notification is ScrollUpdateNotification) {
          // Update the bar offset based on the bar delta calculated from the scroll delta
          _barOffset += getBarDelta(
            notification.scrollDelta ?? 0,
            barMaxScrollExtent,
            viewMaxScrollExtent,
          );

          // Ensure the bar offset stays within the minimum and maximum scroll extents of the bar
          if (_barOffset < barMinScrollExtent) {
            _barOffset = barMinScrollExtent;
          }
          if (_barOffset > barMaxScrollExtent) {
            _barOffset = barMaxScrollExtent;
          }

          // Update the view offset by adding the scroll delta to the current view offset
          _viewOffset += notification.scrollDelta!;

          // Ensure the view offset stays within the minimum and maximum scroll extents of the view
          if (_viewOffset < widget.controller.scrollController!.position.minScrollExtent) {
            _viewOffset = widget.controller.scrollController?.position.minScrollExtent ?? 0;
          }
          if (_viewOffset > viewMaxScrollExtent) {
            _viewOffset = viewMaxScrollExtent;
          }
        }

        // Check if the notification is a ScrollUpdateNotification or OverscrollNotification
        if (notification is ScrollUpdateNotification || notification is OverscrollNotification) {
          // Check if the thumb animation controller is not already animating forward
          if (_thumbAnimationController.status != AnimationStatus.forward) {
            // Start animating the thumb forward
            _thumbAnimationController.forward();
          }

          // Cancel any existing fadeout timer
          _fadeoutTimer?.cancel();

          // Start a new fadeout timer that will reverse the thumb animation
          _fadeoutTimer = Timer(widget.scrollbarTimeToFade, () {
            _thumbAnimationController.reverse();
            _fadeoutTimer = null;
          });
        }
      });
    });
  }

  // Calculate the change in position of the scroll bar relative to the scroll view
  // based on the scroll view delta, maximum scroll extent of the scroll bar,
  // and maximum scroll extent of the scroll view.
  double getBarDelta(
    double scrollViewDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) =>
      scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;

  // Calculate the change in position of the scroll view relative to the scroll bar
  // based on the bar delta, maximum scroll extent of the scroll bar,
  // and maximum scroll extent of the scroll view.
  double getScrollViewDelta(
    double barDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) =>
      barDelta * viewMaxScrollExtent / barMaxScrollExtent;

  void _onVerticalDragStart(DragStartDetails details) {
    widget.onDragging?.call(dragging: true);
    // implements a vertical scrollbar. When a vertical drag is initiated, it
    // updates the widget's state to indicate that a drag process is in progress.
    // also cancels any existing fade-out timer if one was previously set,
    // ensuring that the fade-out effect is halted during the drag operation.
    setState(() {
      _isDragInProcess = true;
      _fadeoutTimer?.cancel();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    widget.onDragging?.call(dragging: true);
    setState(() {
      // Check if the thumb animation controller is not already animating forward
      if (_thumbAnimationController.status != AnimationStatus.forward) {
        // Start animating the thumb forward
        _thumbAnimationController.forward();
      }

      // Check if a drag process is in progress
      if (_isDragInProcess) {
        // Update the bar offset based on the vertical delta of the drag update
        _barOffset += details.delta.dy;

        // Ensure the bar offset stays within the minimum and maximum scroll extents of the bar
        if (_barOffset < barMinScrollExtent) _barOffset = barMinScrollExtent;
        if (_barOffset > barMaxScrollExtent) _barOffset = barMaxScrollExtent;

        // Calculate the change in position of the scroll view based on the bar delta
        final double viewDelta = getScrollViewDelta(
          details.delta.dy,
          barMaxScrollExtent,
          viewMaxScrollExtent,
        );

        // Update the view offset by adding the view delta to the current scroll position
        _viewOffset = (widget.controller.scrollController?.position.pixels ?? 0) + viewDelta;

        // Ensure the view offset stays within the minimum and maximum scroll extents of the view
        if (_viewOffset < widget.controller.scrollController!.position.minScrollExtent) {
          _viewOffset = widget.controller.scrollController?.position.minScrollExtent ?? 0;
        }
        if (_viewOffset > viewMaxScrollExtent) {
          _viewOffset = viewMaxScrollExtent;
        }

        // Calculate the index based on the bar offset and total item count
        final index = _barOffset / barMaxScrollExtent * widget.child.itemCount;

        // Scroll the controller to the calculated index
        widget.controller.jumpTo(
          index: index.toInt(),
        );
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // widget.onDragging?.call(dragging: false);
    // implements a vertical scrollbar. When the vertical drag ends, it triggers
    // a fade-out effect for the scrollbar thumb and label by reversing the
    // animation controllers. Additionally, it updates the state to indicate
    // that the drag process is no longer in progress.
    _fadeoutTimer = Timer(widget.scrollbarTimeToFade, () {
      // _thumbAnimationController.reverse();
      _fadeoutTimer = null;
    });

    setState(() => _isDragInProcess = false);
  }
}
