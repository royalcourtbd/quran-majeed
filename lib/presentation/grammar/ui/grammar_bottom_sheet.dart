import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';

import 'package:quran_majeed/domain/entities/word_by_word_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/box_decoration.dart';
import 'package:quran_majeed/presentation/common/buttons/two_way_action_button.dart';
import 'package:quran_majeed/presentation/grammar/ui/grammar_page.dart';
import 'package:quran_majeed/presentation/grammar/widget/arabic_word_widget.dart';
import 'package:quran_majeed/presentation/grammar/widget/show_root_word_widget.dart';
import 'package:quran_majeed/presentation/grammar/widget/title_section_widget.dart';
import 'package:quran_majeed/presentation/grammar/widget/word_parts_of_speech_widget.dart';

class GrammarBottomSheet extends StatelessWidget {
  final List<WordByWordEntity> wordList;
  final int selectedWordIndex;
  GrammarBottomSheet(
      {super.key, required this.wordList, required this.selectedWordIndex});

  static Future<void> show({
    required BuildContext context,
    required List<WordByWordEntity> wordList,
    required int selectedWordIndex,
  }) async {
    final GrammarBottomSheet grammarBottomSheet = await Future.microtask(
      () => GrammarBottomSheet(
        key: const Key("GrammarBottomSheet"),
        wordList: wordList,
        selectedWordIndex: selectedWordIndex,
      ),
    );
    if (context.mounted) {
      await context.showBottomSheet<void>(grammarBottomSheet, context);
    }
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: decorateBottomSheet(context),
      height: QuranScreen.width * 1.05,
      child: Column(
        children: [
          gapH20,
          TitleSectionWidget(
            pageController: _pageController,
          ),
          gapH15,
          Flexible(
            child: PageView.builder(
              itemCount: wordList.length,
              reverse: true,
              controller: _pageController,
              onPageChanged: (index) {},
              itemBuilder: (context, index) {
                return Wrap(
                  children: [
                    Column(
                      children: [
                        ArabicWordWidget(
                          theme: theme,
                        ),
                        gapH25,
                        WordPartsOfSpeechWidget(
                          theme: theme,
                        ),
                        gapH12,
                        Text(
                          'Meaning of this word need to implement',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        gapH35,
                        ShowRootWordWidget(
                          title: 'Root Word',
                          subtitle: "أنتما",
                          theme: theme,
                        ),
                        gapH10,
                        ShowRootWordWidget(
                          title: 'Lemma/Derivative',
                          subtitle: "أنتما",
                          theme: theme,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: twentyPx),
            child: TwoWayActionButton(
              theme: theme,
              svgPictureForCancelButton: SvgImage(
                SvgPath.icMaximize,
                width: twentyFourPx,
                height: twentyFourPx,
                color: context.color.primaryColor,
              ),
              svgPictureForOkButton: SvgImage(
                SvgPath.icPlayCircle,
                width: twentyFourPx,
                height: twentyFourPx,
                color: context.color.primaryColor,
              ),
              submitButtonTitle: 'Play Audio',
              cancelButtonTitle: 'Click for More',
              onSubmitButtonTap: () {},
              onCancelButtonTap: () => context.navigatorPush(GrammarPage()),
              submitButtonBgColor: context.color.primaryColor.withOpacity(
                0.12,
              ),
              submitButtonTextColor: context.color.primaryColor,
            ),
          ),
          gapH25,
        ],
      ),
    );
  }
}
