import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
  });

  static Future<void> show(
    BuildContext context,
  ) async {
    await showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const UpdateDialog(),
      barrierColor: Colors.black.withOpacity(0.5),
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: fourteenPx, vertical: twentyPx),
      actionsPadding: EdgeInsets.symmetric(vertical: fivePx),
      contentPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: theme.scaffoldBackgroundColor,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tenPx),
        ),
        width: QuranScreen.width,
        height: 85.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: QuranScreen.width,
                  height: 65.percentWidth,
                  child: SvgPicture.asset(
                    SvgPath.dicBG,
                    fit: BoxFit.fill,
                    width: QuranScreen.width,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: fifteenPx),
                  child: SvgPicture.asset(
                    SvgPath.icAboutUs,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
                    colorFilter: buildColorFilterToChangeColor(
                        context.color.primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: padding20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update Your App',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapH15,
                      SizedBox(
                        width: QuranScreen.width,
                        height: 20.percentWidth,
                        child: Html(
                          data:
                              "The Quran Majeed app has received a major update. Update the app now to enjoy new features and an excellent user experience.",
                          style: {
                            "body": Style(
                              textAlign: TextAlign.center,
                              fontFamily: FontFamily.inter,
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              fontSize: FontSize(thirteenPx),
                              lineHeight: const LineHeight(1.8),
                              color: theme.textTheme.displayMedium!.color,
                            ),
                          },
                        ),
                      ),
                      gapH15,
                      SubmitButton(
                        title: 'Update',
                        theme: theme,
                        onTap: () {},
                        buttonColor: context.color.primaryColor,
                        textColor: context.color.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
