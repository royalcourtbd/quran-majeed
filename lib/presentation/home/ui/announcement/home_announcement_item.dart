import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/presentation/home/ui/announcement/home_announceement_top_bar.dart';
import 'package:quran_majeed/presentation/home/ui/announcement/home_announcement_body.dart';
import 'package:quran_majeed/presentation/home/ui/notice/notice_dialog.dart';

class HomeAnnouncementItem extends StatelessWidget {
  const HomeAnnouncementItem({
    super.key,
    required this.theme,
     required this.promotionalMessage,
    required this.onClose,
  });

  final ThemeData theme;
  final PromotionalMessageEntity promotionalMessage;
  final void Function(PromotionalMessageEntity) onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTappedOnAnnouncement(context),
      child: SizedBox(
        height: 20.percentHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Wrap(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius15,
                  color: theme.scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeAnnouncementTopBar(
                      theme: theme,
                      headerText:promotionalMessage.headerText,
                    ),
                    HomeAnnouncementBody(
                      theme: theme, 
                      promotionalMessagePost: promotionalMessage.post,
                      onSeeMore: () => _onTappedOnAnnouncement(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTappedOnAnnouncement(BuildContext context) async {
     await NoticeDialog.show(
      notice: promotionalMessage,
      onClose: onClose,
      context: context,
    );
  }
}
