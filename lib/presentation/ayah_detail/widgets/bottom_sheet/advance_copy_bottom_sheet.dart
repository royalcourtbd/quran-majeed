import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/copy_type_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/custom_range_slider.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class AdvanceCopyBottomSheet extends StatelessWidget {
  const AdvanceCopyBottomSheet({super.key, required this.theme});
  final ThemeData theme;

  static Future<void> show({
    required BuildContext context,
    required ThemeData theme,
  }) async {
    final AdvanceCopyBottomSheet advanceCopyBottomSheet =
        await Future.microtask(
      () => AdvanceCopyBottomSheet(
        key: const Key("AdvanceCopyBottomSheet"),
        theme: theme,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(advanceCopyBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      theme: theme,
      key: const Key('AdvanceCopyBottomSheet'),
      bottomSheetTitle: 'Al Fatihah',
      showPadding: false,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: Column(
            children: [
              HeaderTitle(
                title: "Total Selected Ayah : 3",
                theme: theme,
              ),
              SizedBox(
                height: sixtyPx,
                child: CustomRangeSlider(
                  minVal: 1,
                  maxVal: 7,
                  onDragging: (index, lowerValue, upperValue) {},
                  theme: theme,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Maximum 7 ayah can be copied here",
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.color.primaryColor.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        gapH15,
        CopyTypeWidget(
          theme: theme,
        ),
        gapH15,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: TwoWayActionButton(
            submitButtonTitle: 'Copy Ayah',
            cancelButtonTitle: 'Cancel',
            onCancelButtonTap: () => context.navigatorPop<void>(),
            onSubmitButtonTap: () {},
            theme: theme,
          ),
        ),
        gapH20,
      ],
    );
  }
}
