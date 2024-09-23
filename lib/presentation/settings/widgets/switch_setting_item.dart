import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/settings/widgets/simple_switch.dart';

class SwitchSettingItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ThemeData theme;

  const SwitchSettingItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        SimpleSwitch(
          initialValue: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
