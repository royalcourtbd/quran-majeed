import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/box_decoration.dart';

class CustomBottomSheetContainer extends StatelessWidget {
  const CustomBottomSheetContainer({
    super.key,
    required this.children,
    this.bottomSheetTitle,
    this.showPadding = true,
    this.constraints,
    required this.theme,
  });

  final List<Widget> children;
  final String? bottomSheetTitle;
  final bool showPadding;
  final BoxConstraints? constraints;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: constraints,
      padding: showPadding
          ? EdgeInsets.only(
              top: tenPx,
              bottom: twentyPx,
              left: twentyPx,
              right: twentyPx,
            )
          : EdgeInsets.zero,
      decoration: decorateBottomSheet(context),
      child: Wrap(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showPadding ? const SizedBox.shrink() : gapH10,
              if (bottomSheetTitle != null) ...[
                gapH8,
                Text(
                  bottomSheetTitle!,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: context.color.primaryColor,
                  ),
                ),
                gapH20,
              ],
              ...children,
            ],
          )
        ],
      ),
    );
  }
}
