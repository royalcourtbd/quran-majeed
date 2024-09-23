import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CenteredPageIndicator extends StatelessWidget {
  const CenteredPageIndicator({
    super.key,
    required this.theme,
    required this.pageNumber,
    required this.juzNumber,
    required this.hijbNumber,
  });

  final ThemeData theme;
  final int? pageNumber;
  final int? juzNumber;
  final String? hijbNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: twentyPx,
        vertical: tenPx,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.secondary,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: theme.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Text(
        '${context.l10n.page} : $pageNumber  •  ${context.l10n.juz} : $juzNumber  •  ${context.l10n.hijb} : $hijbNumber',
        style: theme.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
