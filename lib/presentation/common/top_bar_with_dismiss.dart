import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/dismiss_button.dart';

class TopBarWithDismiss extends StatelessWidget {
  const TopBarWithDismiss({
    super.key,
    required this.title,
    required this.theme,
  });

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: context.color.subtitleColor,
          ),
        ),
        const DismissButton(),
      ],
    );
  }
}
