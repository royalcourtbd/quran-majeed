import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/presentation/on_boarding/model/language_model.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_presenter.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/language_selection_description.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/language_selection_list_item.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_features_next_button.dart';

class LanguageSelectionList extends StatelessWidget {
  LanguageSelectionList({
    super.key,
    required this.screenIndex,
    required this.onGoNextPage,
    required this.theme,
  });

  final int screenIndex;
  final VoidCallback onGoNextPage;
  final ThemeData theme;

  final OnBoardingPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LanguageSelectionDescription(theme: theme),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: tenPx),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _presenter.currentUiState.languages.languages!.length,
                  itemBuilder: (context, index) {
                    final Languages language = _presenter.currentUiState.languages.languages![index];

                    return LanguageSelectionListItem(
                      theme: theme,
                      presenter: _presenter,
                      language: language,
                      index: index,
                    );
                  },
                ),
              ),
            ),
            OnboardingButton(
              onPressed: onGoNextPage,
              screenIndex: screenIndex,
              theme: theme,
            )
          ],
        );
      },
    );
  }
}
