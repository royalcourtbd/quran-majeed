import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/custom_notice_dialog_button.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/notice_dialog_button.dart';

class BugReportPage extends StatelessWidget {
  BugReportPage({super.key});

  static const List<Color> _messengerColorGradients = [
    Color(0xff1D86FF),
    Color(0xff3056D9),
    Color(0xffDB30A1),
    Color(0xffFF7354),
  ];

  static const Color _gmailColor = Color(0xffEA4335);

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(
        theme: theme,
        title: context.l10n.reportABug,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoundedScaffoldBody(
              isColored: true,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: twentyPx, vertical: tenPx),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        isDarkMode(context)
                            ? SvgPath.reportBUgBannerDark
                            : SvgPath.reportBUgBannerLight,
                        fit: BoxFit.cover,
                      ),
                      gapH20,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.reportABug,
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: context.color.primaryColor,
                            ),
                          ),
                          gapH20,
                          Text(
                            context.l10n.bugReportDescription,
                            textAlign: TextAlign.justify,
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: fourteenPx,
                            ),
                          ),
                          gapH20,
                          CustomNoticeDialogButton(
                            theme: theme,
                            url: messengerUrl,
                            colors: _messengerColorGradients,
                            icon: SvgPath.icFbMes2,
                            title: "Chat With Us",
                            onTap: () => openUrl(
                              url: messengerUrl,
                              fallbackUrl: messengerUrl,
                            ),
                          ),
                          gapH5,
                          NoticeDialogButton(
                            theme: theme,
                            trailing: false,
                            color: _gmailColor,
                            opacity: .15,
                            icon: SvgPath.icGmail,
                            title: 'Write a Mail to Us',
                            actionType: ButtonActionType.send,
                            onPressed: sendEmail,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
