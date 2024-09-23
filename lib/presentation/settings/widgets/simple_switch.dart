import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SimpleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const SimpleSwitch({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  SimpleSwitchState createState() => SimpleSwitchState();
}

class SimpleSwitchState extends State<SimpleSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _toggleSwitch(bool newValue) {
    setState(() {
      _value = newValue;
    });
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Transform.scale(
      alignment: Alignment.centerRight,
      scaleY: .65,
      scaleX: .7,
      child: Switch(
        value: _value,
        onChanged: _toggleSwitch,
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? context.color.whiteColor
              : Colors.white54,
        ),
        activeTrackColor: theme.primaryColor,
        inactiveTrackColor: theme.cardColor,
        trackOutlineWidth: WidgetStateProperty.resolveWith(
          (states) {
            if (isDarkMode(context)) return 0;

            return 1;
          },
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) {
            if (isDarkMode(context)) return Colors.transparent;
            if (states.contains(WidgetState.selected)) {
              return Colors.transparent;
            }
            return theme.dividerColor;
          },
        ),
      ),
    );
  }
}
