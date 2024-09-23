import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/text_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class UserInputField extends StatelessWidget {
  const UserInputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.onChanged,
    this.borderRadius,
    this.prefixIconPath,
    this.prefixIconColor,
    this.inputFormatters,
    this.contentPadding,
    this.onFieldSubmitted,
    this.isError = false,
    this.errorBorderColor,
    this.focusNode,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final BorderRadius? borderRadius;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? prefixIconPath;
  final Color? prefixIconColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool isError;
  final Color? errorBorderColor;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
      style: theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w400,
      ),
      focusNode: focusNode,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      cursorColor: context.color.primaryColor,
      contextMenuBuilder: fixedLightContextMenu,
      controller: textEditingController,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      decoration: inputDecorateBottomSheet(
        context: context,
        hintText: hintText,
        contentPadding: contentPadding ?? padding5,
        prefixIconColor: prefixIconColor ?? context.color.primaryColor,
        prefixIconPath: prefixIconPath ?? SvgPath.icSearch,
        borderRadius: borderRadius ?? radius5,
        borderColor: isError ? (errorBorderColor ?? Colors.red) : null,
      ),
    );
  }
}
