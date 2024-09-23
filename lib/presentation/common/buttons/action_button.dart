import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.buttonText,
    this.isFocused = true,
    this.height,
    required this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
    required this.onTap,
    this.color,
    this.isError = false,
    required this.theme,
  });

  final String buttonText;
  final Color? color;
  final bool isFocused;
  final void Function() onTap;
  final double? height;
  final double width;
  final EdgeInsets padding;
  final bool isError;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      borderRadius: radius5,
      onTap: onTap,
      theme: theme,
      child: Container(
        width: width,
        height: height ?? 40,
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: theme.textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: color ??
                  (isError
                      ? theme.colorScheme.error
                      : isFocused
                          ? theme.primaryColor
                          : theme.textTheme.bodyMedium!.color),
            ),
          ),
        ),
      ),
    );
  }
}
