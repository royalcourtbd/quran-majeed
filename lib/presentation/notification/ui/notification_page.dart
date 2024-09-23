import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/model_class/ui_models/notification_tile_model.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/notification/widgets/notification_list_widget.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final List<NotificationTileModel> notificationList = [
    NotificationTileModel(
        title: "Daily Ayah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "1 mins ago",
        iconPath: SvgPath.icDailyAyahNotification),
    NotificationTileModel(
        title: "App Notification Tile",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "1 mins ago",
        iconPath: SvgPath.icNotificationFill),
    NotificationTileModel(
        title: "Sadaqa Jariyah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "1 mins ago",
        iconPath: SvgPath.icSupport),
  ];

  final List<NotificationTileModel> yestardayNotificationList = [
    NotificationTileModel(
        title: "Daily Ayah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icDailyAyahNotification),
    NotificationTileModel(
        title: "App Notification Tile",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icNotificationFill),
    NotificationTileModel(
        title: "Sadaqa Jariyah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icSupport),
    NotificationTileModel(
        title: "Daily Ayah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icDailyAyahNotification),
    NotificationTileModel(
        title: "App Notification Tile",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icNotificationFill),
    NotificationTileModel(
        title: "Sadaqa Jariyah",
        subtitle:
            "The review you made for Iman Poricor helped the community and you earned 3 Points.",
        time: "yestarday",
        iconPath: SvgPath.icSupport),
  ];

  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        title: "Notifications",
        theme: theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              isColored: true,
              child: ListView(
                children: [
                  NotificationListWidget(
                    title: "Today",
                    notificationList: notificationList,
                  ),
                  gapH5,
                  NotificationListWidget(
                    title: "Yestarday",
                    notificationList: yestardayNotificationList,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
