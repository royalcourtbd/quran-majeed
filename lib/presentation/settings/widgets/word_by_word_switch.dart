import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/adaptive_selection_box.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/simple_switch.dart';
import 'package:quran_majeed/presentation/settings/widgets/tab_setting_header_widget.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_language_selection_bottom_sheet/word_by_word_bottom_sheet.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_presenter.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_ui_state.dart';

class WordByWordSwitch extends StatelessWidget {
  WordByWordSwitch({
    super.key,
    required this.settingPresenter,
    required this.theme,
  });
  final SettingsPresenter settingPresenter;
  final ThemeData theme;
  late final WordByWordPresenter _wordByWordPresenter =
      locate<WordByWordPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: settingPresenter,
      builder: () {
        final WordByWordUiState wordByWordUiState =
            _wordByWordPresenter.currentUiState;

        return SettingsContainer(
          child: Column(
            children: [
              isMobile
                  ? SettingsCardHeader(
                      title: context.l10n.wordByWord,
                      svgPath: SvgPath.icMenuBoard,
                      trailing: SimpleSwitch(
                        initialValue: settingPresenter
                                .uiState.value.settingsState?.showWordByWord ??
                            false,
                        onChanged: (value) => settingPresenter
                            .toggleShowWordByWord(showWordByWord: value),
                      ),
                    )
                  : TabSettingHeaderWidget(
                      title: context.l10n.wordByWord,
                    ),
              isMobile ? gapH15 : gapH10,
              AdaptiveSelectionBox(
                boxTitle: wordByWordUiState.selectedLanguage,
                onTap: () => WordByWordBottomSheet.show(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
