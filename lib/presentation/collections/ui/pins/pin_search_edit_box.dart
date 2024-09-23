import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/regex_patterns.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';

class PinSearchEditBox extends StatelessWidget {
  const PinSearchEditBox({
    super.key,
    required this.editingController,
    required this.onFilterClicked,
    required this.theme,
  });

  final TextEditingController editingController;
  final VoidCallback onFilterClicked;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? thirteenPx : tenPx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: isMobile ? fortyFivePx : twentyFivePx,
              child: UserInputField(
                key: const Key("bookmark_search_edit_box"),
                textEditingController: editingController,
                hintText: "Search By Pin Name",
                borderRadius: isMobile ? radius10 : radius5,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: twelvePx,
                    vertical: isMobile ? eightPx : fourPx),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                  FilteringTextInputFormatter.deny(RegexPatterns.onlyNumbers),
                ],
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          isMobile ? gapW15 : gapW5,
          InkWell(
            onTap: onFilterClicked,
            child: SizedBox(
              height: isMobile ? fortyTwoPx : twentyFivePx,
              width: isMobile ? 12.percentWidth : 8.percentWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.color.primaryColor.withOpacity(0.12),
                  borderRadius: isMobile ? radius8 : radius5,
                ),
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? tenPx : eightPx),
                  child: SvgImage(
                    SvgPath.icFilter,
                    color: theme.textTheme.displayLarge!.color,
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
