import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_presenter.dart';
import 'package:quran_majeed/presentation/collections/presenter/collection_ui_state.dart';
import 'package:quran_majeed/presentation/collections/ui/bookmarkes/bookmark_tab.dart';
import 'package:quran_majeed/presentation/collections/ui/components/log_out_dialog.dart';
import 'package:quran_majeed/presentation/collections/ui/notes/notes_tab.dart';
import 'package:quran_majeed/presentation/collections/ui/pins/pin_tab.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';

class CollectionTab extends StatefulWidget {
  const CollectionTab({super.key});

  @override
  State<CollectionTab> createState() => _CollectionTabState();
}

class _CollectionTabState extends State<CollectionTab>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  late final CollectionPresenter _presenter = locate<CollectionPresenter>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null;
    _bookmarkSearchController.dispose();
    _pinSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // final AppBarTheme appBarTheme = themeData.appBarTheme;
    // final TextTheme textTheme = themeData.textTheme;
    return PresentableWidgetBuilder(
        presenter: _presenter,
        onInit: () => _presenter.fetchCollections(),
        builder: () {
          final CollectionUiState uiState = _presenter.uiState.value;

          return Scaffold(
            key: _globalKey,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              title: context.l10n.collection,
              theme: themeData,
              isRoot: true,
              actions: [
                AppbarActionIcon(
                  svgPath: SvgPath.icImportExport,
                  theme: themeData,
                  onIconTap: () async =>
                      await _presenter.onImportExportButtonClicked(context),
                  width: eighteenPx,
                  height: eighteenPx,
                ),
                AppbarActionIcon(
                  svgPath: uiState.isAuthenticated
                      ? SvgPath.icLogin
                      : SvgPath.icLogout,
                  width: twentyPx,
                  height: twentyPx,
                  theme: themeData,
                  onIconTap: () async {
                    await _presenter.onCheckAuthentication(
                      onAuthenticated: () {
                        LogOutDialog.show(
                          context: context,
                          title: "Sign Out",
                          onRemove: _presenter.toggleSignIn,
                        );
                      },
                      onUnauthenticated: _presenter.toggleSignIn,
                    );
                  },
                ),
                gapW8
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: RoundedScaffoldBody(
                    isColored: true,
                    child: Column(
                      children: [
                        ///TODO: Uncomment this code when the collection tab feature is ready
                        /*    
                        isMobile ? gapH18 : gapH10,
                        Container(
                          height: isMobile ? 12.percentWidth : 7.percentWidth,
                          margin: EdgeInsets.symmetric(horizontal: isMobile ? fifteenPx : tenPx),
                          decoration: BoxDecoration(
                            color: themeData.cardColor,
                            borderRadius: isMobile ? radius10 : radius6,
                          ),
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            onTap: (index) {
                              if (index != 0) {
                                showComingSoonMessage(context: context);
                                _tabController?.animateTo(0);
                              }
                            },
                            indicatorPadding: EdgeInsets.symmetric(
                              horizontal: isMobile ? fourPx : twoPx,
                              vertical: isMobile ? fivePx : threePx,
                            ),
                            indicator: BoxDecoration(
                              color: themeData.colorScheme.scrim,
                              borderRadius: isMobile ? radius8 : radius5,
                            ),
                            unselectedLabelColor: textTheme.bodyMedium?.color,
                            labelColor: textTheme.labelSmall?.color,
                            indicatorColor: appBarTheme.backgroundColor,
                            unselectedLabelStyle: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500, fontSize: isMobile ? thirteenPx : eightPx),
                            labelStyle: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold, fontSize: isMobile ? thirteenPx : eightPx),
                            labelPadding: EdgeInsets.only(top: threePx),
                            tabs: _tabs,
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                        ),

                        if (isMobile) gapH10,
                        */
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: _tabViews,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _onInit() {
    _tabController = TabController(length: 3, vsync: this);

    _bookmarkSearchController = TextEditingController();
    _pinSearchController = TextEditingController();

    _tabController?.addListener(() => _clearTextFields(context));
    _noteSearchController = TextEditingController();
  }

  late final List<Widget> _tabViews = [
    BookmarkTab(
      editingController: _bookmarkSearchController,
      presenter: _presenter,
    ),
    PinTab(editingController: _pinSearchController),
    NoteTab(
      editingController: _noteSearchController,
    ),
  ];

  late final TextEditingController _bookmarkSearchController;
  late final TextEditingController _pinSearchController;
  late final TextEditingController _noteSearchController;

  Future<void> _clearTextFields(BuildContext context) async {
    _bookmarkSearchController.clear();
    _pinSearchController.clear();
    // KeyboardService.dismiss(context: context);
  }
}
