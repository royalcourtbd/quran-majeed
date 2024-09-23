import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/advanced_range_slider.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomRangeSlider extends StatelessWidget {
  final int minVal, maxVal;
  final ThemeData theme;
  final Function(int index, dynamic lowerValue, dynamic upperValue) onDragging;
  const CustomRangeSlider({
    super.key,
    required this.minVal,
    required this.maxVal,
    required this.onDragging,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$minVal',
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: context.color.primaryColor,
          ),
        ),
        Flexible(
          child: AdvancedRangeSlider(
            tooltip: FlutterSliderTooltip(
              format: (value) {
                // int.parse(value);
                return value.toString().replaceAll(".0", "");
              },
              textStyle: TextStyle(
                color: context.color.primaryColor,
                fontSize: fourteenPx,
                fontWeight: FontWeight.w600,
              ),
              boxStyle: FlutterSliderTooltipBox(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: radius8,
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withAlpha(40),
                      blurRadius: 5.px,
                      spreadRadius: 1.px,
                    ),
                  ],
                ),
              ),
            ),
            values: const [1, 2],
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: fourPx,
              inactiveTrackBarHeight: fourPx,
              inactiveTrackBar: BoxDecoration(
                borderRadius: radius20,
                color: context.color.primaryColor.withOpacity(.1),
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(fourPx),
                color: context.color.primaryColor,
              ),
            ),
            rangeSlider: true,
            max: 7,
            min: 1,
            rightHandler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: Container(
                height: seventeenPx,
                width: seventeenPx,
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: Container(
                height: seventeenPx,
                width: seventeenPx,
                decoration: BoxDecoration(
                  color: context.color.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            onDragging: onDragging,
          ),
        ),
        Text(
          '$maxVal',
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: context.color.primaryColor,
          ),
        ),
      ],
    );
  }
}
