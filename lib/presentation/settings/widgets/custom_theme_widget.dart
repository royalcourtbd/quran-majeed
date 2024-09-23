import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomThemeWidget extends StatelessWidget {
  final Color selectedColor;
  final bool isSelected;
  final String title;
  final Function()? onTap;
  const CustomThemeWidget({
    super.key,
    required this.selectedColor,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isMobile ? tenPx : fivePx),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: isMobile ? padding5 : padding2,
              alignment: Alignment.topRight,
              width: isMobile ? 15.percentWidth : 11.2.percentWidth,
              height: isMobile ? 20.percentWidth : 13.5.percentWidth,
              decoration: BoxDecoration(
                color: context.color.cardShade,
                borderRadius: isMobile ? radius10 : radius8,
                border: Border.all(
                    color: isSelected ? selectedColor : Colors.transparent,
                    width: 1.5),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: isMobile ? seventeenPx : twelvePx,
                    height: isMobile ? seventeenPx : twelvePx,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? selectedColor : Colors.transparent,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: isMobile ? tenPx : sevenPx,
                    height: isMobile ? tenPx : sevenPx,
                    decoration: BoxDecoration(
                      color: isSelected ? selectedColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            isMobile ? gapH8 : gapH5,
            Text(
              title,
              style: context.quranText.lableExtraSmall!.copyWith(
                  fontWeight: isMobile ? FontWeight.w400 : FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
