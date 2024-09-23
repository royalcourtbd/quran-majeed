import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/src/scrollable_positioned_list.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/data/model_class/dua_category_model.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/custom_header_section_widget.dart';
import 'package:quran_majeed/presentation/dua/widget/dua_details_page_ayah_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';

class DuaDetailsPage extends StatelessWidget {
  final DuaCategoryModel category;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late final AyahPresenter _ayahPresenter = locate();
  final ItemScrollController _scrollController = ItemScrollController();

  DuaDetailsPage({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: MiniSettingsDrawer(),
      appBar: CustomAppBar(
        theme: theme,
        title: 'Duas',
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icSettings,
            onIconTap: () => scaffoldKey.currentState!.openEndDrawer(),
          ),
          gapW8
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomHeaderSectionWidget(
                  title: category.categoryTitle,
                  theme: theme,
                  isDuaPage: true,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController.scrollController,
                    itemCount: 5,
                    itemBuilder: (context, ayahIndex) {
                      return DuaDetailsPageAyahContainer(
                        index: ayahIndex,
                        surahID: 1,
                        ayahNumber: ayahIndex + 1,
                        ayahTopRowTitle: category.categoryTitle,
                        sectionIcon: SvgPicture.asset(
                          SvgPath.icAllah,
                          height: twentyFourPx,
                          colorFilter: buildColorFilter(theme.primaryColor),
                        ),
                        wordData: listOfWordData,
                        onClickMore: () => _ayahPresenter.onClickMoreButton(
                          context: context,
                          surahID: 1,
                          ayahID: 1,
                          listOfWordByWordEntity: [],
                          isDirectButtonVisible: false,
                          isAddMemorizationButtonVisible: true,
                          isAddCollectionButtonVisible: true,
                          isPlayButtonVisible: false,
                          isCopyAyahButtonVisible: false,
                        ),
                        ayahPresenter: _ayahPresenter,
                        duaReference: 'Al-Fatihah 1:1',
                        theme: theme,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///Dua Page er function kora hole ei code gulo delete kore dite hobe
List<WordByWordEntity> listOfWordData = [
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
