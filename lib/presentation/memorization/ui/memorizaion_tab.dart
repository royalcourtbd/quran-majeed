import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/customizable_feedback_widget.dart';

import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';

class MemorizationTab extends StatelessWidget {
  MemorizationTab({super.key});
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late final CollectionPresenter _collectionPresenter =
      locate<CollectionPresenter>();
  final MemorizationPresenter _presenter = locate<MemorizationPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(
        theme: theme,
        title: context.l10n.memorization,
        isRoot: true,
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icImportExport,
            width: eighteenPx,
            height: eighteenPx,

            ///TODO: Memoriation er local file er import export er function implement kara hoye gele ei onTap function ta uncomment kore dite hobe
            // onIconTap: () async {
            //    await _collectionPresenter.onImportExportButtonClicked(context);
            // },
          ),
          AppbarActionIcon(
            theme: theme,
            svgPath: _collectionPresenter.uiState.value.isAuthenticated
                ? SvgPath.icLogin
                : SvgPath.icLogout,
            width: twentyPx,
            height: twentyPx,
          ),
          gapW8,
        ],
      ),
      body: CustomizableFeedbackWidget(
        theme: theme,
        svgPath: SvgPath.icMosque,
        message: context.l10n.comingSoon,
      ),
      //TODO: Uncomment below code after implementing the memorization feature
      // body: PresentableWidgetBuilder(
      //   presenter: _presenter,
      //   builder: () {
      //     final MemorizationUiState uiState = _presenter.uiState.value;
      //     return memoList.isNotEmpty
      //         ? Column(
      //             children: [
      //               CustomSearchField(
      //                 theme: theme,
      //                 textEditingController: textEditingController,
      //                 hintText: "Search By Plan Name",
      //               ),
      //               gapH10,
      //               Expanded(
      //                 child: ListView.builder(
      //                   itemCount: memoList.length + 1,
      //                   itemBuilder: (context, index) {
      //                     if (index == memoList.length) {
      //                       return ShowNoMoreTextWidget(
      //                         title: 'Memorizatio',
      //                         theme: theme,
      //                       );
      //                     }
      //                     return MemorizationPlanCard(
      //                       memorizationPresenter: _presenter,
      //                       onTap: () => context
      //                           .navigatorPush(MemorizationDetailsPage()),
      //                       plan: memoList[index],
      //                       theme: theme,
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ],
      //           )
      //         : NoMemorizeWidget(
      //             onCreateButtonPressed: () async =>
      //                 await _presenter.onClickCreatePlanner(context));
      //   },
      // ),
      // floatingActionButton: memoList.isNotEmpty
      //     ? FloatingActionButton(
      //         onPressed: () async =>
      //             await _presenter.onClickCreatePlanner(context),
      //         backgroundColor: context.color.primaryColor,
      //         child: SvgPicture.asset(
      //           SvgPath.icAddMemorization,
      //           width: twentyPx,
      //         ),
      //       )
      //     : null,
    );
  }
}

///TODO: Memorization Er function implement kara hoye gele ei dummy data gula remove kore dite hobe
List memoList = [
  MemorizationEntity(
    planName: 'Plan Name',
    estimatedDay: 5,
    endAyah: 20,
    endSurah: 2,
    id: '1',
    startAyah: 1,
    notification: true,
    notificationTime: '10:00',
    startSurah: 1,
  ),
  MemorizationEntity(
    planName: 'Plan Name',
    estimatedDay: 30,
    endAyah: 20,
    endSurah: 2,
    id: '1',
    startAyah: 1,
    notification: true,
    notificationTime: '10:00',
    startSurah: 1,
  ),
  MemorizationEntity(
    planName: 'Plan Name',
    estimatedDay: 30,
    endAyah: 20,
    endSurah: 2,
    id: '1',
    startAyah: 1,
    notification: true,
    notificationTime: '10:00',
    startSurah: 1,
  ),

//
];
