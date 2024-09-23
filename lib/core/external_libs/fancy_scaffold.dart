import 'package:flutter/material.dart';

enum FloatingWidgetState { open, closed }

class FloatingWidgetConfig {
  final bool backdropEnabled;
  final void Function(double position)? onSlide;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;
  final FloatingWidgetState defaultState;
  final Color backdropColor;
  final double backdropOpacity;
  final double? maxHeight;
  final double minHeight;
  final bool isPanelVisible;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const FloatingWidgetConfig({
    this.backdropEnabled = true,
    this.onSlide,
    this.onOpened,
    this.onClosed,
    this.defaultState = FloatingWidgetState.closed,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.5,
    this.maxHeight,
    this.minHeight = kToolbarHeight * 1.6,
    this.isPanelVisible = true,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(4),
  });
}

class FancyScaffold extends StatefulWidget {
  final Widget body;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final FloatingWidgetController? floatingWidgetController;
  final FloatingWidgetConfig floatingWidgetConfig;
  final double? bottomNavigationBarHeight;
  final bool isAudioPlaying;

  const FancyScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.floatingWidgetConfig = const FloatingWidgetConfig(),
    this.floatingWidgetController,
    this.bottomNavigationBarHeight,
    this.isAudioPlaying = false,
    super.key,
  });

  @override
  FancyScaffoldState createState() => FancyScaffoldState();
}

class FancyScaffoldState extends State<FancyScaffold> with TickerProviderStateMixin {
  late final navigationBarAnimationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
    value: 1,
  );

  late final floatingWidgetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
    value: widget.floatingWidgetConfig.defaultState == FloatingWidgetState.closed ? 0.0 : 1.0,
  );

  final _floatingWidgetScrollController = ScrollController();
  final bool _scrollingEnabled = false;

  bool navigationBarScrolledDown = false;
  double pixelsScrolled = 0;
  Key dismissKey = ValueKey(UniqueKey());

  @override
  void initState() {
    super.initState();
    floatingWidgetAnimationController.addListener(_floatingWidgetListener);
    _floatingWidgetScrollController.addListener(_scrollListener);
  }

  void _floatingWidgetListener() {
    if (widget.floatingWidgetConfig.onSlide != null) {
      widget.floatingWidgetConfig.onSlide!(floatingWidgetAnimationController.value);
    }

    if (widget.floatingWidgetConfig.onOpened != null && floatingWidgetAnimationController.value == 1.0) {
      widget.floatingWidgetConfig.onOpened!();
    }

    if (widget.floatingWidgetConfig.onClosed != null && floatingWidgetAnimationController.value == 0.0) {
      widget.floatingWidgetConfig.onClosed!();
    }

    if (!navigationBarScrolledDown) {
      navigationBarAnimationController.value = 1 - floatingWidgetAnimationController.value;
    }
  }

  void _scrollListener() {
    if (!_scrollingEnabled) {
      _floatingWidgetScrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.floatingWidgetController?._addState(this);
    final double systemTopPadding = MediaQuery.of(context).padding.top;
    final double systemBottomPadding = MediaQuery.of(context).padding.bottom;
    final double appBarHeight = widget.appBar != null ? kToolbarHeight : 0;

    return AnimatedBuilder(
      animation: floatingWidgetAnimationController,
      builder: (context, mainChild) {
        return AnimatedBuilder(
          animation: navigationBarAnimationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      SizedBox(height: systemTopPadding + appBarHeight * navigationBarAnimationController.value + 2),
                      Expanded(
                        child: child!,
                      ),
                    ],
                  ),
                ),
                if (widget.appBar != null)
                  Positioned(
                    top: -kToolbarHeight * (1 - navigationBarAnimationController.value) + systemTopPadding - 3,
                    left: 0,
                    right: 0,
                    child: widget.appBar!,
                  ),
                if (widget.bottomNavigationBar != null)
                  Positioned(
                    bottom: -(widget.bottomNavigationBarHeight ?? 80) * (1 - navigationBarAnimationController.value),
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      height: (widget.bottomNavigationBarHeight ?? 73) + systemBottomPadding,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: widget.bottomNavigationBar,
                            ),
                          ),
                          Container(
                            color: Theme.of(context).cardColor,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
          child: Listener(
            onPointerUp: _handlePointerUp,
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: _handleScrollNotification,
              child: mainChild!,
            ),
          ),
        );
      },
      child: widget.body,
    );
  }

  void _handlePointerUp(_) {
    pixelsScrolled = 0;
    if (navigationBarAnimationController.value > 0.5) {
      navigationBarAnimationController.animateTo(1);
      navigationBarScrolledDown = false;
    } else {
      navigationBarAnimationController.animateTo(0);
      navigationBarScrolledDown = false;
    }
  }

  bool _handleScrollNotification(ScrollUpdateNotification details) {
    if (widget.floatingWidgetController?.lockNotificationListener ?? false) {
      return false;
    }
    if (details.metrics.axis == Axis.horizontal) {
      return false;
    }

    // Check if audio is playing
    if (widget.isAudioPlaying) {
      return false;
    }

    pixelsScrolled = (pixelsScrolled + (details.scrollDelta ?? 0).abs()).clamp(0, 100) / 100;
    if ((details.scrollDelta ?? 0) > 0.0 && details.metrics.axis == Axis.vertical) {
      navigationBarAnimationController.value -= pixelsScrolled;
    } else {
      navigationBarAnimationController.value += pixelsScrolled;
    }
    return false;
  }

  Future<void> _close() {
    return floatingWidgetAnimationController.fling(velocity: -1.0);
  }

  Future<void> _open() {
    return floatingWidgetAnimationController.fling(velocity: 1.0);
  }

  Future<void> _animatePanelToPosition(
    double value, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
  }) {
    assert(0.0 <= value && value <= 1.0);
    return floatingWidgetAnimationController.animateTo(value, duration: duration, curve: curve);
  }

  set _panelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    floatingWidgetAnimationController.value = value;
  }

  double get _panelPosition => floatingWidgetAnimationController.value;

  bool get _isPanelAnimating => floatingWidgetAnimationController.isAnimating;

  bool get _isPanelOpen => floatingWidgetAnimationController.value == 1.0;

  bool get _isPanelClosed => floatingWidgetAnimationController.value == 0.0;
}

class FloatingWidgetController {
  FancyScaffoldState? _scaffoldState;

  void _addState(FancyScaffoldState panelState) {
    _scaffoldState = panelState;
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool lockNotificationListener = false;

  bool get isAttached => _scaffoldState != null;

  AnimationController get animationController => _scaffoldState!.floatingWidgetAnimationController;
  AnimationController get navbarAnimationController => _scaffoldState!.navigationBarAnimationController;
  bool get navbarScrolledDown => _scaffoldState!.navigationBarScrolledDown;
  set navbarScrolledDown(bool value) {
    _scaffoldState!.navigationBarScrolledDown = value;
  }

  Future<void> close() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._close();
  }

  Future<void> open() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._open();
  }

  Future<void> animatePanelToPosition(
    double value, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
  }) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    return _scaffoldState!._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  set panelPosition(double value) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    _scaffoldState!._panelPosition = value;
  }

  double get panelPosition {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._panelPosition;
  }

  bool get isPanelAnimating {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelAnimating;
  }

  bool get isPanelOpen {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelOpen;
  }

  bool get isPanelClosed {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelClosed;
  }
}
