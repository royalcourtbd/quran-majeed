import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/memorization/widgets/create_plan_button.dart';

class NoMemorizeWidget extends StatelessWidget {
  final VoidCallback onCreateButtonPressed;

  const NoMemorizeWidget({super.key, required this.onCreateButtonPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Efficient use of theme

    return Padding(
      padding: padding20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // Use Expanded to allow the Text widget to be centered within the available space
            child: Center(
              child: Text(
                "You don’t have any memorization plan", // Localization
                textAlign: TextAlign.center, // Center text if needed
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.color.primaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          CreatePlanButton(
            onCreateButtonPressed: onCreateButtonPressed,
            theme: theme,
          ),
        ],
      ),
    );
  }
}
