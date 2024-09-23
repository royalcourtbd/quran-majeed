import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_bar/audio_player_widget.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/text_field/custom_search_field.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';
import 'package:quran_majeed/presentation/memorization/widgets/memoraization_ayah_container.dart';

class MemorizationDetailsPage extends StatelessWidget {
  MemorizationDetailsPage({super.key});

  late final AyahPresenter _ayahPresenter = locate();

  final TextEditingController _textEditingController = TextEditingController();
  late final MemorizationPresenter _memorizationPresenter = locate();
  late final AudioPresenter _audioPresenter = locate<AudioPresenter>();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: _memorizationPresenter,
      builder: () {
        return Scaffold(
          key: globalKey,
          appBar: CustomAppBar(
            theme: theme,
            title: 'Name Of Plan',
            actions: [
              GestureDetector(
                onTap: () {
                  RemoveDialog.show(
                    onRemove: () async {},
                    context: context,
                    title: 'Memorization',
                  );
                },
                child: SvgPicture.asset(
                  SvgPath.icEdit,
                ),
              ),
              gapW12
            ],
          ),
          body: Column(
            children: [
              CustomSearchField(
                theme: theme,
                textEditingController: _textEditingController,
                hintText: "Search By Surah Name",
              ),
              gapH10,
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, ayahIndex) {
                    return MemorizationAyahContainer(
                      index: ayahIndex,
                      surahID: 1,
                      ayahNumber: ayahIndex + 1,
                      ayahTopRowTitle: 'Al-Fatihah 1:1',
                      readIcon: SvgPicture.asset(
                        ayahIndex == 2 ? SvgPath.icRead : SvgPath.icUnRead,
                        width: isMobile ? sixteenPx : fivePx,
                        colorFilter:
                            buildColorFilter(context.color.primaryColor),
                      ),
                      wordData: listOfWordData,
                      onClickMore: () {
                        _memorizationPresenter
                            .onClickMemoraizationPageMoreButton(
                          context: context,
                          surahID: 1,
                          ayahID: 1,
                          listOfWordByWordEntity: [],
                          isDirectButtonVisible: true,
                          idAddCollectionButtonVisible: true,
                          isAddMemorizationButtonVisible: false,
                        );
                      },
                      ayahPresenter: _ayahPresenter,
                      theme: theme,
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: _memorizationPresenter.uiState.value.isPlaying
              ? SizedBox(
                  height: kBottomNavigationBarHeight + 12.percentWidth,
                  child: AudioPlayerWidget(
                    audioPresenter: _audioPresenter,
                    progress: .5,
                    theme: theme,
                    bottomNavigationBarHeight: kBottomNavigationBarHeight,
                    isFromAyahDetail: false,
                  ),
                )
              : null,
        );
      },
    );
  }
}

///Memorization function kora hole ei code gulo delete kore dite hobe
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
