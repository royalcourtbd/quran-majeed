import 'package:flutter/material.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/audio/reciter/ui/reciter_page.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/ui/config_options_page.dart';
import 'package:quran_majeed/presentation/settings/widgets/adaptive_selection_box.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_container.dart';
import 'package:quran_majeed/presentation/settings/widgets/tab_setting_header_widget.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class GeneralSettingsCard extends StatelessWidget {
  GeneralSettingsCard({
    super.key,
    required this.settingPresenter,
    this.isFromSettingsPage = false,
  });

  final bool isFromSettingsPage;

  final SettingsPresenter settingPresenter;
  late final TranslationPresenter translationPresenter =
      locate<TranslationPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
        presenter: settingPresenter,
        builder: () {
          return SettingsContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isMobile
                    ? SettingsCardHeader(
                        title: context.l10n.generalSettings,
                        svgPath: SvgPath.icSettingFill,
                      )
                    : TabSettingHeaderWidget(
                        title: context.l10n.generalSettings,
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isFromSettingsPage ? thirtySevenPx : 0),
                  child: Column(
                    children: [
                      //TODO: App Language is not available in the current version
                      isMobile ? gapH18 : gapH5,
                      AdaptiveSelectionBox(
                        title: context.l10n.appLanguage,
                        boxTitle: settingPresenter.appLanguageList.entries
                            .toList()[
                                settingPresenter.languageSelectIndex.value]
                            .value,
                        onTap: () => context.navigatorPush(
                          ConfigOptionsPage(
                            title: context.l10n.appLanguage,
                            presenter: settingPresenter,
                            configList: settingPresenter.appLanguageList,
                          ),
                        ),
                      ),
                      isMobile ? gapH18 : gapH10,
                      AdaptiveSelectionBox(
                        title: context.l10n.translation,
                        boxTitle: settingPresenter.getSelectedTranslationName(),
                        onTap: () {
                          context.navigatorPush(DownloadPage(
                            presenter: translationPresenter,
                            title: context.l10n.translation,
                            isTafseer: false,
                          ));
                        },
                      ),
                      isMobile ? gapH18 : gapH10,
                      AdaptiveSelectionBox(
                        title: context.l10n.tafseer,
                        boxTitle: settingPresenter.getSelectedTafseerName(),
                        onTap: () {
                          late final TafseerPresenter tafseerPresenter =
                              locate<TafseerPresenter>();
                          context.navigatorPush(
                            DownloadPage(
                              presenter: tafseerPresenter,
                              title: context.l10n.tafseer,
                              isTafseer: true,
                            ),
                          );
                        },
                      ),
                      isMobile ? gapH18 : gapH10,

                      AdaptiveSelectionBox(
                        title: context.l10n.defaultAudio,
                        boxTitle: settingPresenter.getSelectedReciterName(),
                        onTap: () => context.navigatorPush(ReciterPage()),
                      ),
                      if (!isMobile) gapH10,
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
