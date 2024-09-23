import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/bookmark_selector_list_tab.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/collection_bottomsheet_persistent_footer.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/collection_bottomsheet_header.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/pin_selector_list_tab.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';

class CollectionBottomSheet extends StatefulWidget {
  const CollectionBottomSheet({
    super.key,
    required this.surahID,
    required this.ayahID,
    required this.onBookmarkAdded,
  });

  final int surahID;
  final int ayahID;
  final void Function(int, {required bool isBookmarked}) onBookmarkAdded;

  @override
  State<CollectionBottomSheet> createState() => _CollectionBottomSheetState();

  static Future<void> show({
    required int surahID,
    required int ayahID,
    required Future<void> Function(int, {required bool isBookmarked})
        onBookmarkToggled,
    required BuildContext context,
  }) async {
    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.black.withOpacity(0.5),
      builder: (_) => CollectionBottomSheet(
        surahID: surahID,
        ayahID: ayahID,
        onBookmarkAdded: onBookmarkToggled,
      ),
    );
    dislocate<MoreMenuPresenter>();
  }
}

class _CollectionBottomSheetState extends State<CollectionBottomSheet>
    with SingleTickerProviderStateMixin {
  static const double _minChildSize = 0.65;
  static const double _maxChildSize = 1.0;

  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late final CollectionPresenter _presenter = locate<CollectionPresenter>();
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void dispose() {
    _tabController.dispose();
    _dragController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details, Size contextSize) {
    final double newSize =
        (_dragController.size - details.primaryDelta! / contextSize.height)
            .clamp(_minChildSize, _maxChildSize);

    if (newSize != _dragController.size) {
      _dragController.animateTo(
        newSize,
        duration: const Duration(milliseconds: 10),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      onInit: () => _presenter.fetchSelectedCollections(
        surahID: widget.surahID,
        ayahID: widget.ayahID,
      ),
      builder: () {
        final CollectionUiState uiState = _presenter.currentUiState;
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent < _minChildSize) {
              _dragController.animateTo(_minChildSize,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOut);
            }
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: _minChildSize,
            minChildSize: _minChildSize,
            maxChildSize: _maxChildSize,
            snap: true,
            snapSizes: const [_minChildSize, _maxChildSize],
            controller: _dragController,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                key: const Key("CollectionBottomSheetGestureDetector"),
                onVerticalDragUpdate: (details) =>
                    _handleDragUpdate(details, context.size!),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(twentyPx)),
                  ),
                  child: Column(
                    children: [
                      CollectionBottomSheetHeader(
                        key: const Key("CollectionBottomSheetPersistentHeader"),
                        tabController: _tabController,
                        themeData: theme,
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          key: const Key("TabBarView"),
                          controller: _tabController,
                          children: [
                            ListView(
                              controller: scrollController,
                              children: [
                                BookmarkSelectorListTab(
                                  key: const Key("BookmarkSelectorListTab"),
                                  theme: theme,
                                  bookmarkFolders: uiState.bookmarkFolders,
                                  selectedBookmarkFolderNames:
                                      uiState.selectedBookmarkFolderNames,
                                  presenter: _presenter,
                                ),
                              ],
                            ),
                            ListView(
                              controller: scrollController,
                              children: [
                                PinSelectorListTab(
                                  key: const Key("PinSelectorListTab"),
                                  pinList: const [],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CollectionBottomSheetPersistentFooter(
                        key: const Key("CollectionBottomSheetPersistentFooter"),
                        theme: theme,
                        surahID: widget.surahID,
                        ayahID: widget.ayahID,
                        presenter: _presenter,
                        onBookmarkToggled: widget.onBookmarkAdded,
                        onNewCreateBottomSheetClosed: () => _presenter
                            .onNewCreateBottomSheetClosed(_tabController),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
