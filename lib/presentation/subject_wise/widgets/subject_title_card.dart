import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class SubjectTitleCard extends StatelessWidget {
  final ThemeData theme;
  final String subject;

  const SubjectTitleCard({
    super.key,
    required this.theme,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx),
      child: Container(
        width: double.infinity,
        padding: padding15,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacity(0.1),
          borderRadius: radius10,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Subject: ',
                style: textStyle?.copyWith(
                  color: context.color.primaryColor,
                ),
              ),
              TextSpan(
                text: subject,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
