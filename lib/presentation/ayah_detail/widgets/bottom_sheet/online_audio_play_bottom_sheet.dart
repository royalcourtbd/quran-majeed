import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';

class OnlineAudioPlayBottomSheet extends StatelessWidget {
  OnlineAudioPlayBottomSheet({super.key});

  static Future<void> show({
    required BuildContext context,
  }) async {
    final OnlineAudioPlayBottomSheet onlineAudioPlayBottomSheet =
        await Future.microtask(
      () => OnlineAudioPlayBottomSheet(
        key: const Key("OnlineAudioPlayBottomSheet"),
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(onlineAudioPlayBottomSheet, context);
    }
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('OnlineAudioPlayBottomSheet'),
      theme: theme,
      bottomSheetTitle: 'Select Reciter For Online Stream',
      children: [
        gapH15,
        SizedBox(
          height: fortyFivePx,
          child: UserInputField(
            textEditingController: textEditingController,
            hintText: 'Search By Reciter Name',
            borderRadius: radius10,
          ),
        ),
        gapH20,
        SectionHeader(title: 'Available Reciters (50)', theme: theme),
        gapH20,
        ListView.builder(
          itemCount: 50,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: twentyPx),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio(
                      value: index,
                      groupValue: 0,
                      fillColor: index == 0
                          ? WidgetStateProperty.all(context.color.primaryColor)
                          : WidgetStateProperty.all(
                              context.color.primaryColor.withOpacity(0.38)),
                      onChanged: (value) {},
                    ),
                  ),
                  gapW8,
                  Container(
                    width: 12.percentWidth,
                    height: 12.percentWidth,
                    decoration: BoxDecoration(
                      color: context.color.primaryColor.withOpacity(0.05),
                      border: Border.all(
                        color: context.color.primaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                      borderRadius: radius10,
                    ),
                    child: ClipRRect(
                      borderRadius: radius10,
                      child: Image.asset(
                        SvgPath.imgMisharyRashed,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  gapW10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mishary Rashid Alafasy',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH5,
                      Text(
                        '1 | 114 Surah Downloaded',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.color.primaryColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
