import 'package:flutter/material.dart';

import 'package:quran_majeed/presentation/ayah_detail/widgets/custom_check_box_list_tile.dart';

class ShareAyahLanguageSelectionList extends StatelessWidget {
  const ShareAyahLanguageSelectionList({
    super.key,
    required this.theme,
  });
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCheckBoxListTile(
          title: "Arabic",
          value: false,
          onChanged: (value) {},
          theme: theme,
        ),
        CustomCheckBoxListTile(
          title: "Bengali - Bayan Foundation",
          value: true,
          onChanged: (value) {},
          theme: theme,
        ),
        CustomCheckBoxListTile(
          title: "English - Sahih International",
          value: false,
          theme: theme,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
