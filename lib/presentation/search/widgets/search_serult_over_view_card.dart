import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SearchResultOverViewCard extends StatelessWidget {
  const SearchResultOverViewCard({
    super.key,
    required this.query,
    required this.theme,
  });

  final String query;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: tenPx, horizontal: twelvePx),
      width: QuranScreen.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tenPx),
      ),
      child: Row(
        children: [
          SvgImage(
            SvgPath.icWeb2,
            width: twentyFourPx,
            height: twentyFourPx,
            color: context.color.primaryColor,
          ),
          gapW12,
          Flexible(
            child: RichText(
              maxLines: 3,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Your Searched For",
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.color.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ( ${query.trim()} )',
                    style: theme.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w600,
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
}
