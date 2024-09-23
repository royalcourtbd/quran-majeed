import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';

class QariNameSection extends StatelessWidget {
  final ThemeData theme;
  final Reciter reciter;
  final ReciterPresenter reciterPresenter;

  const QariNameSection({
    super.key,
    required this.reciter,
    required this.theme,
    required this.reciterPresenter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 25.percentWidth,
          height: 25.percentWidth,
          decoration: BoxDecoration(
            borderRadius: radius15,
            image: DecorationImage(
              image: AssetImage(
                reciterPresenter.getImagePath(reciter.name),
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: context.color.primaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
        ),
        gapW15,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reciter.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              gapH10,
              Text(
                '114 Surah Audio Available For Download',
                style: theme.textTheme.labelSmall!.copyWith(
                  color: context.color.subtitleColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
