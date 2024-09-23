import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/contact_us_model.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({
    super.key,
  });

  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        key: const Key('ContactUsPageCustomAppBar'),
        title: context.l10n.contactUs,
        theme: theme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoundedScaffoldBody(
              isColored: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sixteenPx),
                    Image.asset(
                      isDarkMode(context)
                          ? SvgPath.contactUsBannerDark
                          : SvgPath.contactUsBannerLight,
                      fit: BoxFit.cover,
                    ),
                    gapH20,
                    Text(
                      context.l10n.getInTouch,
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    gapH10,
                    Text(
                      context.l10n.getInTouchDec,
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w400, height: 1.7),
                    ),
                    gapH20,
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: contactList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: tenPx,
                        mainAxisSpacing: tenPx,
                        mainAxisExtent: seventyFivePx,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => contactList[index].onLinkClick?.call(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: radius10,
                              color: theme.primaryColor.withOpacity(0.1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    contactList[index].icon,
                                    width: 28.px,
                                    height: 28.px,
                                  ),
                                ),
                                gapH10,
                                Text(
                                  contactList[index].name,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
