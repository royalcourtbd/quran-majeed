import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';

class TwoWayActionButton extends StatelessWidget {
  const TwoWayActionButton({
    super.key,
    this.svgPictureForOkButton,
    this.svgPictureForCancelButton,
    required this.submitButtonTitle,
    required this.cancelButtonTitle,
    required this.theme,
    this.onSubmitButtonTap,
    this.onCancelButtonTap,
    this.submitButtonBgColor,
    this.submitButtonTextColor,
    this.cancelButtonBgColor,
    this.cancelButtonTextColor,
  });

  final Widget? svgPictureForOkButton;
  final Widget? svgPictureForCancelButton;
  final String submitButtonTitle;
  final String cancelButtonTitle;
  final Function()? onSubmitButtonTap;
  final Function()? onCancelButtonTap;
  final Color? submitButtonBgColor;
  final Color? submitButtonTextColor;
  final Color? cancelButtonBgColor;
  final Color? cancelButtonTextColor;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SubmitButton(
            theme: theme,
            svgPicture: svgPictureForCancelButton,
            title: cancelButtonTitle,
            onTap: onCancelButtonTap,
            buttonColor: cancelButtonBgColor ?? context.color.cardShade,
            textColor: cancelButtonTextColor ?? context.color.primaryColor,
          ),
        ),
        gapW15,
        Flexible(
          child: SubmitButton(
            theme: theme,
            svgPicture: svgPictureForOkButton,
            title: submitButtonTitle,
            onTap: onSubmitButtonTap,
            buttonColor: submitButtonBgColor ?? context.color.primaryColor,
            textColor: submitButtonTextColor ?? context.color.blackColor,
          ),
        ),
      ],
    );
  }
}
