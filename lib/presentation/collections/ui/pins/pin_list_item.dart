import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
// import 'package:quran_majeed/domain/entities/pin_entity.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/more_pin_option_bottom_sheet.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';

class PinListItem extends StatelessWidget {
  final dynamic pin;
  const PinListItem({
    super.key,
    required this.pin,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: OnTapWidget(
        theme: theme,
        onTap: () => log('object'),
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: twelvePx, horizontal: twentyPx),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: padding12,
                decoration: BoxDecoration(
                  color: pin.color.withOpacity(.1),
                  borderRadius: radius10,
                ),
                child: SvgPicture.asset(
                  SvgPath.icPin,
                  colorFilter: buildColorFilterToChangeColor(pin.color),
                ),
              ),
              gapW15,
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sixtySixPercentWidth,
                      child: Text(
                        pin.name,
                        overflow: TextOverflow.clip,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    gapH4,
                    Text(
                      pin.shortInfo,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !pin.name.contains("Favourites"),
                child: InkWell(
                  onTap: () => MorePinOptionBottomSheet.show(
                    pin: pin,
                    context: context,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: padding10,
                    child: SvgPicture.asset(
                      SvgPath.icMoreVert,
                      colorFilter: buildColorFilterToChangeColor(
                        theme.textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
