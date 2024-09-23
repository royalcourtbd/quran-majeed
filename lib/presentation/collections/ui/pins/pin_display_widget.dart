import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/pin_list_item.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/pin_list_tab_item_widget.dart';

class PinDisplayWidget extends StatelessWidget {
  const PinDisplayWidget({
    super.key,
    required this.moreMenuPresenter,
    required this.theme,
  });

  final MoreMenuPresenter moreMenuPresenter;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 2,
            // moreMenuPresenter.currentUiState.pins.length,
            itemBuilder: 
            (_, index) => 
            PinListItem(
              pin: const [],
              // moreMenuPresenter.currentUiState.pins[index],
              theme: theme,
            ),
          )
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: thirtyFivePx,
              crossAxisSpacing: fivePx,
              mainAxisSpacing: fivePx,
            ),
            padding: EdgeInsets.only(
              left: fourteenPx,
              right: fourteenPx,
              bottom: thirtyFivePx,
            ),
            itemCount:2,
            //  moreMenuPresenter.currentUiState.pins.length,
            itemBuilder: (_, index) => PinListTabItemWidget(
              pin:const [],
              //  moreMenuPresenter.currentUiState.pins[index],
              theme: theme,
            ),
          );
  }
}
