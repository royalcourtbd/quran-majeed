import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';

class AyahDetailsPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AyahDetailsPageAppBar({
    super.key,
    required this.ayahPresenter,
    required this.scaffoldKey,
    required this.theme,
  });

  final AyahPresenter ayahPresenter;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: ayahPresenter.getSurahName(context),
      dropDownPath: SvgPath.icArrowDown,
      theme: theme,
      onTap: () => ayahPresenter.onSurahListTap(
        context: context,
        isDoneButtonEnabled: false,
        isJumpToAyahBottomSheet: true,
        onSubmit: () async {
          context.navigatorPop();
          await ayahPresenter.jumpToDesiredLocation(
              initialPageIndex: ayahPresenter.currentUiState.selectedSurahIndex,
              initialAyahIndex: ayahPresenter.currentUiState.selectedAyahIndex);
        },
        onAyahSelected: (ayahId) => ayahPresenter.onSelectAyah(ayahId),
        onSurahSelected: (surahId) => ayahPresenter.onSelectSurah(surahId),
        title: context.l10n.jumpToAyah,
      ),
      actions: [
        AppbarActionIcon(
          onIconTap: () => scaffoldKey.currentState!.openEndDrawer(),
          svgPath: SvgPath.icSettings,
          theme: theme,
        ),
        gapW8,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
