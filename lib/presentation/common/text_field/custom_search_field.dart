import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.theme,
    required this.textEditingController,
    required this.hintText,
  });

  final ThemeData theme;
  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH1,
        Divider(color: theme.primaryColor.withOpacity(0.2), thickness: 1),
        TextFormField(
          controller: textEditingController,
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w400,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: tenPx,
              vertical: 16,
            ),

            hintText: hintText,
            fillColor: theme.colorScheme.secondary.withOpacity(0.5),
            filled: true,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: context.color.primaryColor,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                  left: fivePx, right: fivePx, top: tenPx, bottom: fivePx),
              child: SvgImage(
                SvgPath.icSearch,
                fit: BoxFit.scaleDown,
                color: context.color.primaryColor,
              ),
            ), // Icon on the left side
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
