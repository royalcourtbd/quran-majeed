import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/menu_list_item.dart';
import 'package:quran_majeed/presentation/common/custom_botom_sheet_container.dart';

class ShareAyahBottomSheet extends StatelessWidget {
  ShareAyahBottomSheet({
    super.key,
    required this.surahID,
    required this.ayahID,
    required this.listOfWordByWordEntity,
  });
  final int surahID;
  final int ayahID;
  final List<WordByWordEntity> listOfWordByWordEntity;
  final AyahPresenter _ayahPresenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomBottomSheetContainer(
      key: const Key('ShareAyahBottomSheet'),
      theme: theme,
      children: [
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icImageShare,
          title: 'Share Image(Screenshots)',
          onClicked: () async {
            // await showComingSoonMessage(context: context);
            _ayahPresenter.addUserMessage('Coming Soon!');
            // _ayahPresenter.onClickShareImageButton(context);
          },
        ),
        gapH8,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icShare2,
          title: 'Share This Ayah',
          onClicked: () async {
            await _ayahPresenter.shareSingleAyahText(
                surahID: surahID,
                ayahID: ayahID,
                listOfWordByWordEntity: listOfWordByWordEntity);
          },
        ),
        gapH8,
        MenuListItem(
          theme: theme,
          iconPath: SvgPath.icShare2,
          title: 'Share Multiple Ayah',
          onClicked: () async {
            // showComingSoonMessage(context: context);
            _ayahPresenter.addUserMessage('Coming Soon!');
            // _ayahPresenter.onClickMultipleAyahShareButton(context);
          },
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required int surahID,
    required int ayahID,
    required List<WordByWordEntity> listOfWordByWordEntity,
  }) async {
    final ShareAyahBottomSheet shareBottomBar = await Future.microtask(
      () => ShareAyahBottomSheet(
        surahID: surahID,
        ayahID: ayahID,
        listOfWordByWordEntity: listOfWordByWordEntity,
      ),
    );

    if (context.mounted) {
      await context.showBottomSheet<void>(shareBottomBar, context);
    }
  }
}
