import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/model_class/ui_models/notification_tile_model.dart';
import 'package:quran_majeed/presentation/notification/widgets/custom__notification_tile.dart';

class NotificationListWidget extends StatelessWidget {
  final String title;
  final List<NotificationTileModel> notificationList;
  const NotificationListWidget(
      {super.key, required this.title, required this.notificationList});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: tenPx,
            left: twentyPx,
          ),
          child: Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor.withOpacity(0.5),
            ),
          ),
        ),
        gapH5,
        ListView.builder(
          itemCount: notificationList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CustomNotificationTile(
            onTap: () {},
            index: index,
            title: notificationList[index].title,
            subtitle: notificationList[index].subtitle,
            time: notificationList[index].time,
            iconPath: notificationList[index].iconPath,
          ),
        )
      ],
    );
  }
}
