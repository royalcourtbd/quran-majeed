import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';

class QuranTabContentWidget extends StatelessWidget {
  final int currentTabIndex;
  final HomePresenter homePresenter;

  const QuranTabContentWidget({
    super.key,
    required this.currentTabIndex,
    required this.homePresenter,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: homePresenter.getContentWidget(currentTabIndex),
    );
  }
}
