import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_container.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';
import 'package:quran_majeed/presentation/subject_wise/widgets/subject_title_card.dart';

class ViewSubjectWisePage extends StatelessWidget {
  ViewSubjectWisePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final AyahPresenter _ayahPresenter = locate();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: MiniSettingsDrawer(),
      appBar: CustomAppBar(
        theme: theme,
        title: 'Subjectwise Quran',
        isRoot: false,
        actions: [
          AppbarActionIcon(
            onIconTap: () => scaffoldKey.currentState!.openEndDrawer(),
            svgPath: SvgPath.icSettings,
            theme: theme,
          ),
          gapW8,
        ],
      ),
      body: Column(
        children: [
          gapH20,
          SubjectTitleCard(theme: theme, subject: 'Aaron'),
          gapH20,
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, ayahIndex) {
                return AyahContainer(
                  isFromSpecificPage: false,
                  ayahTopRowTitle: 'Al-Fatihah 1:1',
                  index: ayahIndex,
                  surahID: 1,
                  ayahNumber: ayahIndex + 1,
                  wordData: listOfData,
                  onClickMore: () {},
                  ayahPresenter: _ayahPresenter,
                  theme: theme,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

///SubjectWise function kora hole ei code gulo delete kore dite hobe
List<WordByWordEntity> listOfData = [
  const WordByWordEntity(
    ayah: 1,
    word: 1,
    audio: 'audio',
    bn: 'আল্হামদুলিল্লাহ',
    de: 'Alhamdulillah',
    en: 'Praise be to Allah',
    hijb: '1',
    juz: 1,
    indo: 'Segala puji bagi Allah',
    page: 1,
    indopak: 'Segala puji bagi Allah',
    surah: 1,
    uthmani: 'الْحَمْدُ لِلَّهِ',
  ),
  const WordByWordEntity(
    ayah: 1,
    word: 2,
    audio: 'audio',
    bn: 'আল্হামদুলিল্লাহ',
    de: 'Alhamdulillah',
    en: 'Praise be to Allah',
    hijb: '1',
    juz: 1,
    indo: 'Segala puji bagi Allah',
    page: 1,
    indopak: 'Segala puji bagi Allah',
    surah: 1,
    uthmani: 'الْحَمْدُ لِلَّهِ',
  ),
];
