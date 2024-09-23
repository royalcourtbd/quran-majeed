import 'package:flutter/material.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/upload_theme_widget.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/memorization/widgets/header_title.dart';

class ShareImageBottomSheet extends StatelessWidget {
  const ShareImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      theme: theme,
      key: const Key('ShareImageBottomSheet'),
      bottomSheetTitle: 'Share Image',
      children: [
        HeaderTitle(title: 'Choose Theme', theme: theme),
        gapH12,
        GridView.builder(
          key: const Key('GridViewBuilder'),
          itemCount: 4, // Reduced itemCount from 4 to 3
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: twelvePx,
            mainAxisSpacing: twelvePx,
            //mainAxisExtent: 100,
          ),
          itemBuilder: (context, index) {
            return UploadThemeWidget(
              index: index,
              theme: theme,
            );
          },
        ),
        gapH25,
        TwoWayActionButton(
          submitButtonTitle: 'Share',
          cancelButtonTitle: 'Download',
          theme: theme,
        )
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
  }) async {
    final ShareImageBottomSheet shareImageBottomSheet = await Future.microtask(
      () => const ShareImageBottomSheet(),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(shareImageBottomSheet, context);
    }
  }
}
