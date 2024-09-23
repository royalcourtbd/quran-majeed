import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/custom_donate_button.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';

class InfoPage extends StatelessWidget {
  InfoPage({
    super.key,
    required this.information,
    required this.title,
    this.coverPhoto,
    this.child,
    this.padding,
    this.showDonationButton = false,
  });

  final String information;
  final String title;
  final String? coverPhoto;
  final Widget? child;
  final EdgeInsets? padding;
  final bool showDonationButton;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        title: title,
        theme: theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              isColored: true,
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      if (coverPhoto != null)
                        Container(
                          padding: EdgeInsets.only(top: fourteenPx),
                          width: 92.percentWidth,
                          child: Image.asset(
                            "assets/images/non_svg/${isDarkMode(context) ? '${coverPhoto}_night' : coverPhoto}.png",
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: twentyPx),
                        child: Column(
                          children: [
                            Html(
                              key: key,
                              data: information,
                              onAnchorTap: (url, _, __) => openUrl(url: url),
                              onLinkTap: (url, _, __) => openUrl(url: url),
                              style: {
                                "body": Style(
                                  margin: Margins.zero,
                                  textAlign: TextAlign.left,
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(fourteenPx),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: const LineHeight(1.4),
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .color,
                                ),
                              },
                            ),
                            if (child != null)
                              Padding(
                                padding: EdgeInsets.only(top: sixteenPx),
                                child: child ?? Container(),
                              ),
                            gapH15,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: showDonationButton
          ? CustomDonateButton(
              onTap: () =>
                  openUrl(url: "https://irdfoundation.com/sadaqa-jaria"),
              theme: theme,
            )
          : const SizedBox.shrink(),
    );
  }
}
