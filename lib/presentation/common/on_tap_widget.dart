import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class OnTapWidget extends StatelessWidget {
  const OnTapWidget({
    super.key,
    required this.child,
    required this.theme,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
  });
  final Widget? child;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final BorderRadius? borderRadius;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: tenPx,
      splashColor: theme.cardColor.withOpacity(0.7),
      overlayColor: WidgetStatePropertyAll(theme.cardColor.withOpacity(0.7)),
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: child,
    );
  }
}
