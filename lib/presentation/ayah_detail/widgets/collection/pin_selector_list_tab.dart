import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/collection/pin_selector_list_item.dart';

class PinSelectorListTab extends StatelessWidget {
  PinSelectorListTab({
    super.key,
    required this.pinList,
  });
  final List<dynamic> pinList;
  final MoreMenuPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        final List<dynamic> pins = [];
        const String selectedPinName = '';
        // uiState.selectedPinName;
        return ListView.builder(
          itemCount: pins.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, index) {
            final dynamic pin = pins[index];
            return PinSelectorListItem(
              key: ValueKey(pin),
              moreMenuPresenter: _presenter,
              theme: theme,
              pin: pin,
              selectedPinName: selectedPinName,
            );
          },
        );
      },
    );
  }
}
