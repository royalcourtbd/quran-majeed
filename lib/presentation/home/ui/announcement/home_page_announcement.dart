import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/entities/notification/announcement_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/ui/announcement/home_announcement_item.dart';
import 'package:quran_majeed/presentation/home/ui/announcement/quran_carousel_slider.dart';

class HomePageAnnouncement extends StatelessWidget {
  const HomePageAnnouncement({
    super.key,
    required this.theme,
    required this.homePresenter,
    required this.announcement,
    required this.onClose,
  });

  final ThemeData theme;
  final AnnouncementEntity announcement;
  final HomePresenter homePresenter;
  final void Function(PromotionalMessageEntity) onClose;

  @override
  Widget build(BuildContext context) {
    final bool isAnnouncement = announcement.announcementType == AnnouncementType.promotionalMessage;
    final PromotionalMessageEntity message = announcement.promotionalMessage ?? PromotionalMessageEntity.empty();
    final List<AyahDatabaseTableData> ayahList = announcement.ayahList;
    return RepaintBoundary(
      key: const Key("announcement_repaint_boundary"),
      child: SizedBox(
        height: 20.percentHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: isAnnouncement
              ? HomeAnnouncementItem(
                  theme: theme,
                    promotionalMessage: message,
                  onClose: onClose,
                  
                )
              : QuranCarouselSlider(theme: theme,
                  ayahList: ayahList,
                  homePresenter: homePresenter,
                ),
        ),
      ),
    );
  }
}
