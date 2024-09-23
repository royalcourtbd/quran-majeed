import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomizableFeedbackWidget extends StatelessWidget {
  final String message;
  final String? svgPath;
  final ThemeData theme;

  const CustomizableFeedbackWidget({
    super.key,
    required this.theme,
    required this.message,
    this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgPath != null) ...[
            SvgPicture.asset(
              svgPath!,
              colorFilter:
                  buildColorFilterToChangeColor(context.color.primaryColor),
            ),
            gapH15,
          ],
          Text(
            message,
            style: theme.textTheme.headlineLarge!.copyWith(
              color: context.color.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          gapH8,
          Text(
            context.l10n.publishSoon,
            style: theme.textTheme.bodySmall!.copyWith(
              color: context.color.primaryColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
