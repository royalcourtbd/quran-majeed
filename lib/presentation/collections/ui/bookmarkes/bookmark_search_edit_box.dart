import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/regex_patterns.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';

class BookmarkSearchEditBox extends StatelessWidget {
  const BookmarkSearchEditBox({
    super.key,
    required this.searchFieldController,
    required this.onFilterClicked,
    required this.themeData,
    required this.onChanged,
    required this.focusNode,
  });

  final TextEditingController searchFieldController;
  final VoidCallback onFilterClicked;
  final ThemeData themeData;
  final Function(String) onChanged;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? thirteenPx : tenPx),
      child: Row(
        key: const Key("bookmark_search_edit_box_row"),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Expanded(
            key: const Key("bookmark_search_edit_box_container"),
            child: SizedBox(
              height: isMobile ? fortyFivePx : twentyFivePx,
              child: UserInputField(
                key: const Key("bookmark_search_edit_box"),
                textEditingController: searchFieldController,
                prefixIconColor: context.color.subtitleColor,
                focusNode: focusNode,
                hintText: context.l10n.searchByFolderName,
                borderRadius: isMobile ? radius10 : radius5,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: twelvePx,
                    vertical: isMobile ? eightPx : fourPx),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                  FilteringTextInputFormatter.deny(RegexPatterns.onlyNumbers),
                ],
                onChanged: onChanged,
                onFieldSubmitted: (p0) {
                  focusNode.unfocus();
                },
              ),
            ),
          ),
          isMobile ? gapW15 : gapW5,
          InkWell(
            onTap: onFilterClicked,
            child: SizedBox(
              key: const Key("bookmark_search_edit_box_filter_button"),
              height: isMobile ? fortyTwoPx : twentyFivePx,
              width: isMobile ? 12.percentWidth : 8.percentWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: themeData.cardColor,
                  borderRadius: isMobile ? radius8 : radius5,
                ),
                child: Padding(
                  key: const Key("bookmark_search_edit_box_filter_button_icon"),
                  padding: EdgeInsets.all(isMobile ? tenPx : eightPx),
                  child: SvgImage(
                    SvgPath.icFilter,
                    width: twentyFourPx,
                    height: twentyFourPx,
                    color: context.color.subtitleColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
