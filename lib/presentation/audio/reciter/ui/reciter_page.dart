import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_presenter.dart';
import 'package:quran_majeed/presentation/audio/reciter/presenter/reciter_ui_state.dart';
import 'package:quran_majeed/presentation/audio/reciter/widgets/reciter_available_section.dart';
import 'package:quran_majeed/presentation/audio/reciter/widgets/reciter_download_section.dart';
import 'package:quran_majeed/presentation/common/section_header.dart';

class ReciterPage extends StatelessWidget {
  ReciterPage({super.key});
  late final ReciterPresenter reciterPresenter = locate();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: reciterPresenter,
        builder: () {
          final ReciterUiState uiState = reciterPresenter.currentUiState;
          if (uiState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              key: _globalKey,
              appBar:
                  CustomAppBar(title: context.l10n.selectReciter, theme: theme),
              body: Column(
                children: [
                  Expanded(
                    child: RoundedScaffoldBody(
                      isColored: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TODO: V2.0 te Search functionality korte hobe
                          // CustomSearchField(
                          //   theme: theme,
                          //   textEditingController: _searchController,
                          //   hintText: 'Search By Reciter Name',
                          // ),
                          // gapH20,
                          gapH10,
                          Expanded(
                            child: ListView(
                              padding: paddingH20,
                              shrinkWrap: true,
                              children: [
                                SectionHeader(
                                    title:
                                        '${context.l10n.downloaded} (${uiState.downloadedReciters!.length})',
                                    theme: theme),
                                gapH10,
                                ReciterDownloadedSection(
                                  theme: theme,
                                  reciters: uiState.downloadedReciters!,
                                  reciterPresenter: reciterPresenter,
                                ),
                                gapH20,
                                SectionHeader(
                                  title:
                                      '${context.l10n.availableReciters} (${uiState.availableRecitersForDownload!.length})',
                                  theme: theme,
                                ),
                                gapH5,
                                ReciterAvailableSection(
                                  reciters:
                                      uiState.availableRecitersForDownload!,
                                  theme: theme,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )

              // bottomNavigationBar: const ReciterBottomNavigation(),
              );
        });
  }
}
