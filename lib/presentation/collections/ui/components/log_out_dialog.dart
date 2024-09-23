import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/action_button.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
    required this.title,
    required this.onRemove,
  });

  final String title;
  final Future<void> Function() onRemove;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Future<void> Function() onRemove,
  }) async {
    await showAnimatedDialog<void>(
      context: context,
      builder: (_) => LogOutDialog(
        onRemove: onRemove,
        title: title,
      ),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: twentyPx),
      backgroundColor: isDarkMode(context) ? theme.cardColor : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: radius20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        height: 80.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: QuranScreen.width,
                  height: 60.percentWidth,
                  child: SvgPicture.asset(
                    SvgPath.dicBG,
                    width: QuranScreen.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: twentyPx),
                  child: SvgPicture.asset(
                    SvgPath.dicLogOut,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
                    colorFilter: buildColorFilter(context.color.primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: padding15,
                      child: Text(
                        context.l10n.logOutMessage,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: context.color.subtitleColor,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          buttonText: 'Cancel',
                          width: 130.px,
                          isFocused: false,
                          onTap: () => context.navigatorPop<void>(),
                          color: context.color.subtitleColor,
                          theme: theme,
                        ),
                        gapW15,
                        ActionButton(
                          buttonText: 'Confirm',
                          theme: theme,
                          width: 130.px,
                          color: context.color.primaryColor,
                          onTap: () async {
                            await onRemove();
                            if (context.mounted) context.navigatorPop<void>();
                          },
                        ),
                      ],
                    ),
                    gapH20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
