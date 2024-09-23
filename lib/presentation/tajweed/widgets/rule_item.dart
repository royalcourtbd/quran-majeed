import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class RuleItem extends StatelessWidget {
  final String symbol;
  final String text;
  final String count;
  final Color color;
  final ThemeData theme;

  const RuleItem({
    super.key,
    required this.theme,
    required this.symbol,
    required this.text,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: fortyPx,
        height: twentyFivePx,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius20,
        ),
        child: Text(
          symbol,
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        text,
        style: theme.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: Text(
        'found $count times',
        style: context.quranText.lableExtraSmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: context.color.subtitleColor,
        ),
      ),
    );
  }
}
