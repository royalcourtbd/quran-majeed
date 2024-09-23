import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/custom_range_slider.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/share_ayah_language_selection_list.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class MultipleAyahShareBottomSheet extends StatelessWidget {
  const MultipleAyahShareBottomSheet({super.key});
  // final AyahPresenter _ayahPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('MultipleAyahShareBottomSheet'),
      theme: theme,
      bottomSheetTitle: 'Multiple Ayah Share',
      children: [
        HeaderTitle(
          title: "Total Selected Ayah : 3",
          theme: theme,
        ),
        SizedBox(
          height: fiftyPx,
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
            "Maximum 7 ayah can be shared here",
            style: theme.textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.color.primaryColor.withOpacity(0.5),
            ),
          ),
        ),
        gapH25,
        ShareAyahLanguageSelectionList(
          theme: theme,
        ),
        gapH15,
        TwoWayActionButton(
          submitButtonTitle: 'Share',
          cancelButtonTitle: 'Copy',
          onCancelButtonTap: () {},
          onSubmitButtonTap: () {},
          theme: theme,
        )
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
  }) async {
    final MultipleAyahShareBottomSheet multipleAyahCopyBottomSheet =
        await Future.microtask(
      () => const MultipleAyahShareBottomSheet(),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(multipleAyahCopyBottomSheet, context);
    }
  }
}
