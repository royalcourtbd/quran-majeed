import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/custom_radio_button.dart';

class CopyTypeWidget extends StatelessWidget {
  const CopyTypeWidget({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: sixPx),
      child: Column(
        children: [
          CustomRadioButton(
            title: "Normal Copy",
            value: CopyType.normalCopy.name,
            groupValue: CopyType.normalCopy.name,
            onChanged: (value) {},
            theme: theme,
          ),
          gapH5,
          CustomRadioButton(
            title: "Copy Only Translate",
            value: CopyType.translateCopy.name,
            groupValue: CopyType.normalCopy.name,
            onChanged: (value) {},
            theme: theme,
          ),
          gapH5,
          CustomRadioButton(
            title: "Copy Only Arabic",
            value: CopyType.arabicCopy.name,
            groupValue: CopyType.normalCopy.name,
            onChanged: (value) {},
            theme: theme,
          ),
        ],
      ),
    );
  }
}

enum CopyType { normalCopy, translateCopy, arabicCopy }
