import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/regex_patterns.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';

class NoteAyahSearchEditBox extends StatelessWidget {
  const NoteAyahSearchEditBox({super.key, required this.searchFieldController});

  final TextEditingController searchFieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key("note_ayah_search_edit_box"),
      padding: padding20,
      child: SizedBox(
        height: fortyFivePx,
        child: UserInputField(
          key: const Key("note_ayah_search_edit_box"),
          textEditingController: searchFieldController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
            FilteringTextInputFormatter.deny(RegexPatterns.onlyNumbers),
          ],
          hintText: "Search By Surah Name",
          borderRadius: radius10,
          contentPadding:
              EdgeInsets.symmetric(horizontal: twelvePx, vertical: eightPx),
          onFieldSubmitted: (p0) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
