import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/bookmark_details/widgets/ayah_view_mode_widget.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';

class BookmarkDetailsPage extends StatelessWidget {
  BookmarkDetailsPage({
    super.key,
    required this.folderName,
  });

  final String folderName;
  late final CollectionPresenter _collectionPresenter =
      locate<CollectionPresenter>();
  late final AyahPresenter _ayahPresenter = locate<AyahPresenter>();
  final TextEditingController editingController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Curve _animationCurve = Curves.easeInOutQuart;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _collectionPresenter,
      builder: () {
        final CollectionUiState uiState = _collectionPresenter.uiState.value;
        final List<BookmarkEntity> bookmarks = uiState.bookmarks;
        return Scaffold(
          appBar: CustomAppBar(
            key: const Key('BookmarkDetailsAppBar'),
            theme: theme,
            title: folderName,
            actions: [
              //TODO: v1 e bookmark list view er kaj kora hobe na, er jonno eta off rakha hoise...
              // AppbarActionIcon(
              //   svgPath: uiState.isGridView ? SvgPath.icGrid : SvgPath.icGridExpanded,
              //   theme: theme,
              //   onIconTap: () => _collectionPresenter.toggleGridView(),
              // ),
              gapW8
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: bookmarks.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: CurvedAnimation(
                        parent: animation,
                        curve: _animationCurve,
                      ),
                      child: AyahViewModeWidget(
                        collectionPresenter: _collectionPresenter,
                        index: index,
                        ayahPresenter: _ayahPresenter,
                        bookmarks: bookmarks[index],
                        isGrid: uiState.isGridView,
                        theme: theme,
                        onRemove: () {
                          _collectionPresenter.removeAyahFromBookmark(
                            bookmark: bookmarks[index],
                            context: context,
                            foldername: folderName,
                            onRemoveItem: (index) {
                              _listKey.currentState?.removeItem(
                                index,
                                (context, animation) => SizeTransition(
                                  sizeFactor: CurvedAnimation(
                                    parent: animation,
                                    curve: _animationCurve,
                                  ),
                                  child: AyahViewModeWidget(
                                    collectionPresenter: _collectionPresenter,
                                    index: index,
                                    ayahPresenter: _ayahPresenter,
                                    bookmarks: bookmarks[index],
                                    isGrid: uiState.isGridView,
                                    theme: theme,
                                  ),
                                ),
                                duration: _animationDuration,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
