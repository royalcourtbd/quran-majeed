import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/presentation/grammar/widget/search_icon.dart';

class ResponsiveSearchBar extends StatelessWidget {
  const ResponsiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: TextFormField(
        textAlign: TextAlign.right,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: theme.textTheme.titleSmall,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          suffixIcon: TextFieldIcon(
            theme: theme,
            svgPath: SvgPath.icSearch,
          ),
          hintText: 'Search',
          contentPadding: EdgeInsets.only(bottom: thirteenPx),
          hintStyle: theme.textTheme.bodySmall,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
