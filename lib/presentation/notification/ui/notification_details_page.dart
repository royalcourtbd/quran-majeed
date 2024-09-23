import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/core/utility/custom_donate_button.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/notification/widgets/notification_title_widget.dart';

class NotificationDetailsPage extends StatelessWidget {
  NotificationDetailsPage({
    super.key,
  });
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const NotificationTitleWidget(title: "Title", time: "1 mins ago"),
          gapH3,
          BuildDivider(
            theme: theme,
          ),
          gapH10,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: twentyPx,
            ),
            child: Column(
              children: [
                Html(
                  key: key,
                  data: "Notification Details",
                  onAnchorTap: (url, _, __) => openUrl(url: url),
                  onLinkTap: (url, _, __) => openUrl(url: url),
                  style: {
                    "body": Style(
                      margin: Margins.zero,
                      textAlign: TextAlign.justify,
                      padding: HtmlPaddings.zero,
                      fontSize: FontSize(fourteenPx),
                      lineHeight: const LineHeight(1.8),
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                  },
                ),
                SizedBox(height: fifteenPx),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomDonateButton(onTap: () {}, theme: theme),
    );
  }
}
