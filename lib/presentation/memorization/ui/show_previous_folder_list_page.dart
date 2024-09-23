import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/show_no_more_text_widget.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';
import 'package:quran_majeed/presentation/memorization/ui/memorizaion_tab.dart';

class ShowPreviousFolderListPage extends StatelessWidget {
  ShowPreviousFolderListPage({super.key, required this.onSuggestionSelected});
  final void Function(String) onSuggestionSelected;
  final MemorizationPresenter _presenter = locate();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        title: 'Choose Plan',
      ),
      body: memoList.isEmpty
          ? ShowNoMoreTextWidget(title: 'Plane Here', theme: theme)
          : ListView.builder(
              itemCount: memoList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  splashColor: theme.cardColor.withOpacity(0.7),
                  hoverColor: theme.cardColor.withOpacity(0.7),
                  contentPadding: EdgeInsets.symmetric(horizontal: twentyPx),
                  leading: SvgImage(
                    SvgPath.icFolder,
                    fit: BoxFit.scaleDown,
                    color: theme.primaryColor,
                  ),
                  title: Text(
                    memoList[index].planName!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    //TODO: Implement on tap Selection of Plan folder
                    onSuggestionSelected(
                      _presenter.currentUiState.memorizations[index].planName!,
                    );
                    context.navigatorPop<void>();
                  },
                );
              },
            ),
    );
  }
}
