import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';

class NotificationTitleWidget extends StatelessWidget {
  final String title, time;
  const NotificationTitleWidget({
    super.key,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
          top: fifteenPx, left: twentyPx, right: twentyPx, bottom: fivePx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          gapH10,
          Row(
            children: [
              SvgPicture.asset(
                SvgPath.icTimer,
                height: twelvePx,
                width: twelvePx,
              ),
              SizedBox(
                width: 3.px,
              ),
              Text(
                time,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: tenPx),
              )
            ],
          ),
        ],
      ),
    );
  }
}
