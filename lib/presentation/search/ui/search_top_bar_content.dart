import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/buttons/submit_button.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';
import 'package:quran_majeed/presentation/search/presenter/search_presenter.dart';
import 'package:quran_majeed/presentation/search/ui/search_result_page.dart';
import 'package:quran_majeed/presentation/search/widgets/search_option_list.dart';
import 'package:quran_majeed/presentation/search/widgets/recent_search_chips.dart';
import 'package:quran_majeed/presentation/search/widgets/section_title.dart';
import 'package:quran_majeed/presentation/search/widgets/selected_section.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class SearchTopBarContent extends StatelessWidget {
  SearchTopBarContent({
    super.key,
    required this.searchPresenter,
  });
  late final SearchPresenter searchPresenter;

  final TextEditingController _searchEditingController =
      TextEditingController();
  late final TranslationPresenter translationPresenter = locate();
  late final TafseerPresenter tafseerPresenter = locate();

  //TODO: Use Demo data for UI
  final List<String> recentSearches = [
    'Allah',
    'بِسْمِ',
    'ٱلْحَمْدُلِلَّهِرَبِّٱلْعَٰلَمِينَ',
    'praise is for',
    'existence of the',
    'আল্লাহ',
    'worlds',
    'যিনি তোমাদেরকে সৃষ্টি করেছেন',
    'tini bolen',
    'এক নফ্স থেকে',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      key: const Key('TopBarContent'),
      presenter: searchPresenter,
      builder: () {
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            key: const Key('TopBarContentContainer'),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(twelvePx),
              ),
            ),
            child: SingleChildScrollView(
              key: const Key('TopBarContentSingleChildScrollView'),
              child: Padding(
                padding: padding20,
                child: Column(
                  children: [
                    gapH30,
                    Text(
                      'Quran Search',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH20,
                    SizedBox(
                      height: fortyFivePx,
                      child: UserInputField(
                        textEditingController: _searchEditingController,
                        hintText: 'Search By Words',
                        borderRadius: radius10,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: sixteenPx,
                        ),
                      ),
                    ),
                    gapH20,
                    if (recentSearches.isNotEmpty) ...[
                      Row(
                        key: const Key('RecentSearchRow'),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SectionTitle(
                            theme: theme,
                            title: 'Recent Search',
                          ),
                          SectionTitle(
                            theme: theme,
                            title: 'Clear All',
                            onTap: () {
                              //TODO: implement Clear All Recent Searches functionality
                            },
                            titleStyle:
                                context.quranText.lableExtraSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color:
                                  context.color.primaryColor.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                      gapH8,
                      Align(
                        key: const Key('RecentSearchAlign'),
                        alignment: Alignment.centerLeft,
                        child: RecentSearchChips(
                          key: const Key('RecentSearchChips'),
                          recentSearches: recentSearches,
                          theme: theme,
                        ),
                      ),
                      gapH20,
                    ],
                    SectionTitle(
                        key: const Key('SearchIn'),
                        theme: theme,
                        title: 'Search In'),
                    SearchOptionList(
                      key: const Key('SearchOptionList'),
                      theme: theme,
                      presenter: searchPresenter,
                    ),
                    gapH5,
                    if (searchPresenter.uiState.value.searchInGroupValue ==
                        0) ...[
                      SelectedSection(
                        key: const Key('SelectedSection'),
                        theme: theme,
                        sectionTitle: 'Choose Translation',
                        sectionNote: '(Select upto 3)',
                        boxTitle: 'Select Translation',
                        //TODO: Ei Ontap e click korle download page e TranslationPresenter er initiateDownload func e jabe
                        onTap: () => context.navigatorPush<void>(
                          DownloadPage(
                            presenter: translationPresenter,
                            title: context.l10n.translation,
                            isTafseer: false,
                          ),
                        ),
                      ),
                    ],
                    if (searchPresenter.uiState.value.searchInGroupValue ==
                        1) ...[
                      SelectedSection(
                        theme: theme,
                        sectionTitle: 'Choose Tafseer',
                        sectionNote: '(Select upto 3)',
                        boxTitle: 'Select Tafseer',
                        onTap: () => context.navigatorPush(
                          DownloadPage(
                            presenter: tafseerPresenter,
                            title: 'Tafseer',
                            isTafseer: true,
                          ),
                        ),
                      ),
                    ],
                    gapH20,
                    SubmitButton(
                      title: 'Search Now',
                      buttonColor: theme.primaryColor,
                      textColor: Colors.white,
                      theme: theme,
                      onTap: () {
                        context.navigatorPush(SearchResultPage());
                        //TODO: Implement Search Now Button
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
