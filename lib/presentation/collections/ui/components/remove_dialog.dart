import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/action_button.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
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
      builder: (_) => RemoveDialog(
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
      elevation: 0,
      backgroundColor: isDarkMode(context) ? theme.cardColor : Colors.white,
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
                    SvgPath.icDelete,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
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
                      "${context.l10n.delete} $title",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: padding15,
                      child: Text(
                        context.l10n.youWillNotBeAbleToRecoverThis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: context.color.subtitleColor,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    gapH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          buttonText: context.l10n.cancel,
                          width: 130,
                          isFocused: false,
                          theme: theme,
                          color: context.color.subtitleColor,
                          onTap: () => context.navigatorPop<void>(),
                        ),
                        gapW15,
                        ActionButton(
                          buttonText: context.l10n.delete,
                          isError: true,
                          color: context.color.primaryColor,
                          width: 130,
                          theme: theme,
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
