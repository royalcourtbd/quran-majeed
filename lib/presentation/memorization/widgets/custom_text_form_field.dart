import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/text_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.folderNameEditingController,
    required this.hintText,
    required this.inputFormatters,
    this.focusNode,
  });
  final TextEditingController folderNameEditingController;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode? focusNode;

  //final TextEditingController folderNameEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      contextMenuBuilder: fixedLightContextMenu,
      controller: folderNameEditingController,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
      decoration: inputDecorateBottomSheet(
        context: context,
        hintText: hintText,
        borderRadius: radius10,
        contentPadding: EdgeInsets.symmetric(horizontal: fifteenPx),
      ),
    );
  }
}
