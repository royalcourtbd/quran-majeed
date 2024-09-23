import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';

class ReciterBottomNavigation extends StatelessWidget {
  const ReciterBottomNavigation({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: QuranScreen.width,
      padding: padding20,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Flexible(
              child: SubmitButton(
            title: context.l10n.done,
            theme: theme,
            buttonColor: context.color.primaryColor.withOpacity(0.12),
            textColor: context.color.primaryColor,
            onTap: () {
              context.navigatorPop();
            },
          )),
        ],
      ),
    );
  }
}
