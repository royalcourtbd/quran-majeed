import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class NoteAyahListItem extends StatelessWidget {
  const NoteAyahListItem({
    super.key,
    required CollectionPresenter presenter,
    required this.theme,
    required this.index,
  }) : _presenter = presenter;

  final CollectionPresenter _presenter;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
        presenter: _presenter,
        builder: () {
          return Material(
            color: Colors.transparent,
            child: OnTapWidget(
              theme: theme,
              onTap: () {
                _presenter.selectBookmarkItem(index);
              },
              onLongPress: () => _presenter.toggleSelectionVisibility(),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: twelvePx, horizontal: twentyPx),
                // margin: EdgeInsets.only(bottom: twelvePx),
                child: Row(
                  children: [
                    Visibility(
                      visible: _presenter.uiState.value.checkBox,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          value: _presenter.uiState.value.isSelected
                              .contains(index),
                          onChanged: (value) =>
                              _presenter.selectBookmarkItem(index),
                        ),
                      ),
                    ),
                    _presenter.uiState.value.checkBox == false
                        ? const SizedBox.shrink()
                        : gapW10,
                    Container(
                      padding: padding12,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: radius10,
                      ),
                      child: SvgImage(
                        SvgPath.icDocument,
                        width: twentyFourPx,
                        height: twentyFourPx,
                        color: context.color.primaryColor,
                      ),
                    ),
                    gapW15,
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Surah Name 1:5',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapH4,
                          SizedBox(
                            width: sixtySixPercentWidth,
                            child: Text(
                              'This is the Book! There is no doubt about it1—a guide for those mindful ˹of Allah˺,2',
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
