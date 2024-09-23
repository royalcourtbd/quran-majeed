import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomHeaderSectionWidget extends StatelessWidget {
  const CustomHeaderSectionWidget({
    super.key,
    this.title,
    required this.theme,
    required this.isDuaPage,
  });
  final String? title; //
  final ThemeData theme;
  final bool isDuaPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: QuranColor.ecruWhite,
        borderRadius: radius5,
      ),
      child: Row(
        children: [
          SvgImage(
            SvgPath.icBook,
            height: eighteenPx,
            width: eighteenPx,
            color: context.color.primaryColor,
          ),
          gapW10,
          Flexible(
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  _textSpan(
                    isDuaPage ? 'Section : ' : 'Subject : ',
                    theme.textTheme.bodyMedium!,
                    context.color.primaryColor,
                  ),
                  _textSpan(
                    title ?? 'Unknown',
                    theme.textTheme.bodyMedium!,
                    null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _textSpan(String text, TextStyle style, Color? color) {
    return TextSpan(
      text: text,
      style: style.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: thirteenPx,
        color: color,
      ),
    );
  }
}
