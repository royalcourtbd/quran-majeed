import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/regex_patterns.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class MemorizationSearchWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  const MemorizationSearchWidget(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: isMobile ? 40.px : 25.px,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? twentyPx : tenPx),
      padding: EdgeInsets.symmetric(vertical: 0.px),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        //contextMenuBuilder: fixedLightContextMenu,

        textAlignVertical: TextAlignVertical.center,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        textAlign: TextAlign.left,
        controller: textEditingController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(40),
          FilteringTextInputFormatter.deny(RegexPatterns.onlyNumbers),
        ],
        decoration: InputDecoration(
          contentPadding: padding4,
          filled: true,
          hintText: hintText,
          fillColor: context.color.primaryColor.withOpacity(0.12),
          hintStyle: theme.textTheme.bodySmall!.copyWith(
            color: context.color.primaryColor,
          ),
          enabledBorder: _determineFormFieldRadius(),
          border: _determineFormFieldRadius(),
          disabledBorder: _determineFormFieldRadius(),
          focusedBorder: _determineFormFieldRadius(),
          prefixIcon: Padding(
            padding: isMobile ? padding12 : padding8,
            child: SvgPicture.asset(
              SvgPath.icSearch,
              // height: twentyPx,
              // width: twentyPx,
              colorFilter: buildColorFilterToChangeColor(
                context.color.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder _determineFormFieldRadius() => _borderRadius();

OutlineInputBorder _borderRadius() {
  return OutlineInputBorder(
    borderRadius: isMobile ? radius8 : radius4,
    borderSide: BorderSide.none,
  );
}
