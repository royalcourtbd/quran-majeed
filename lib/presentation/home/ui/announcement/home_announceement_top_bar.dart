import 'package:flutter/material.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class HomeAnnouncementTopBar extends StatelessWidget {
  HomeAnnouncementTopBar({
    super.key,
    required this.headerText,
    required this.theme,
  });

  final String headerText;
  final ThemeData theme;
  final HomePresenter _homePresenter = locate<HomePresenter>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.percentWidth,
      padding: EdgeInsets.only(left: fifteenPx, right: tenPx),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(fifteenPx)),
        color: theme.primaryColor.withOpacity(.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RepaintBoundary(
            child: Row(
              children: [
                Icon(
                  Icons.notification_important,
                  color: context.color.primaryColor,
                ),
                gapW10,
                Text(
                  headerText,
                  maxLines: 3,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.color.primaryColor,
                    fontFamily: FontFamily.kalpurush,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _homePresenter.closeNoticeBox(),
            child: SizedBox(
              height: thirtyPx,
              width: thirtyPx,
              child: Icon(
                Icons.close,
                color: context.color.primaryColor.withOpacity(0.5),
                size: twentyPx,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
