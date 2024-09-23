import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/common/selectable_color_item.dart';

class SelectableColorList extends StatelessWidget {
  const  SelectableColorList({super.key, required this.presenter,});

  final CollectionPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final CollectionUiState uiState = presenter.currentUiState;
    final Color selectedColor = uiState.selectedColor;
    final List<Color> availableColors = presenter.availableColors;
    return Container(
      alignment: Alignment.centerLeft,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
          mainAxisSpacing: fivePx,
        ),
        itemCount: availableColors.length,
        itemBuilder: (_, index) {
          final Color color = availableColors[index];
          return SelectableColorItem(
            key: ValueKey(color),
            currentColor: color,
            isSelected: selectedColor == color,
            presenter: presenter,
          );
        },
      ),
    );
  }
}
