import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/our_project_model.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/link_button.dart';

import 'package:url_launcher/url_launcher.dart';

class ProjectInfoCardItem extends StatelessWidget {
  const ProjectInfoCardItem({
    super.key,
    required this.ourProject,
  });

  final OurProjectModel ourProject;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: twentyPx,
            vertical: twentyFivePx,
          ),
          width: QuranScreen.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.color.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: radius10,
                    child: Image.asset(
                      ourProject.icon,
                      width: fortyPx,
                      height: fortyPx,
                    ),
                  ),
                  gapW15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ourProject.title,
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "IRD Foundation",
                        style: context.quranText.lableExtraSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.color.subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              gapH15,
              Text(
                ourProject.description,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: context.color.blackColor,
                ),
              ),
              gapH15,
              Row(
                children: [
                  if (ourProject.appLink != null) ...[
                    LinkButton(
                      text: context.l10n.downloadApp,
                      isDownload: true,
                      onTap: () => openUrl(
                        url: Platform.isIOS
                            ? "www.irdfoundation.com"
                            : ourProject.appLink,
                      ),
                    ),
                    gapW10,
                  ],
                  if (ourProject.website != null) ...[
                    LinkButton(
                      text: context.l10n.website,
                      onTap: () => launchUrl(
                        Uri.parse(ourProject.website!),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
