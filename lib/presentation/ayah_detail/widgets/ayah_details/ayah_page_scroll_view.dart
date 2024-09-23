import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_content_widget.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';

class AyahPageScrollView extends StatelessWidget {
  const AyahPageScrollView({
    super.key,
    required this.ayahPresenter,
    required this.uiState,
  });
  final AyahPresenter ayahPresenter;
  final AyahViewUiState uiState;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 114, // Number of Surahs in the Quran is constant
      controller: ayahPresenter.pageController,
      reverse: true,
      itemBuilder: (context, index) {
        return RoundedScaffoldBody(
          isColored: true,
          child: AyahContentWidget(
            pageIndex: index,
            ayahPresenter: ayahPresenter,
            uiState: uiState,
          ),
        );
      },
      onPageChanged: (value) {
        ayahPresenter.updateCurrentPageIndex(value);
      },
    );
  }
}
