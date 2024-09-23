import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/model_class/musaf_data_model.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/musaf_quran_list.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';

class ChooseMusafModeBottomSheet extends StatelessWidget {
  ChooseMusafModeBottomSheet({super.key});

  final List<MusafDataModel> musafMode = [
    MusafDataModel(
      title: 'Translation Mode',
      isDownloaded: false,
    ),
    MusafDataModel(
      title: 'Text Musaf Mode',
      isDownloaded: false,
    ),
    MusafDataModel(
      title: 'Nurani/Kalkata Print Quran',
      isDownloaded: false,
    ),
    MusafDataModel(
      title: '15 Line Hafezi Quran',
      isDownloaded: true,
    ),
  ];

  static Future<void> show({
    required BuildContext context,
  }) async {
    final ChooseMusafModeBottomSheet chooseMusafModeBottomSheet =
        await Future.microtask(
      () => ChooseMusafModeBottomSheet(
        key: const Key("ChooseMusafModeBottomSheet"),
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(chooseMusafModeBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('ChooseMusafModeBottomSheet'),
      theme: theme,
      bottomSheetTitle: 'Select Musaf Mode',
      children: [
        MusafQuranList(musafMode: musafMode),
        gapH15,
        TwoWayActionButton(
          submitButtonTitle: 'Apply',
          cancelButtonTitle: 'Cancel',
          theme: theme,
        )
      ],
    );
  }
}
