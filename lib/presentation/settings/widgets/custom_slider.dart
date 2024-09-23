import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final double min;
  final double max;
  final double defaultValue;
  final Color? activeColor;
  final Color? inactiveColor;
  final Function(double) onChanged;

  const CustomSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.defaultValue,
    this.activeColor,
    this.inactiveColor,
    required this.onChanged,
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  late double _currentSliderValue;
  final double _trackHeight = 6;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color activeColor = widget.activeColor ?? context.color.primaryColor;
    final Color inactiveColor =
        widget.inactiveColor ?? activeColor.withAlpha(55);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        gapH10,
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorTextStyle: TextStyle(
                    color: context.color.primaryColor,
                    fontSize: fourteenPx,
                    fontWeight: FontWeight.w600,
                  ),
                  valueIndicatorShape: AbovePointerSliderValueIndicatorShape(
                    valueStyle: TextStyle(
                      color: context.color.primaryColor,
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w600,
                    ),
                    context: context,
                  ),
                  showValueIndicator: ShowValueIndicator.always,
                  trackHeight: _trackHeight,
                  activeTrackColor: activeColor,
                  inactiveTrackColor: inactiveColor,
                  thumbColor: activeColor,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                  tickMarkShape: SliderTickMarkShape.noTickMark,
                  trackShape: CustomTrackShape(trackHeight: _trackHeight),
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: widget.min,
                  max: widget.max,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            gapW5,
            Container(
              alignment: Alignment.centerRight,
              width: 20,
              child: Text(
                _currentSliderValue.round().toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// CustomTrackShape to customize track height
class CustomTrackShape extends SliderTrackShape {
  final double trackHeight;

  const CustomTrackShape({required this.trackHeight});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? this.trackHeight;

    final double trackLength = parentBox.size.width;

    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      offset.dy + (parentBox.size.height - trackHeight) / 2,
      trackLength,
      trackHeight,
    );

    return trackRect;
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    TextDirection? textDirection,
    Offset? secondaryOffset,
  }) {
    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    final double trackHeight = sliderTheme.trackHeight ?? this.trackHeight;
    final double trackRadius = trackHeight / 2;
    final double trackLength = parentBox.size.width;

    final RRect activeTrackRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx,
        thumbCenter.dy - trackRadius,
        thumbCenter.dx - offset.dx,
        trackHeight,
      ),
      Radius.circular(trackRadius),
    );

    final RRect inactiveTrackRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        thumbCenter.dx,
        thumbCenter.dy - (trackHeight / 2),
        trackLength - thumbCenter.dx,
        trackHeight,
      ),
      Radius.circular(trackHeight / 2),
    );

    context.canvas.drawRRect(activeTrackRRect, activePaint);
    context.canvas.drawRRect(inactiveTrackRRect, inactivePaint);
  }
}

// The AbovePointerSliderValueIndicatorShape class with context parameter
class AbovePointerSliderValueIndicatorShape extends SliderComponentShape {
  final TextStyle valueStyle;
  final BuildContext context;

  const AbovePointerSliderValueIndicatorShape({
    required this.valueStyle,
    required this.context,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30, 35);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final ThemeData theme = Theme.of(this.context);

    final rect = Rect.fromCenter(
      center: center.translate(0, -35),
      width: 30,
      height: 35,
    );

    final RRect indicator = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(8),
    );

    final Paint paint = Paint()
      ..color = theme.cardColor
      ..style = PaintingStyle.fill;

    // Draw the shadow
    final RRect shadowRect = indicator.shift(const Offset(0, 3));
    canvas.drawShadow(
      Path()..addRRect(shadowRect),
      theme.primaryColor.withAlpha(40),
      5,
      true,
    );

    // Draw the actual tooltip
    canvas.drawRRect(indicator, paint);

    final textOffset = Offset(
      rect.left + (rect.width - labelPainter.width) / 2,
      rect.top + (rect.height - labelPainter.height) / 2,
    );
    labelPainter.paint(canvas, textOffset);
  }
}
