import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_ui_state.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_presenter.dart';
import 'package:quran_majeed/presentation/last_read/widget/inter_active_button.dart';
import 'package:quran_majeed/presentation/last_read/widget/last_read_list.dart';

class LastReadPage extends StatelessWidget {
  LastReadPage({
    super.key,
  });

  late final LastReadPresenter _lastReadPresenter = locate();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
      presenter: _lastReadPresenter,
      onInit: () {
        _lastReadPresenter.getLastReadList();
      },
      builder: () {
        final LastReadUiState uiState = _lastReadPresenter.uiState.value;
        final List<LastReadEntity> lastReadList = uiState.lastReadList;

        return Scaffold(
          appBar: CustomAppBar(
            theme: theme,
            isRoot: false,
            title: context.l10n.lastRead,
            actions: [
              AppbarActionIcon(
                theme: theme,
                svgPath: SvgPath.icEdit,
                width: twentyTwoPx,
                height: twentyTwoPx,
                onIconTap: () => _lastReadPresenter.toggleSelectionVisibility(),
              ),
              gapW8,
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: RoundedScaffoldBody(
                  isColored: true,
                  child: ListView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      gapH10,
                      LastReadList(
                        lastReadList: lastReadList,
                      ),
                      gapH15,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          context.l10n.noMoreAyah,
                          style: context.quranText.lableExtraSmall!.copyWith(
                            color: context.color.primaryColor.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      gapH15,
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: _lastReadPresenter.uiState.value.checkBox,
            child: FadeIn(
              duration: const Duration(milliseconds: 700),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: twentyPx,
                  vertical: twentyPx,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(twentyPx),
                  ),
                  color: Theme.of(context).cardColor,
                ),
                child: InteractiveButton(
                  theme: theme,
                  uiState: uiState,
                  lastReadPresenter: _lastReadPresenter,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
