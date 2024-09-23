import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:quran_majeed/core/static/constants.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/share_screen_shot_button.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/store_button.dart';

class ShareScreenShotPopupDialog extends StatelessWidget {
  const ShareScreenShotPopupDialog({super.key});

  static Future<void> show({
    required BuildContext context,
  }) async {
    const popupDialog = ShareScreenShotPopupDialog(key: Key("PopupDialog"));
    if (context.mounted) {
      await showAnimatedDialog<void>(
        context: context,
        builder: (_) => popupDialog,
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: paddingH10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: QuranScreen.height * 0.7,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(SvgPath.imgShareQr),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: twentyPx),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  gapH10,
                  Text(
                    shareAppLink,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapH12,
                  Text(
                    appDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  gapH25,
                  Row(
                    children: [
                      StoreButton(
                        theme: theme,
                        iconPath: SvgPath.icPlayStore,
                        buttonLabel: playStore,
                        onPressed: () {},
                      ),
                      gapW16,
                      StoreButton(
                        theme: theme,
                        iconPath: SvgPath.icAppStore,
                        buttonLabel: appStore,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  gapH20,
                ],
              ),
            ),
          ),
          gapH15,
          ShareScreenShotButton(theme: theme, onPressed: () {}),
        ],
      ),
    );
  }
}
