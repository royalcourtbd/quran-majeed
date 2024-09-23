import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';

class CreatePlanButton extends StatelessWidget {
  final Function() onCreateButtonPressed;
  final ThemeData theme;

  const CreatePlanButton({
    super.key,
    required this.onCreateButtonPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: isMobile
          ? SubmitButton(
              theme: theme,
              title: "Create a Plan", // Localization
              onTap: onCreateButtonPressed,
              buttonColor: context.color.primaryColor,
              textColor: theme.textTheme.labelSmall?.color ??
                  Colors.black, // Fallback color
            )
          : SizedBox(
              height:
                  twentyFivePx, // Assuming 'twentyFivePx' is meant to be responsive
              width: 48.percentWidth,
              child: SubmitButton(
                theme: theme,
                title: "Create a Plan", // Localization
                onTap: onCreateButtonPressed,
                buttonColor: context.color.primaryColor,
                textColor: context.color.subtitleColor, // Fallback color
              ),
            ),
    );
  }
}
