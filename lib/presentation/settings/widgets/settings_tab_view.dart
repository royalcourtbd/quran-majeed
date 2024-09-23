import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';
import 'package:quran_majeed/presentation/settings/widgets/appearance_settings_card.dart';
import 'package:quran_majeed/core/utility/custom_divider.dart';
import 'package:quran_majeed/presentation/settings/widgets/notification_settings_card.dart';
import 'package:quran_majeed/presentation/settings/widgets/settings_card_header.dart';
import 'package:quran_majeed/presentation/settings/widgets/word_by_word_switch.dart';
import '../widgets/content_settings_card.dart';
import '../widgets/font_settings_card.dart';
import '../widgets/general_settings_card.dart';

class SettingsTabView extends StatelessWidget {
  SettingsTabView({
    super.key,
    required this.theme,
    required this.settingPresenter,
  });

  final SettingsPresenter settingPresenter;
  final ThemeData theme;
  final ScrollController _scrollController = ScrollController();

  void scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  final List<GlobalKey> _keys = List.generate(11, (index) => GlobalKey());

  final List<Widget> settingItems = [];

  @override
  Widget build(BuildContext context) {
    settingItems.addAll([
      GeneralSettingsCard(
        key: _keys[0],
        isFromSettingsPage: true,
        settingPresenter: settingPresenter,
      ),
      BuildDivider(
        theme: theme,
      ),
      ContentSettingsCard(
        key: _keys[2],
        isFromSettingsPage: true,
        settingPresenter: settingPresenter,
      ),
      BuildDivider(
        theme: theme,
      ),
      FontSettingsCard(
        key: _keys[4],
        settingPresenter: settingPresenter,
        isFromSettingsPage: true,
      ),
      BuildDivider(
        theme: theme,
      ),
      AppearanceSettingsCard(
        key: _keys[6],
        settingPresenter: settingPresenter,
        isFromSettingsPage: true,
      ),
      BuildDivider(
        theme: theme,
      ),
      WordByWordSwitch(
        key: _keys[8],
        settingPresenter: settingPresenter,
        theme: theme,
      ),
      BuildDivider(
        theme: theme,
      ),
      NotificationSettingsCard(
        key: _keys[10],
        isFromSettingsPage: true,
        presenter: settingPresenter,
      ),
      gapH50
    ]);

    return PresentableWidgetBuilder(
      presenter: settingPresenter,
      builder: () {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: padding8,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => scrollToKey(_keys[0]),
                      child: SettingsCardHeader(
                        title: context.l10n.generalSettings,
                        svgPath: SvgPath.icSettingFill,
                        isSelected: settingPresenter.checkIfSelected(index: 0),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollToKey(_keys[2]),
                      child: SettingsCardHeader(
                        title: context.l10n.viewSettings,
                        svgPath: SvgPath.icViews,
                        isSelected: settingPresenter.checkIfSelected(index: 2),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollToKey(_keys[4]),
                      child: SettingsCardHeader(
                        title: context.l10n.fontSettings,
                        svgPath: SvgPath.icShapes,
                        isSelected: settingPresenter.checkIfSelected(index: 4),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollToKey(_keys[6]),
                      child: SettingsCardHeader(
                        title: context.l10n.appearance,
                        svgPath: SvgPath.icAppearance,
                        isSelected: settingPresenter.checkIfSelected(index: 6),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollToKey(_keys[8]),
                      child: SettingsCardHeader(
                        title: context.l10n.wordByWord,
                        svgPath: SvgPath.icMenuBoard,
                        isSelected: settingPresenter.checkIfSelected(index: 8),
                      ),
                    ),
                    InkWell(
                      onTap: () => scrollToKey(_keys[10]),
                      child: SettingsCardHeader(
                        title: context.l10n.notificationSettings,
                        svgPath: SvgPath.icNotificationFill,
                        isSelected: settingPresenter.checkIfSelected(index: 10),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 1,
              color: theme.dividerColor,
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(left: tenPx, right: tenPx),
                child: Column(
                  children: settingItems,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


//nicher code ta tab view er jonno kora hoise, eta kaje lagte pare



// class SettingsTabView extends StatelessWidget {
//   SettingsTabView({
//     super.key,
//     required this.theme,
//     required this.settingPresenter,
//   });

//   final SettingPresenter settingPresenter;
//   final ThemeData theme;

//   final ItemScrollController itemScrollController = ItemScrollController();
//   final ScrollOffsetController scrollOffsetController =
//       ScrollOffsetController();
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   final ScrollOffsetListener scrollOffsetListener =
//       ScrollOffsetListener.create();

//   void scrollTo(int index) {
//     settingPresenter.selectIndex(index: index);
//     if (itemScrollController.scrollController!.position.pixels <
//             itemScrollController.scrollController!.position.maxScrollExtent ||
//         (index < 6)) {
//       itemScrollController.scrollTo(
//           index: index,
//           duration:  Duration(milliseconds: 300),
//           curve: Curves.easeInOut);
//     }
//   }

//   final List<Widget> settingItems = [
//     GeneralSettingsCard(
//       isFromSettingsPage: true,
//       settingPresenter: settingPresenter,
//     ),
//      BuildDivider(),
//     ContentSettingsCard(
//       isFromSettingsPage: true,
//       settingPresenter: _settingPresenter,
//     ),
//      BuildDivider(),
//     FontSettingsCard(
//       settingPresenter: _settingPresenter,
//       isFromSettingsPage: true,
//     ),
//      BuildDivider(),
//     AppearanceSettingsCard(
//       settingPresenter: _settingPresenter,
//       isFromSettingsPage: true,
//     ),
//      BuildDivider(),
//     WordByWordSwitch(
//       settingPresenter: _settingPresenter,
//       theme: theme,
//     ),
//      BuildDivider(),
//     NotificationSettingsCard(
//       isFromSettingsPage: true,
//     ),
//     gapH50
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return PresentableWidgetBuilder(
//       presenter: settingPresenter,
//       builder: () {
//         return Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: padding8,
//                 child: Column(
//                   children: [
//                     InkWell(
//                       onTap: () => scrollTo(0),
//                       child: SettingsCardHeader(
//                         title: 'General Settings',
//                         svgPath: SvgPath.icSettingFill,
//                         isSelected: settingPresenter.checkIfSelected(index: 0),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => scrollTo(2),
//                       child: SettingsCardHeader(
//                         title: "View Settings",
//                         svgPath: SvgPath.icViews,
//                         isSelected: settingPresenter.checkIfSelected(index: 2),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => scrollTo(4),
//                       child: SettingsCardHeader(
//                         title: 'Font Settings',
//                         svgPath: SvgPath.icShapes,
//                         isSelected: settingPresenter.checkIfSelected(index: 4),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => scrollTo(6),
//                       child: SettingsCardHeader(
//                         title: "Appearance",
//                         svgPath: SvgPath.icAppearance,
//                         isSelected: settingPresenter.checkIfSelected(index: 6),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => scrollTo(8),
//                       child: SettingsCardHeader(
//                         title: context.l10n.wordByWord,
//                         svgPath: SvgPath.icMenuBoard,
//                         isSelected: settingPresenter.checkIfSelected(index: 8),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => scrollTo(10),
//                       child: SettingsCardHeader(
//                         title: "Notification Settings",
//                         svgPath: SvgPath.icNotificationFill,
//                         isSelected: settingPresenter.checkIfSelected(index: 10),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             VerticalDivider(
//               width: 1,
//               color: theme.dividerColor,
//             ),
//             Expanded(
//               flex: 3,
//               child: ScrollablePositionedList.builder(
//                 scrollOffsetController: scrollOffsetController,
//                 itemScrollController: itemScrollController,
//                 itemPositionsListener: itemPositionsListener,
//                 scrollOffsetListener: scrollOffsetListener,
//                 padding: EdgeInsets.only(left: tenPx, right: tenPx),
//                 shrinkWrap: true,
//                 itemCount: settingItems.length,
//                 itemBuilder: (context, index) {
//                   return settingItems[index];
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


// ===========