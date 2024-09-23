import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/home/presenter/home_presenter.dart';
import 'package:quran_majeed/presentation/home/widgets/suah_list_view.dart';

class ShaneNuzulPage extends StatelessWidget {
  ShaneNuzulPage({super.key});

  final TextEditingController searchTextEditingController =
      TextEditingController();
  late final HomePresenter homePresenter = locate<HomePresenter>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        theme: theme,
        title: 'Shane Nuzul',
      ),
      body: Column(
        children: [
          Padding(
            padding: padding20,
            child: SizedBox(
              height: fortyFivePx,
              child: UserInputField(
                textEditingController: searchTextEditingController,
                hintText: 'Search By Surah Name',
                borderRadius: radius10,
                contentPadding: EdgeInsets.symmetric(horizontal: twentyPx),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SurahListView(
                surahList: homePresenter.uiState.value.surahList,
                isHomeSurahList: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
