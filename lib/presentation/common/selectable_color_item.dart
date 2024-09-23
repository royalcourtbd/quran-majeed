import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/bounces.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';

class SelectableColorItem extends StatelessWidget {
  const SelectableColorItem({
    super.key,
    required this.currentColor,
    required this.isSelected,
    required this.presenter,
  });

  final Color currentColor;
  final bool isSelected;
 final CollectionPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => presenter.toggleColor(color: currentColor),
      child: Container(
        margin: EdgeInsets.only(right: twelvePx, bottom: twelvePx),
        decoration: BoxDecoration(borderRadius: radius6, color: currentColor),
        child: isSelected
            ? BounceInUp(
                duration: 62.inMilliseconds,
                child: Icon(
                  Icons.check_circle,
                  size: twentyPx,
                  color: Colors.white,
                  fill: 0,
                ),
              )
            : null,
      ),
    );
  }
}
