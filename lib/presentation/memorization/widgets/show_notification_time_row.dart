import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';

class ShowNotificationTimeRow extends StatelessWidget {
  const ShowNotificationTimeRow({
    super.key,
    required this.theme,
    required this.presenter,
  });

  final ThemeData theme;
  final MemorizationPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final Color scrimColor = context.color.primaryColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MenuListItem(
            theme: theme,
            iconPath: SvgPath.icTimer,
            title: 'Notification Time',
            onClicked: () async {
              // await _onClickEdit(context);
            },
          ),
        ),
        InkWell(
          onTap: () {
            onNotificationMenuTapped(
              context: context,
              currentDefault: const TimeOfDay(hour: 17, minute: 0),
              presenter: presenter,
            );
          },
          child: Container(
            width: 25.percentWidth,
            padding: EdgeInsets.symmetric(
              horizontal: tenPx,
              vertical: fivePx,
            ),
            decoration: BoxDecoration(
              color: scrimColor.withOpacity(0.1),
              borderRadius: radius5,
              border: Border.all(
                color: scrimColor.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '5:00 PM',
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: scrimColor,
                  ),
                ),
                // const Spacer(),
                SvgPicture.asset(
                  SvgPath.icArrowDownOutline,
                  height: twentyPx,
                  colorFilter: buildColorFilterToChangeColor(scrimColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
