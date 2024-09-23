import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.theme,
    required this.title,
    this.note,
    this.titleStyle,
    this.onTap,
  });

  final ThemeData theme;
  final String title;
  final String? note;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: OnTapWidget(
        onTap: onTap,
        theme: theme,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: titleStyle ??
                    theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (note != null)
                TextSpan(
                  text: note,
                  style: context.quranText.lableExtraSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
