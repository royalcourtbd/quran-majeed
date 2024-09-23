import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_color.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:quran_majeed/core/external_libs/simple_html_css/src/html_stylist.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/custom_subtitle.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/notice_dialog_bank_info_card.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/custom_notice_dialog_button.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/notice_dialog_button.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/notice_dialog_header_image.dart';

class NoticeDialog extends StatelessWidget {
  const NoticeDialog({
    super.key,
    required this.payload,
  });
  final PromotionalMessageEntity payload;

  @override
  Widget build(BuildContext context) {
    final PromotionalMessagePaymentBank paymentBank = payload.paymentBank;
    final PromotionalMessagePaymentMobile paymentMobile = payload.paymentMobile;
    final PromotionalMessageOtherContacts otherContacts = payload.otherContacts;
    final PromotionalMessagePost post = payload.post;
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: AlertDialog(
        insetPadding:
            EdgeInsets.symmetric(horizontal: fourteenPx, vertical: twentyPx),
        actionsPadding: EdgeInsets.symmetric(vertical: fivePx),
        contentPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          width: QuranScreen.width,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(twelvePx)),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: post.posterUrl.isNotEmpty
                  ? Container(
                      width: QuranScreen.width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(post.posterUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NoticeDialogHeaderImage(
                          theme: theme,
                          imageUrl: post.headerImageUrl,
                        ),
                        gapH15,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: context.color.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.kalpurush,
                                ),
                              ),
                              gapH12,
                              Builder(
                                key: ValueKey<String>(post.body),
                                builder: (context) {
                                  return HTML.toRichText(
                                    context,
                                    post.body.replaceAll("\\n", "<br><br>"),
                                    defaultTextStyle:
                                        theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.kalpurush,
                                    ),
                                  );
                                },
                              ),
                              if (paymentMobile.bKashPrimary.isNotEmpty ||
                                  paymentMobile.bKashSecondary.isNotEmpty ||
                                  paymentMobile.rocketPrimary.isNotEmpty ||
                                  paymentMobile.rocketSecondary.isNotEmpty ||
                                  paymentMobile.nagadPrimary.isNotEmpty ||
                                  paymentMobile.nagadSecondary.isNotEmpty ||
                                  paymentMobile.uPayPrimary.isNotEmpty ||
                                  paymentMobile.uPaySecondary.isNotEmpty ||
                                  paymentBank.showBankInfo)
                                Column(
                                  children: [
                                    gapH30,
                                    CustomSubtitle(
                                      theme: theme,
                                      text: "${context.l10n.donateNumbers}:",
                                    ),
                                    gapH15,
                                    if (paymentMobile.bKashPrimary.isNotEmpty)
                                      NoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${paymentMobile.bKashPrimary}bKashPrimary",
                                        ),
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icBkash,
                                        title: paymentMobile.bKashPrimary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.bKashPrimary,
                                          ),
                                          "bKash",
                                        ),
                                      ),
                                    if (paymentMobile.bKashSecondary.isNotEmpty)
                                      NoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${paymentMobile.bKashSecondary}bKashSecondary",
                                        ),
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icBkash,
                                        title: paymentMobile.bKashSecondary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.bKashSecondary,
                                          ),
                                          "bKash",
                                        ),
                                      ),
                                    if (paymentMobile.nagadPrimary.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icNagad,
                                        title: paymentMobile.nagadPrimary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.nagadPrimary,
                                          ),
                                          "Nagad",
                                        ),
                                      ),
                                    if (paymentMobile.nagadSecondary.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icNagad,
                                        title: paymentMobile.nagadSecondary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.nagadSecondary,
                                          ),
                                          "Nagad",
                                        ),
                                      ),
                                    if (paymentMobile.rocketPrimary.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icRocket,
                                        title: paymentMobile.rocketPrimary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.rocketPrimary,
                                          ),
                                          "Rocket",
                                        ),
                                      ),
                                    if (paymentMobile
                                        .rocketSecondary.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icRocket,
                                        title: paymentMobile.rocketSecondary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.rocketSecondary,
                                          ),
                                          "Rocket",
                                        ),
                                      ),
                                    if (paymentMobile.uPayPrimary.isNotEmpty)
                                      NoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${paymentMobile.uPayPrimary}uPayPrimary",
                                        ),
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icUpay,
                                        title: paymentMobile.uPayPrimary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.uPayPrimary,
                                          ),
                                          "Upay",
                                        ),
                                      ),
                                    if (paymentMobile.uPaySecondary.isNotEmpty)
                                      NoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${paymentMobile.uPaySecondary}uPaySecondary",
                                        ),
                                        theme: theme,
                                        color: QuranColor.carrotOrange,
                                        icon: SvgPath.icUpay,
                                        title: paymentMobile.uPaySecondary,
                                        actionType: ButtonActionType.copy,
                                        onPressed: () => _copyNoticeItem(
                                          _extractNumbers(
                                            paymentMobile.uPaySecondary,
                                          ),
                                          "Upay",
                                        ),
                                      ),
                                    if (paymentBank.showBankInfo)
                                      NoticeDialogBankInfoCard(
                                        key: ValueKey<
                                            PromotionalMessagePaymentBank>(
                                          paymentBank,
                                        ),
                                        theme: theme,
                                        bankInfo: paymentBank,
                                        onPressed: () => _copyNoticeItem(
                                          '''AC Name: ${paymentBank.accountName}\nBank Name: ${paymentBank.bankName}\nAC Number: ${paymentBank.accountNumber}\nBranch: ${paymentBank.bankBranch}\nRouting No: ${paymentBank.routingNumber}\nSwift No: ${paymentBank.swiftCode}''',
                                          "Bank Info",
                                        ),
                                      ),
                                  ],
                                ),
                              if (otherContacts.email.isNotEmpty ||
                                  otherContacts.facebookPageUrl.isNotEmpty ||
                                  otherContacts.facebookGroupUrl.isNotEmpty ||
                                  payload.socialMedia.messengerButtonUrl
                                      .isNotEmpty ||
                                  payload.socialMedia.telegramButtonUrl
                                      .isNotEmpty ||
                                  payload.socialMedia.whatsappButtonUrl
                                      .isNotEmpty ||
                                  payload
                                      .additionalButton.buttonText.isNotEmpty ||
                                  payload.additionalButton.buttonUrl.isNotEmpty)
                                Column(
                                  children: [
                                    gapH20,
                                    CustomSubtitle(
                                      text: context.l10n.contactUs,
                                      theme: theme,
                                    ),
                                    gapH15,
                                    if (otherContacts.email.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: Colors.transparent,
                                        icon: SvgPath.icGmail,
                                        title: otherContacts.email,
                                        actionType: ButtonActionType.send,
                                        onPressed: () => sendEmail(
                                          email: otherContacts.email,
                                        ),
                                      ),
                                    if (otherContacts
                                        .facebookPageUrl.isNotEmpty)
                                      NoticeDialogButton(
                                        theme: theme,
                                        color: Colors.transparent,
                                        icon: SvgPath.icFb,
                                        title: otherContacts.facebookPageUrl,
                                        actionType: ButtonActionType.send,
                                        onPressed: () => openUrl(
                                          url: otherContacts.facebookPageUrl,
                                          fallbackUrl: facebookPageUrl,
                                        ),
                                      ),
                                    gapH20,
                                    if (payload.socialMedia.messengerButtonUrl
                                        .isNotEmpty)
                                      CustomNoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${payload.socialMedia.messengerButtonUrl}messengerButtonUrl",
                                        ),
                                        theme: theme,
                                        url: payload
                                            .socialMedia.messengerButtonUrl,
                                        colors: QuranColor.buttonColorGradients,
                                        title: payload
                                            .socialMedia.messengerButtonTitle,
                                        icon: SvgPath.icFbSms,
                                        onTap: () => openUrl(
                                          url: payload
                                              .socialMedia.messengerButtonUrl,
                                          fallbackUrl: messengerUrl,
                                        ),
                                      ),
                                    if (payload.socialMedia.telegramButtonUrl
                                        .isNotEmpty)
                                      CustomNoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${payload.socialMedia.telegramButtonUrl}telegramButtonUrl",
                                        ),
                                        theme: theme,
                                        url: payload
                                            .socialMedia.telegramButtonUrl,
                                        colors: const [
                                          QuranColor.telegramColor
                                        ],
                                        icon: SvgPath.icTelegram,
                                        title: payload
                                            .socialMedia.telegramButtonTitle,
                                      ),
                                    if (payload.socialMedia.whatsappButtonUrl
                                        .isNotEmpty)
                                      CustomNoticeDialogButton(
                                        key: ValueKey<String>(
                                          payload.socialMedia.whatsappButtonUrl,
                                        ),
                                        theme: theme,
                                        url: payload
                                            .socialMedia.whatsappButtonUrl,
                                        colors: const [
                                          QuranColor.whatsAppColor
                                        ],
                                        icon: SvgPath.icWhatsApp,
                                        title: payload
                                            .socialMedia.whatsappButtonTitle,
                                      ),
                                    if (otherContacts
                                        .facebookGroupUrl.isNotEmpty)
                                      CustomNoticeDialogButton(
                                        key: ValueKey<String>(
                                          "${otherContacts.facebookGroupUrl}facebookGroupUrl",
                                        ),
                                        theme: theme,
                                        url: otherContacts.facebookGroupUrl,
                                        colors:
                                            QuranColor.facebookColorGradients,
                                        icon: SvgPath.icFb2,
                                        title: "Join our Facebook Group",
                                        onTap: () => openUrl(
                                          url: otherContacts.facebookGroupUrl,
                                          fallbackUrl: facebookGroupUrl,
                                        ),
                                      ),
                                  ],
                                ),
                              Visibility(
                                visible: payload.additionalButton.buttonText
                                        .isNotEmpty &&
                                    payload
                                        .additionalButton.buttonUrl.isNotEmpty,
                                child: CustomNoticeDialogButton(
                                  key: ValueKey<
                                      PromotionalMessageAdditionalButton>(
                                    payload.additionalButton,
                                  ),
                                  theme: theme,
                                  url: payload.additionalButton.buttonUrl,
                                  colors: [
                                    payload.additionalButton.buttonColor,
                                  ],
                                  icon: SvgPath.icKabah,
                                  title: payload.additionalButton.buttonText,
                                  onTap: () =>
                                      _onClickAdditionalButton(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: () => context.navigatorPop<bool>(result: true),
            child: Text(
              context.l10n.closeNotice,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copyNoticeItem(
    String item,
    String itemName,
  ) async {
    await copyText(text: item);
    await showMessage(message: "$itemName Copied");
  }

  String _extractNumbers(String text) {
    final RegExp regex = RegExp(r'\d+');
    final Iterable<RegExpMatch> matches = regex.allMatches(text);
    final List<String?> numbersList =
        matches.map((match) => match.group(0)).toList();
    final String numbers = numbersList.join();
    return numbers;
  }

//TODO : Implement this method
  Future<void> _onClickAdditionalButton(BuildContext context) async {
    // final String buttonUrl = payload.additionalButton.buttonUrl;
    // final bool isUrl = buttonUrl.contains("http");
    // final bool isEmail = buttonUrl.contains("@");

    // if (isUrl) {
    //   await openUrl(url: buttonUrl);
    // } else if (isEmail) {
    //   await sendEmail(email: buttonUrl);
    // } else {
    //   context.navigatorPop<bool>(result: true);
    // }
  }

  static Future<void> show({
    required BuildContext context,
    required PromotionalMessageEntity notice,
    required void Function(PromotionalMessageEntity) onClose,
  }) async {
    final bool? isClosed = await showAnimatedDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => NoticeDialog(
        payload: notice,
      ),
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
    );
    if (isClosed ?? false) onClose(notice);
  }
}
