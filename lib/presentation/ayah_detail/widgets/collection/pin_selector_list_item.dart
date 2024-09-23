import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/more_menu_presenter.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class PinSelectorListItem extends StatelessWidget {
  const PinSelectorListItem({
    super.key,
    required this.pin,
    required this.selectedPinName,
    required this.theme,
    required this.moreMenuPresenter,
  });

  final dynamic pin;
  final String? selectedPinName;
  final MoreMenuPresenter moreMenuPresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          gapH8,
          Row(
            children: [
              gapW10,
              Transform.scale(
                scale: 0.8,
                child: Radio(
                  visualDensity: VisualDensity.compact,
                  activeColor: context.color.primaryColor,
                  value: pin.name,
                  groupValue: selectedPinName,
                  fillColor: WidgetStateProperty.all(
                    selectedPinName == pin.name
                        ? context.color.primaryColor
                        : context.color.primaryColor.withOpacity(0.38),
                  ),
                  onChanged: (_) => {}
                  // moreMenuPresenter.onPinSelected(pinName: pin.name)
                  ,
                ),
              ),
              OnTapWidget(
                theme: theme,
                onTap: () => {}
                // moreMenuPresenter.onPinSelected(pinName: pin.name)
                ,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgPath.icPin,
                      height: twentyFourPx,
                      colorFilter: buildColorFilter(pin.color),
                    ),
                    gapW15,
                    SizedBox(
                      width: sixtySixPercentWidth,
                      child: Text(
                        pin.name,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: thirteenPx,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
