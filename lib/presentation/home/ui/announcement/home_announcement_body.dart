import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

class HomeAnnouncementBody extends StatelessWidget {
  const HomeAnnouncementBody({
    super.key,
    required this.promotionalMessagePost,
    required this.onSeeMore,
    required this.theme,
  });

  final PromotionalMessagePost promotionalMessagePost;
  final VoidCallback onSeeMore;
  final ThemeData theme;

  final String promotionalMessage =
      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demons trate the older text commonder text commonly used to demonstrate the older text commonder text commonly used todemonstrate the older text commonly used todemonstrate the visual\\n  form of a document or ..";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: sixteenPx,
        right: sixteenPx,
        bottom: sixteenPx,
        top: eightPx,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox.shrink(
            key: const Key("load_image_beforehand"),
            child: CachedNetworkImage(
              imageUrl: promotionalMessagePost.headerImageUrl,
              errorWidget: (_, __, ___) => const SizedBox.shrink(),
              placeholder: (_, __) => const SizedBox.shrink(),
            ),
          ),
          Text(
            promotionalMessagePost.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              color: context.color.primaryColor,
              fontFamily: FontFamily.kalpurush,
            ),
          ),
          gapH4,
          GestureDetector(
            onTap: onSeeMore,
            child: RichText(
              maxLines: 3,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "${promotionalMessagePost.body.replaceAll("\\n", "... ").characters.take(_countCharacters(fontSize: fifteenPx))}... ",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      fontFamily: FontFamily.kalpurush,
                    ),
                  ),
                  TextSpan(
                    text: context.l10n.seeMore,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.color.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _countCharacters({
    required double fontSize,
  }) {
    final double charWidth = fontSize * 0.5;
    final int maxChars = (QuranScreen.height / charWidth).floor();
    return maxChars;
  }
}
