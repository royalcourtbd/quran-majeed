import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';

class DefaultReciterCard extends StatelessWidget {
  const DefaultReciterCard({
    super.key,
    required this.reciter,
    required this.theme,
    required this.reciterPresenter,
  });

  final Reciter reciter;
  final ThemeData theme;
  final ReciterPresenter reciterPresenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: fourteenPx),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio(
              value: reciter.id,
              groupValue: reciterPresenter.currentUiState.selectedReciterId,
              onChanged: (_) =>
                  reciterPresenter.selectReciter(reciter: reciter, index: 0),
              activeColor: context.color.primaryColor,
              fillColor: WidgetStateProperty.all(context.color.primaryColor),
            ),
          ),
          gapW8,
          Container(
            width: 12.percentWidth,
            height: 12.percentWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.color.primaryColor.withOpacity(0.3),
                width: 1.5,
              ),
              borderRadius: radius10,
              image: DecorationImage(
                image: AssetImage(reciterPresenter.getImagePath(reciter.name)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          gapW15,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reciter.name,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH3,
                Text(
                  'Default Reciter',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: context.color.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
