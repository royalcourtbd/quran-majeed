import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_presenter.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_ui_state.dart';
import 'package:quran_majeed/presentation/on_boarding/ui/on_boarding_index_page.dart';

class OnBoardingFeaturesPage extends StatelessWidget {
  OnBoardingFeaturesPage({super.key});

  final OnBoardingPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      onInit: () async => await _presenter.fetchAndListenToData(context),
      builder: () {
        final OnBoardingUiState uiState = _presenter.uiState.value;
        final double progress = uiState.progressValue;
        final List<OnBoardingScreen> screenList = uiState.screenList;

        return FadeIn(
          child: Scaffold(
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _presenter.pageController,
              itemCount: screenList.length,
              onPageChanged: (int screenIndex) => _presenter.onScreenChanges(screenIndex, context),
              itemBuilder: (_, screenIndex) {
                return OnBoardingIndexPage(
                  key: ValueKey<int>(screenIndex),
                  theme: theme,
                  progress: progress,
                  screenIndex: screenIndex,
                  onGoNextPage: () async => _presenter.onTapNextButton(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
