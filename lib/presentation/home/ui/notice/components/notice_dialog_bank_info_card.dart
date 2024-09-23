import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';
import 'package:quran_majeed/presentation/home/ui/notice/components/custom_richtext.dart';

class NoticeDialogBankInfoCard extends StatelessWidget {
  const NoticeDialogBankInfoCard({
    super.key,
    required this.onPressed,
    required this.bankInfo,
    required this.theme,
  });

  final VoidCallback onPressed;
  final PromotionalMessagePaymentBank bankInfo;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: QuranScreen.width,
        padding: EdgeInsets.symmetric(
          horizontal: sixteenPx,
          vertical: tenPx,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(twelvePx),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  "Bank Information",
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  SvgPath.icCopy,
                  width: eighteenPx,
                  height: eighteenPx,
                ),
              ],
            ),
            gapH15,
            CustomRichText(
              name: "AC Name: ",
              theme: theme,
              title: bankInfo.accountName,
            ),
            gapH3,
            CustomRichText(
              name: "Bank Name: ",
              theme: theme,
              title: bankInfo.bankName,
            ),
            gapH3,
            CustomRichText(
              name: "AC Number: ",
              theme: theme,
              title: bankInfo.accountNumber,
            ),
            gapH3,
            CustomRichText(
              name: "Branch: ",
              theme: theme,
              title: bankInfo.bankBranch,
            ),
            gapH3,
            CustomRichText(
              name: "Routing No: ",
              theme: theme,
              title: bankInfo.routingNumber,
            ),
            gapH3,
            CustomRichText(
              name: "Swift No: ",
              theme: theme,
              title: bankInfo.swiftCode,
            ),
          ],
        ),
      ),
    );
  }
}
