import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_button_widget.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_presenter.dart';
import 'package:quran_majeed/presentation/last_read/presenter/last_read_ui_state.dart';

class InteractiveButton extends StatelessWidget {
  const InteractiveButton(
      {super.key,
      required this.theme,
      required this.uiState,
      required this.lastReadPresenter});

  final ThemeData theme;
  final LastReadUiState uiState;
  final LastReadPresenter lastReadPresenter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NavButtonWidget(
            onTap: () => lastReadPresenter.deleteSelectedLastReads(context),
            iconSvgPath: SvgPath.icDeleteOutline,
            widget: Text(
              context.l10n.delete,
              style: subduedBodyText(context),
            ),
          ),
        ),
        gapW5,
        Expanded(
          child: NavButtonWidget(
            onTap: () => lastReadPresenter.toggleSelectAllLastReadItems(),
            iconSvgPath: SvgPath.icCheckList,
            widget: Text(
              context.l10n.selectAll,
              style: subduedBodyText(context),
            ),
          ),
        ),
        gapW5,
        Expanded(
          child: NavButtonWidget(
            onTap: () => lastReadPresenter.toggleSelectionVisibility(),
            iconSvgPath: SvgPath.icClose,
            widget: Text(
              context.l10n.cancel,
              style: subduedBodyText(context),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle subduedBodyText(BuildContext context) {
    return context.quranText.lableExtraSmall!.copyWith(
      fontWeight: FontWeight.w400,
    );
  }
}
